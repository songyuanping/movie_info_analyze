# -*- coding: utf-8 -*-
"""
Created on Thu Mar 12 16:11:50 2020

@author: Administrator
"""
import re
import time
import emoji
import string
import random
import pymysql
import requests
from lxml import etree
from fake_useragent import UserAgent

class CommentSpider:

    def __init__(self):
        self.loginURL = "https://accounts.douban.com/j/mobile/login/basic"
        self.data = {
                    "ck": "",
                    "name": "",
                    "password": "",
                    "remember": "false",
                    "ticket": ""
                    }
        self.session = requests.Session()

    def login(self, userName, password):
        self.data["name"] = userName
        self.data["password"] = password
        header= {"User-Agent": UserAgent().chrome}
        r = self.session.post(url=self.loginURL, headers=header,data=self.data)
        # 可能状态码是200但登录失败（比如弹出验证码），以后加以解决
        if r.status_code == 200:  
            print("登录成功！")
        else:
            print("登录失败！")

    def download(self,movieUrl,movieName,pages=10):
        #连接数据库及光标
        connection=pymysql.connect(host='localhost',user='root',password='123456',db='movie_play',port=3306,charset='utf8')
        cursor=connection.cursor()
        #构造爬取电影评论信息的正则表达式
        pattern = re.compile(
                 #用户昵称
                 '<div.*?="avatar".*?<a.*?="(.*?)".*?</a>' +  
                 #评论赞同数
                 '.*?<div.*?="comment.*?<span.*?="votes">(.*?)</span>' +
                 #用户评分
                 '.*?<span.*?="allstar(.*?)rating".*?</span>'+
                 #评论时间
                 '.*?<span.*?="comment-time.*?title="(.*?)">'+
                 #用户评论
                 '.*?<span.*?"short">(.*?)</span>',re.S)
        for i in range(0, pages):
            index = i*20
            commentsURL = str(movieUrl)+"comments?start="+str(index)+"&limit=20&sort=new_score&status=P"
            header= {"User-Agent": UserAgent().chrome}
            response = self.session.get(commentsURL,headers=header)
            #检查服务器返回状态是否正确
            if response.status_code==200:
                
                page_code=response.text
                commentsItems=re.findall(pattern,page_code)
                for item in commentsItems:
                    moviename=str(movieName.strip())
                    #用户昵称中的表情符号
                    username=str(item[0].strip())
                    username=emoji.demojize(username)
                    #去除评论内容中的表情符号
                    comment=str(item[4].strip())
                    comment=emoji.demojize(comment)
                    praise=item[1].strip()
                    commenttime=item[3].strip()
                    score=item[2].strip()
                    #按对应字段写入数据库
                    cursor.execute("insert ignore into t_comment(moviename,username,comment,praise,datetime,score) values(%s,%s,%s,%s,%s,%s)",
                           (moviename,username,comment,praise,commenttime,score)) 
                    
                #让爬虫睡眠一段时间
                connection.commit()
                time.sleep(3)
                print("下载'%s' 第%s页影评数据完毕！"%(movieName,i+1))
            else:
                print("'%s' 影评数据获取失败！"%movieName)
        #将修改提交到数据库
        connection.commit()
        #关闭与数据库的连接
        connection.close()
        print("'%s' 影评数据下载完成！"%movieName)      
        
#爬取豆瓣前250部电影信息的爬虫
class MovieSpider:
        
    def __init__(self):
        self.count=0
        self.start = 0
        self.param = '&filter'
        #电影信息列表
        self.movieList = []
        #电影的详情url和电影名称
        self.movieUrlAndNameList=[]
        
    def get_page(self):
        try:
            url = 'https://movie.douban.com/top250?start=' + str(self.start) + '&filter='
            header= {"User-Agent": UserAgent().chrome}
            print("header:"+header)
            response=requests.get(url,headers=header).text
            page_num = (self.start + 25) // 25
            print('正在抓取第' + str(page_num) + '页数据...')
            self.start += 25
            return response
        except BaseException as e:
            if hasattr(e, 'reason'):
               print('获取失败，失败原因：', e.reason)

    def insert_into_mysql(self):
        print('连接MySQL数据库...')
        connection=pymysql.connect(host='localhost',user='root',password='123456',db='movie_play',port=3306,charset='utf8')
        cursor=connection.cursor()
        print('MySQL数据库连接成功...\n开始上传数据...')
        insertStr = "INSERT INTO t_movie(rank, moviename,actors, director," \
                    "showYear, makeCountry, movieType, movieScore, commentorNumber, filmInfo)" \
                    "VALUES (%d, '%s', '%s', '%s', '%s', '%s', '%s', %f, %d, '%s')"
        try:
            for movie in self.movieList:
                insertSQL = insertStr % (int(movie[0]), str(movie[1]), str(movie[2]), str(movie[3]),str(movie[4]), str(movie[5]), str(movie[6]), float(movie[7]),int(movie[8]), str(movie[9]))
                cursor.execute(insertSQL)
            connection.commit()
            print('电影数据上传MySQL成功...')
        except Exception as e:
            print(e)
            connection.rollback()
        finally:
            connection.close()
               
  
    def get_movie_info(self):
        pattern = re.compile(u'<div.*?class="item">.*?'
                      + u'<div.*?class="pic">.*?'
                      + u'<em.*?class="">(.*?)</em>.*?'
                      + u'<div.*?class="info">.*?'
                      + u'<a href="(.*?)".*?'           #1为href
                      + u'<span.*?class="title">(.*?)</span>.*?'
                      + u'<span.*?class="other">.*?</span>.*?'      
                      + u'<div.*?class="bd">.*?'
                      + u'<p.*?class="">.*?'
                      + u'导演:\s(.*?)\s.*?主演:\s(.*?)\s.*?<br>'
                      + u'(.*?)&nbsp;/&nbsp;'
                      + u'(.*?)&nbsp;/&nbsp;(.*?)</p>.*?'
                      + u'<div.*?class="star">.*?'
                      + u'<span.*?class="rating_num".*?property="v:average">'
                      + u'(.*?)</span>.*?'
                      + u'<span>(.*?)人评价</span>.*?'
                      + u'<span.*?class="inq">(.*?)</span>', re.S)
        
        while self.start <= 225:
            page = self.get_page()
            #print("page:"+str(page))
            movies = re.findall(pattern, str(page))
            for movie in movies:
                
                header= {"User-Agent": UserAgent().chrome}
                print("header:"+header)
                response=requests.get(str(movie[1]),headers=header).text
                s=etree.HTML(response)
                #需要在后面添加/text()才能获得字段属性//*[@id="info"]/span[3]/span[2]/span[3]/a为一位演员的数据该方式可以获得多位演员数据
                actors=s.xpath('//*[@id="info"]/span[3]/span[2]/a/text()')
                #将演员字符串中的分隔符号转换为空格
                actors=str(actors)
                del_str=string.punctuation+string.digits
                replace=" "*len(del_str)
                tran_tab=str.maketrans(del_str,replace)
                actors=actors.translate(tran_tab)
    
                actors=str(actors)[0:256]
                #将电影页面的url，电影名称信息进行记录
                self.movieUrlAndNameList.append([movie[1].strip(),movie[2].strip()])
                #将电影信息加入列表当中
                self.movieList.append([movie[0].strip(),
                                        movie[2].strip(),
                                        actors.strip(),
                                        movie[3].strip(),
                                        movie[5].lstrip(),
                                        movie[6].strip(),
                                        movie[7].rstrip(),
                                        movie[8].strip(),
                                        movie[9].strip(),
                                        movie[10].strip()])
                self.count+=1
            self.insert_into_mysql()
            self.movieList.clear();
            print("count: %s"%(self.count))
            time.sleep(3)
    #爬取每一部电影的评论信息
    def get_movieComments_info(self):
        commentSpider=CommentSpider()
        for info in self.movieUrlAndNameList:
            #根据电影详情url和电影名称爬取电影的评论信息
            commentSpider.download(info[0],info[1],3)
            
    def main(self):
        print('开始从豆瓣电影抓取前250部电影数据.......')
        #获取电影数据
        self.get_movie_info()
        #获取电影的评论数据
        self.get_movieComments_info()

#main函数，爬虫从这里开始执行
if __name__ == '__main__':
  spider = MovieSpider()
  spider.main()

            


