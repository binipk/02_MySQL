use mysql;
show databases;
select * from user;

create database menudb;
create user 'ohgiraffers'@'%' identified by 'ohgiraffers';
grant all privileges on menudb.* To 'ohgiraffers'@'%';
