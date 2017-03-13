create database follow;
use follow;

create table user(
username varchar(30),
password varchar(30),
unique (username))；

insert into user values('visitor','123');

create table visitorwords(
words varchar(100))character set = utf8;

insert into visitorwords values('NBA');
insert into visitorwords values('经济');
insert into visitorwords values('广州');
insert into visitorwords values('美国');
insert into visitorwords values('川普');
insert into visitorwords values('科技');