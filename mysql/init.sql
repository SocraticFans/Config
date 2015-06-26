
GRANT ALL ON sgod.* TO 'sgod'@'localhost' IDENTIFIED BY '123456';
GRANT ALL ON sgod.* TO 'sgod'@'%' IDENTIFIED BY '123456';
FLUSH PRIVILEGES;

create database sgod character set utf8;
