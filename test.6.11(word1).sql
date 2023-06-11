show databases;
use bigdata;
show tables;


# DDL -- 数据定义语言  --  create\alter\drop
create table if not exists temp1(`id` varchar(8) primary key ,`name` varchar(8) not null)char set=utf8;
desc temp1;
drop table temp2;
# Alter 修改表属性
-- 修改表名
alter table temp1 rename to temp2;
-- 添加列
alter table temp2 add column sex char(2);
-- 修改列类型
alter table temp2 modify column sex char(3) default 1;
-- 修改列名及新类型
alter table temp2 change column sex age tinyint default 18;
-- 修改列默认值
alter table temp2 alter column age drop default;
alter table temp2 alter column age set default 18;
-- 删除列
alter table temp2 drop column sex;

-- 可以去掉 column
alter table temp2 add sex char(2) not null;
alter table temp2 drop sex;
desc temp2;


# DML -- 数据操作语言  --  insert update delete 
# 插入数据
-- 一、插入数据
insert into temp2(id,name,age) values('001','小猫',20);
insert into temp2(id,name) values('002','小狗');
insert into temp2 values('003','小熊',17);
insert into temp2 values('004','小鸭',null);
-- 二、如果已存在数据，则忽略
insert ignore into temp2(id,name) values('002','小狗');
-- 三、基于 Primary key 替换原有数据，如果没有就新插入
replace into temp2 values('003','小鱼',20);

-- 删除记录
-- 删除和修改的时候，code=1157，则是数据库当前使用的是 safe update mode(安全更新模式)，并且在update时where 中没有把主键当做条件
set sql_safe_updates = 0;
-- 修改记录
update temp2 set age=21 where id='003';
update temp2 set age=20 where id='004';
-- 删除记录
delete from temp2 where id = '001';


# DQL -- 数据查询语言  --  select
select id,name,age from temp2;
select * from bigdata.temp2;


# DCL -- 数据控制语言(权限控制操作)  --  grant\revoke
use mysql;

-- 其中 Host代表当前用户访问的主机, 如果为localhost, 仅代表只能够在当前本机访问，是不可以远程访问的。 User代表的是访问该数据库的用户名。
-- 在MySQL中需要通过Host和User来唯一标识一个可访问用户。当 Host 的值为 * 时，表示所有客户端的用户都可以访问 
-- 查询用户
select * from user;
select * from mysql.user;

-- 创建一个用户
create user 'zy'@'%' identified by '000000';
create user 'rocky'@'localhost' identified by '000000';
-- 查看当前密码策略要求：
SHOW VARIABLES LIKE 'validate_password%';

-- 如果您想关闭密码策略检查，可以执行以下语句：
-- 一、在线卸载密码策略插件
-- UNINSTALL PLUGIN validate_password;
-- 在线安装密码策略插件（误删以后可以直接在线安装插件，就无需去官网找插件的安装包啦）
-- INSTALL PLUGIN validate_password soname 'validate_password.so';

-- 二、修改密码长度和安全性检查程度（低中高）：
-- 修改安全性为‘低’
SET GLOBAL validate_password_policy=LOW;
-- 修改密码策略的长度为6
SET GLOBAL validate_password_length=6;

-- 修改用户密码
alter user 'rocky'@'*' identified with mysql_native_password 
by '123456';

-- 删除用户
drop user 'rocky'@'%';

# 权限控制
use mysql;
select * from mysql.user;
select host,usea from mysql.user;
-- 查询权限
show grants for 'zy'@'%';
show grants for 'root'@'%';

-- 授予'zy'@'%'用户bigdata数据库所有表的查看权限
grant select on bigdata.* to 'zy'@'%';
grant all on bigdata.* to 'zy'@'%';
-- 需要刷新权限以后才会激活
flush privileges;

-- -- 撤销'zy'@'%'用户bigdata数据库的所有表的查看权限
revoke select on bigdata.* from 'zy'@'%';
revoke all on bigdata.* from 'zy'@'%';
flush privileges;

-- 3、授权一个来宾用户guest针对所有数据库的所有操作权限并且来自所有的ip都可以登陆
-- grant all privileges on *.* to 'guest'@'%' identified by '123456';
-- flush privileges;
-- 4、授权用户user3创建表的权限，并且在192.168.1.0这个网段的ip都可以登录
-- grant create on db-three.* to user3@'192.168.1.%';
-- flush privileges;

-- 撤销权限：语句是一样的将关键字grant替换为revoke，将to替换为from即可


# TCL -- 事物控制语言  -- start transaction\commit\rollback\set transaction 


desc emp_dep;
select * from dept;
# 排序查询
select * from emp_dep order by salary desc;
# 分页查询  （左起始位置右表示分页数）
select * from emp_dep group by job;