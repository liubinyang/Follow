# coding: UTF-8
import urllib2
import MySQLdb as mdb
import re
from bs4 import BeautifulSoup


def deal(url):
		headers = {'User-Agent':'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6'} 
		response_pre = urllib2.Request(url,headers = headers)
		response = urllib2.urlopen(response_pre).read()
		return response

def ini():
	follow_website = list()
	sina = 'http://www.sina.com.cn'
	sohu = 'http://www.sohu.com'
	net = 'http://www.163.com/'
	tencent = 'http://www.qq.com'
	hupu = 'http://www.hupu.com'
	follow_website.append(deal(sohu))
	print("sohu done")
	follow_website.append(deal(sina))
	print("sina done")
	follow_website.append(deal(net))
	print("net done")
	# follow_website.append(deal(tencent))
	# print("tencent done")
	# try:
	# 	follow_website.append(deal(hupu))
	# 	print("hupu done")
	# except:
	# 	pass
	return follow_website


if __name__ == '__main__':
    follow_website = ini()
    conn = mdb.connect(host='jeako.pub', port=3306, user='uroot', passwd='123', db='follow', charset='utf8')
    conn.autocommit(1)
    cursor = conn.cursor()
    print("connected") 
    # try:
    cursor.execute("SELECT * FROM user")
    results = cursor.fetchall()
    done = []
    for row in results:
		name = str(row[0])
		cursor.execute('DROP TABLE IF EXISTS %s'  %name )
	   	cursor.execute('CREATE TABLE %s(word varchar(30) ,string varchar(10000) ,link varchar(10000))' %name)
		# ID = str(row[0])
		key = str(name + "words")
		cursor.execute("SELECT * FROM %s" %(key))
		wordlist = cursor.fetchall()
		print(name)
		for focus in wordlist:
	   		word = str(focus[0].encode("utf-8"))
	   		# print(website)
	   		# print(word)
	   		for website in follow_website:
				# html = deal(website)
				soup = BeautifulSoup(website)
				getFocus = soup.find_all('a')
				link = "jeako"
				prelink = "jeako"
				for stri in getFocus:
					strstr = str(stri)
					point1 = int(strstr.index('>'))
					strfind = strstr[point1+1::]
					point2 = int(strfind.index('<'))
					strfind = strfind[0:point2]
					strfinal = strfind[0:point2].strip()
					match = re.search(word,strfind[0:point2])
					if match:
						point3 = int(strstr.index("href"))
						strj = strstr[point3+6::]
						point4 = int(strj.index('"'))
						link = strj[0:point4]
						try:
							if link[0] == "h" and link != prelink:
								print(link)
								cursor.execute('INSERT INTO %s values("%s" , "%s" , "%s")' %(name,word,strfinal,link))
								prelink = link
						except:
							pass
						# cursor.execute ("SELECT * FROM %s" %(name))  
						# rows = cursor.fetchall()
						# ok = 1
						# for row in rows:
						# 	if link == row[2]:
						# 		ok = 0
						# if ok:
						# 	print(link)
						# 	cursor.execute('INSERT INTO %s values("%s" , "%s" , "%s")' %(name,word,strfinal,link))
    cursor.close()
    conn.close()
    # except:
    #     print("Error")
