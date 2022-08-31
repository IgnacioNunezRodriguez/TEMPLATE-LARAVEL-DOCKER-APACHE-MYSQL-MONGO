use laravelDB;

drop database if exists laravelDB; 
create database laravelDB;  

drop user if exists 'user'@'localhost'; 
create user 'user'@'localhost' identified by '1234'; 

grant select, delete, insert, update on `laravelDB`.* to 'user'@'localhost';