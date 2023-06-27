# -*- coding: utf-8 -*-
"""
Created on Thu Mar 12 16:11:50 2020

@author: Administrator
"""
import re
import time
import json
import emoji
import string
import random
import pymysql
import requests
from lxml import etree
import urllib.request as request
from fake_useragent import UserAgent

class CommentSpider:

    def __init__(self):
        self.loginURL = "https://accounts.douban.com/passport/login"
        self.data = {
                    "ck": "",
                    "username": "",
                    "password": "",
                    "remember": "false",
                    "ticket": ""
                    }
        #使用cookies爬取评论数据
        self.cookies={'cookie':'ll="108301"; bid=UvGRE8zcFmY; _vwo_uuid_v2=DAD471B0999F79F0DB1EFBD8994B810F5|f1b0fd889e05906c8f40b0080ce1e828; __yadk_uid=AXtwKh34qCEwxyNUHau2tbz6SbHPQeZG; __gads=ID=442879fd71c39f36:T=1586481585:S=ALNI_MatzEFy5JKEujx31fh7seqiYy3fbA; push_noty_num=0; push_doumail_num=0; __utmv=30149280.21336; ap_v=0,6.0; __utmc=30149280; __utmc=223695111; dbcl2="213360799:XczeiolBdyw"; ck=VQtH; __utma=30149280.474729895.1586308492.1586566798.1586571585.6; __utmz=30149280.1586571585.6.6.utmcsr=accounts.douban.com|utmccn=(referral)|utmcmd=referral|utmcct=/passport/login; __utmt=1; __utmb=30149280.2.10.1586571585; _pk_ref.100001.4cf6=%5B%22%22%2C%22%22%2C1586571588%2C%22https%3A%2F%2Fwww.douban.com%2F%22%5D; _pk_id.100001.4cf6=b14ed2a5dcb9f0c2.1586308492.4.1586571588.1586566942.; _pk_ses.100001.4cf6=*; __utma=223695111.99710009.1586308492.1586566942.1586571588.4; __utmz=223695111.1586571588.4.4.utmcsr=douban.com|utmccn=(referral)|utmcmd=referral|utmcct=/; __utmb=223695111.1.10.1586571588'}
        self.session = requests.Session()
        
    '''
    def login(self, userName, password):
        self.data["username"] = userName
        self.data["password"] = password
        header= {'Host': 'movie.douban.com',
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Safari/537.36'}
        r = self.session.post(url=self.loginURL, headers=header,data=self.data)
        # 可能状态码是200但登录失败（比如弹出验证码），以后加以解决
        if r.status_code == 200:  
            print("登录成功！")
        else:
            print("登录失败！")
    '''
    def download(self,movieUrl,movieName,pages=26):
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
        header= {"User-Agent":'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Safari/537.36' }
        for i in range(11, pages):
            index = i*20
            commentsURL = str(movieUrl)+"comments?start="+str(index)+"&limit=20&amp;sort=new_score&amp;status=P"
            response = requests.get(commentsURL,cookies=self.cookies,headers=header)
            #检查服务器返回状态是否正确
            #print(response.status_code)
            
            if response.status_code==200:
                
                page_code=response.text
                commentsItems=re.findall(pattern,page_code)
                try:
                    for item in commentsItems:
                        moviename=str(movieName)
                        #用户昵称中的表情符号
                        username=emoji.demojize(item[0])
                        username=str(username.strip())
                        
                        #去除评论内容中的表情符号
                        comment=emoji.demojize(item[4])
                        comment=str(comment.strip())
                        
                        praise=item[1].strip()
                        commenttime=item[3].strip()
                        score=item[2].strip()
                        
                        #print(moviename)
                        
                        print(username)
                        '''
                        print(comment)
                        print(praise)
                        print(commenttime)
                        print(score)
                        '''
                        #按对应字段写入数据库
                        cursor.execute("insert into t_comment(moviename,username,comment,praise,datetime,score) values(%s,%s,%s,%s,%s,%s)",
                               (moviename,username,comment,praise,commenttime,score)) 
                        
                    #将修改提交到数据库
                    connection.commit()      
                    time.sleep(random.random())
                    print("下载'%s' 第%s页影评数据完毕！"%(movieName,i+1))
                except BaseException as e:
                    print(e)
                    connection.rollback()
                    
            else:
                print("'%s' 影评数据获取失败！"%movieName)
                time.sleep(random.random())
                
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
            #构造URL
            url = 'https://movie.douban.com/top250?start=' + str(self.start) + '&filter='
            #设置请求头
            header= {'User-Agent': UserAgent().random}
            response=requests.get(url,headers=header).text
            #每页25条电影信息
            page_num = (self.start + 25) // 25
            print('正在抓取第' + str(page_num) + '页数据...')
            #更新已爬取电影数量
            self.start += 25
            #返回爬取到的网页文本信息
            return response
        except request.URLError as e:
            if hasattr(e, 'reason'):
               print('获取失败，失败原因：', e.reason)

    def insert_into_mysql(self):
        print('连接MySQL数据库...')
        connection=pymysql.connect(host='localhost',user='root',password='123456',
                                   db='movie_play',port=3306,charset='utf8')
        cursor=connection.cursor()
        print('MySQL数据库连接成功...\n开始上传数据...')
        insertStr = "INSERT INTO t_movie(rank, moviename,actors, director," \
                    "showYear, makeCountry, movieType, movieScore, commenterNumber, filmInfo)" \
                    "VALUES (%d, '%s', '%s', '%s', '%s', '%s', '%s', %f, %d, '%s')"
        try:
            for movie in self.movieList:
                insertSQL = insertStr % (int(movie[0]), str(movie[1]), str(movie[2]),
                                         str(movie[3]),str(movie[4]), str(movie[5]), 
                                         str(movie[6]), float(movie[7]),int(movie[8]), 
                                         str(movie[9]))
                cursor.execute(insertSQL)
            connection.commit()
            print('电影数据上传MySQL成功...')
        except Exception as e:
            print(e)
            connection.rollback()
        finally:
            connection.close()
               
  
    def get_movie_info(self):
        pattern = re.compile('<div.*?class="item">.*?'
                      + '<div.*?class="pic">.*?'
                      + '<em.*?class="">(.*?)</em>.*?'
                      + '<div.*?class="info">.*?'
                      + '<a href="(.*?)".*?'           #1为href
                      + '<span.*?class="title">(.*?)</span>.*?'
                      + '<span.*?class="other">.*?</span>.*?'      
                      + '<div.*?class="bd">.*?'
                      + '<p.*?class="">.*?'
                      + '导演:(.*?)[&nbsp;]+.*?主演:(.*?).*?<br>.*?'
                      + '(.*?)&nbsp;/&nbsp;.*?'
                      + '(.*?)&nbsp;/&nbsp;(.*?)</p>.*?'
                      + '<div.*?class="star">.*?'
                      + '<span.*?class="rating_num".*?property="v:average">'
                      + '(.*?)</span>.*?'
                      + '<span>(.*?)人评价</span>.*?'
                      + '<span.*?class="inq">(.*?)</span>', re.S)
        
        while self.start <= 225:
            page = self.get_page()
            movies = re.findall(pattern, page)
            header= {"User-Agent": UserAgent().random}
            for movie in movies:
                
                response=requests.get(str(movie[1]),headers=header).text
                s=etree.HTML(response)
                #需要在后面添加/text()才能获得字段属性//*[@id="info"]/span[3]/span[2]/span[3]/a为一位演员的数据该方式可以获得多位演员数据
                actors=s.xpath('//*[@id="info"]/span[3]/span[2]/a/text()')
                if len(actors)==0:
                    actors=s.xpath('//*[@id="info"]/span[2]/span[2]/a/text()')
                directors=s.xpath('//*[@id="info"]/span[1]/span[2]/a/text()')
                
                #将演员字符串中的分隔符号转换为空格
                actors=str(actors)
                #构造要替换的字符
                del_str=string.punctuation+string.digits
                #将字符替换为空格
                replace=" "*len(del_str)
                tran_tab=str.maketrans(del_str,replace)
                actors=actors.translate(tran_tab)
                actors=str(actors)
                #将导演字符串中的分隔符号转换为空格
                directors=str(directors)
                directors=directors.translate(tran_tab)
                directors=str(directors)
                #将电影页面的url，电影名称信息存入数组中
                self.movieUrlAndNameList.append([movie[1].strip(),movie[2].strip()])
                #将电影信息加入列表当中
                self.movieList.append([movie[0].strip(),
                                        movie[2].strip(),
                                        actors.strip(),
                                        directors.strip(),#director
                                        movie[5].lstrip(),
                                        movie[6].strip(),
                                        movie[7].rstrip(),
                                        movie[8].strip(),
                                        movie[9].strip(),
                                        movie[10].strip()])
                self.count+=1
            #将电影信息存入数据库中
            self.insert_into_mysql()
            self.movieList.clear()
            print("count: %s"%(self.count))
            time.sleep(5)
        #将电影URL信息写入json文件
        with open('film.json','a',encoding='utf-8') as fp:
            json.dump(self.movieUrlAndNameList,fp)
            
    #爬取每一部电影的评论信息
    def get_movieComments_info(self):
        commentSpider=CommentSpider()
        for info in self.movieUrlAndNameList:
            print('爬取movieUrl:%s\n movieName: %s的评论数据'%(info[0],info[1]))
            #根据电影详情url和电影名称爬取电影的评论信息
            commentSpider.download(info[0],info[1],10)
            
    def main(self):
        print('开始从豆瓣电影抓取前250部电影数据.......')
        
        #获取电影数据
        self.get_movie_info()
        #获取电影的评论数据
        #self.get_movieComments_info()

#main函数，爬虫从这里开始执行
if __name__ == '__main__':
    '''
    commentSpider=CommentSpider();
    commentSpider.login("sx981018","sx981018")
    spider = MovieSpider()
    spider.main()
  
    '''
    spider=CommentSpider()
    #spider.login("13361616067","sx981018")
    with open(r'film.json','r',encoding='utf-8') as file:
      data=json.load(file)
      index=0
      for item in data:
          
         if index>=231 :
             print("index:%s"%index)
             print(item[0])
             print(item[1])
             spider.download(item[0],item[1],25)
         index+=1
         

