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

-- 报错(有外键约束的情况下，无法不先对子表处理的情况下直接对父表操作)
delete from class where cNo=2;
update class set cNo=3 where cNo=4;
-- 可以修改
update student set Age=19 where classNo=2;

-- 如果想删除3班,需手动先对3班的学生进行处理,删除或者清空外键
-- （想修改主表中的数据，则应先将从表中的外键清空）
update student set classNo=null where classNo=3;
delete from class where cNo=3;

-- 需求:希望在更新班级编号的时候,可以直接更新学生的班级编号(修改或删除)
-- 修改外键设置：外键要修改只能先删除再添加
desc student;
alter table student drop foreign key fk_stu_classNo;
alter table student add constraint fk_stu_classNo foreign key
(classNo) references class(cNo) on delete set null on update 
cascade;

-- 验证修改班级ID后学生表是否也跟着变更班级ID
update class set cNo=5 where cNo=3;

select * from student;
select * from class;

# DDL和DML更多操作
-- 1、快速创建数据库表  -> 结构和数据完全相同
create table class02 as select * from class;
select * from class02;

-- 2、快速创建数据库表  -> 结构相同，不要数据
create table class03 as select * from class where 1=2;
select * from class03;

-- 3、快速创建数据库表  -> 只要部分数据
create table class04 as select cNo,cName from class;
select * from class04;

-- 添加数据 
insert into class04 values(1,"C"),(2,"C++"),(3,"C#");
insert into class04 set cNo=4,cName="PHP";

select * from class04;

-- 删除所有数据  -->  推荐使用 truncate 方法清除数据
-- (1)DELETE为数据操作语言DML；TRUNCATE为数据定义语言DDL。 
-- (2) DELETE操作是将表中所有记录一条一条删除直到删除完；
-- 	TRUNCATE操作则是保留了表的结构，重新创建了这个表，所有的状态都相当于新表。
-- (3)DELETE操作可以回滚；
--    TRUNCATE操作会导致隐式提交，因此不能回滚（后面会讲解事务的提交和回滚）。 
-- (4)DELETE操作执行成功后会返回已删除的行数（如删除4行记录，则会显示“Affected rows：4”）；
--    截断操作不会返回已删除的行量，结果通常是“Affected rows：0”。
--    DELETE操作删除表中记录后，再次向表中添加新记录时，对于设置有自增约束字段的值会从删除前表中该字段的最大值加1开始自增；
--    TRUNCATE操作会重新从1开始自增。

delete from class04;
truncate table class04;



