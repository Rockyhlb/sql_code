show databases;

select * from mysql.user;
grant select on *.* to 'zy'@'%';
-- 授予权限 
grant select,insert,update on *.* to 'rocky'@'localhost';
-- 撤销权限
revoke drop on *.* from 'rocky'@'localhost'; 
-- 刷新权限 
flush privileges;


use bigdata;
show tables;
desc student;
show create table student;
-- 修改字段约束条件
alter table student modify `年龄` tinyint(4) default 18; 
alter table student modify `年龄` tinyint(4) not null; 
-- 清空约束条件
alter table student modify `年龄` tinyint(4) null; 


# 表的非外键约束
-- 列级约束  
create table if not exists stu1(
	id int(4) primary key auto_increment,
    name varchar(12) not null,
    sex char(1) default '男' check (sex='男' or sex='女'),
    age int(3) check(age>18 and age<30),
    enterDate date,
    classname varchar(10),
    email varchar(20) unique
)char set=utf8;
desc stu1;

drop table stu1;
-- 表级约束
-- 非空约束无表级约束
-- constraint + 约束名称 + 约束关键字 +（约束字段）
create table if not exists stu1(
	sno int(10),
    name varchar(12) not null,
	sex char(2) default '男',
    age int(2),
    enterdate date,
    classname varchar(20),
	email varchar(20),
	constraint pk_stu primary key(sno),
    constraint uk_stu_email unique(email),
    constraint ck_stu_sex check (sex='男' or sex='女'),
    constraint ck_stu_age check (age=18 or age=30)
)charset=utf8;
desc stu1;
show create table stu1;

insert into stu1(sno,name,sex,age)values(1,'zhangsan','aa',80);
select * from stu1;

-- 删除主键
alter table stu1 drop primary key;
-- 通过index删除唯一约束()  
alter table stu1 drop index uk_stu_email;
-- 添加唯一键约束，同时设置约束名称为uk_stu_email
alter table stu1 add constraint uk_stu_email unique(email);
drop table if exists stu1;


# 外键约束  --  保持不同表中相同含义数据的一致性和完整性
-- 创建一个班级表（主表）
create table class(
	cNo int(4) auto_increment,
    cName varchar(12) not null,
    Room varchar(4),
    primary key(cNo)
)charset=utf8;

insert into class values (null,'Java001','215');
insert into class values (null,'Java002','216');
insert into class values (null,'Java003','217');
select * from class;

drop table if exists student;
-- 创建一个学生表（从表）
create table student(
	sNo int(6) primary key auto_increment,
    sName varchar(8),
    Sex char(1) check (sSex='男' or sSex='女'),
    Age tinyint check (sAge>0 and sAge<35),
    classNo int(4),
    constraint fk_stu_classNo foreign key(classNo) references class(cNo)
)charset=utf8;
desc student;

insert into student values(null,'小猫','男',21,1);
insert into student values(null,'小狗','女',18,2);
insert into student values(null,'小鱼','女',20,3);
-- 无法插入,,因为class主表当中没有4班,不能满足主从表当中的数据一致性
insert into student values(null,'小鸟','男',19,4);

select * from student;
select * from class;






