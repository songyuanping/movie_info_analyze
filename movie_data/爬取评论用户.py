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
        self.cookies={'cookie':'bid=UvGRE8zcFmY; _vwo_uuid_v2=DAD471B0999F79F0DB1EFBD8994B810F5|f1b0fd889e05906c8f40b0080ce1e828; __gads=ID=442879fd71c39f36:T=1586481585:S=ALNI_MatzEFy5JKEujx31fh7seqiYy3fbA; __yadk_uid=ZfBJdZARjxnUsYejSciyTdlzXxw7VOLB; push_noty_num=0; push_doumail_num=0; __utmv=30149280.21336; __utmc=30149280; loc-last-index-location-id="128099"; ll="128099"; _pk_ref.100001.8cb4=%5B%22%22%2C%22%22%2C1587818519%2C%22https%3A%2F%2Faccounts.douban.com%2Fpassport%2Flogin%22%5D; _pk_ses.100001.8cb4=*; __utma=30149280.474729895.1586308492.1587811109.1587818522.17; __utmz=30149280.1587818522.17.14.utmcsr=accounts.douban.com|utmccn=(referral)|utmcmd=referral|utmcct=/passport/login; __utmt=1; dbcl2="213360799:6f798bslfto"; ck=KVSy; _pk_id.100001.8cb4=cac6b40407f57be5.1586481583.16.1587818588.1587811229.; __utmb=30149280.3.10.1587818522'}
        self.session = requests.Session()

    def download(self,movieUrl,movieName,pages=26):
        #连接数据库及光标
        connection=pymysql.connect(host='localhost',user='root',password='123456',db='movie_play',port=3306,charset='utf8')
        cursor=connection.cursor()
        
        header= {"User-Agent":'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Safari/537.36' }
        for i in range(0, pages):
            index = i*20
            commentsURL = str(movieUrl)+"comments?start="+str(index)+"&limit=20&amp;sort=new_score&amp;status=P"
            response = requests.get(commentsURL,cookies=self.cookies,headers=header)
            #检查服务器返回状态是否正确
            #print(response.status_code)
            
            if response.status_code==200:
                
                page_code=response.text
                s=etree.HTML(page_code)
                #需要在后面添加/text()才能获得字段属性//*[@id="info"]/span[3]/span[2]/span[3]/a为一位演员的数据该方式可以获得多位演员数据
                commentorUrls=s.xpath('//*[@id="comments"]/div/div[2]/h3/span[2]/a/@href')
            
                try:
                    for item in commentorUrls:
                        response = requests.get(item,cookies=self.cookies,headers=header).text
                        commenterInfo=etree.HTML(response)
                        #利用xpath获取网页中的用户信息
                        commenterName=commenterInfo.xpath('//*[@id="db-usr-profile"]/div[2]/h1/text()')
                        commenterID=commenterInfo.xpath('//*[@id="profile"]/div/div[2]/div[1]/div/div/text()[1]')
                        liveCity=commenterInfo.xpath('//*[@id="profile"]/div/div[2]/div[1]/div/a/text()')
                        joinTime=commenterInfo.xpath('//*[@id="profile"]/div/div[2]/div[1]/div/div/text()[2]')
                        friendCount=commenterInfo.xpath('//*[@id="friend"]/h2/span/a/text()')
                        followerCount=commenterInfo.xpath('//*[@id="content"]/div/div[2]/p[1]/a/text()')
                       
                        #xpath的返回数据均是数组类型，且需去除用户名中的表情数据
                        commenterName=emoji.demojize(commenterName[0].strip())
                        #去除数据中的非法字符数据
                        commenterName=str(commenterName.strip())
                        del_str=string.punctuation+string.digits
                        replace=" "*len(del_str)
                        tran_tab=str.maketrans(del_str,replace)
                        commenterName=commenterName.translate(tran_tab)
                        
                        #去除居住地中的多余空格
                        liveCity=str(liveCity[0].strip())
                        #提取用户的注册时间
                        joinTimePattern = re.compile('(.*?)加入', re.S)
                        #提取字符中的数字部分
                        friendCount = re.sub("\D", "", friendCount[0]) 
                        #提取用户的粉丝数量
                        followerCountPattern = re.compile('.*?被(.*?)人关注', re.S)
                        joinTime = re.findall(joinTimePattern, joinTime[0])
                        followerCount=re.findall(followerCountPattern, followerCount[0])
                        
                        commenterName=commenterName.strip()
                        commenterID=commenterID[0].strip()
                        liveCity=liveCity.strip()
                        joinDate=joinTime[0].strip()
                        friendCount=friendCount.strip()
                        followerCount=followerCount[0].strip()
                        
                        #print(commenterName)
                        print(commenterID)
                        '''
                        print(liveCity)
                        print(joinDate)
                        print(friendCount)
                        print(followerCount)
                        '''
                        #按对应字段写入数据库
                        
                        cursor.execute("insert into t_commenter(commenterID,commenterName,liveCity,joinDate,friendCount,followerCount) values(%s,%s,%s,%s,%s,%s)",
                               (commenterID,commenterName,liveCity,joinDate,friendCount,followerCount)) 
                        connection.commit()
                    #将修改提交到数据库
                    #connection.commit()      
                    #time.sleep(random.random())
                    print("下载'%s' 第%s页影评数据完毕！"%(movieName,i+1))
                except BaseException as e:
                    print(e)
                    connection.rollback()
                    
            else:
                print("'%s' 影评数据获取失败！"%movieName)
                time.sleep(random.random())
                
        connection.close()
        print("'%s' 影评数据下载完成！"%movieName)      
        
#main函数，爬虫从这里开始执行
if __name__ == '__main__':
    
    spider=CommentSpider()
    #spider.login("13361616067","sx981018")
    with open(r'film.json','r',encoding='utf-8') as file:
      data=json.load(file)
      index=0
      for item in data:
          
         if index>=228  :
             print("index:%s"%index)
             print(item[0])
             print(item[1])
             spider.download(item[0],item[1],25)
         index+=1
         

