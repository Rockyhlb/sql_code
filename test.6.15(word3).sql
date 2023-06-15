show databases;
use bigdata;
show tables;
drop view view_emp_dep;


# 六、视图(视图是一个虚拟表，是从一个或多个表（或视图）导出的表,内容由查询定义)
/**
一般我们称表为基表，视图是一个虚表（视图不存放数据）
视图一经定义，就可以像表一样被查询，修改，删除和更新

作用：
	1、简化代码，把经常使用的查询封装成视图重复使用，使复杂的查询易于理解和使用。
	2、安全原因，如果一张表中有很多数据，很多信息不希望让所有人看到，此时可以使用视图
		如：社会保险基金表，可以用视图只显示姓名，地址，而不显示
        社会保险号和工资数等，可以对不同类型的用户，设定不同的视图。
        
需要注意的是，视图并不实际存储数据，它只是一个查询的定义。因此，
当从视图中检索数据时，实际上是执行视图定义中的查询语句来获取数据。
另外，视图也可以与其他表进行连接、过滤和排序等操作，以实现更复杂的查询需求
*/
-- 6.1、创建视图(基于前面案例所创建的emp,emp_dep,dept三张表)
-- 基于表emp创建age<60的视图
create view view_emp as select * from emp where age<60; 
-- 基于表emp_dep创建在'2008-02-02'后入职的员工视图
create view view_emp_dep1 as select * from emp_dep where entrydate
> '2008-02-02';
-- 基于表emp_dep和表dept创建显示员工的id,name,age,job和department
-- 并且将id不足7位的前面补上‘202100’
create view view_emp_dep2 as select lpad(e.id,7,'202100') 'id',e.name,e.age,e.job,
d.name 'department' from emp_dep e left join dept d on e.dept_id=d.id;

-- 6.2、使用视图
-- 查看视图(在MySQL5.1版本之后，使用show tables不仅仅能够显示表，而且也能够显示视图)
select * from view_emp; 
select * from view_emp_dep1;
select * from view_emp_dep2;
-- 对部门分组，统计员工数量
select workaddress '部门',count(*) '数量(age<60）' from view_emp 
group by workaddress; 

-- 6.3、更新视图
-- 没有视图就创建，有视图就覆盖掉原视图
create or replace view view_emp as select * from emp;
select * from view_emp;
-- 修改工号为‘00001’的姓名
-- !!修改表的数据时，基于该表所创建的视图的数据也会改变
-- 同理，修改视图的数据时，该视图的基表数据也会改变
update view_emp set name='柳岩yyds' where workno='00001';
update emp set name='柳岩666' where workno='00001';
select * from view_emp;

-- 6.4、删除视图
drop view view_emp;
drop view view_emp_dep1;
drop view view_emp_dep2;
select * from view_emp;

# 七、触发器
/**
定义：
	触发器(Trigger)是由insert、update和delete等事件来触发某种特定操作。
满足触发器的触发条件时，数据库系统就会执行触发器中定义的程序语句。
这样做可以保证某些操作之间的一致性，是保证数据完整性的一种方法

作用：
1、增强数据库的安全性完整性。
可以实现对用户操作数据库的限制，比如不允许用户下班时间修改数据，不允许用户对某些数据更改超过一定的幅度和范围等等。
2、实现数据库操作的审计。
利用MySQL触发器，可以跟踪用户对数据库的操作，把用户执行的一些操作自动写入审计库。
3、定义数据表的一些复杂规则。
触发器可以实现非标准的数据完整性检查和约束，因此，触发器可以实现比规则更加复杂的限制。
4、实现复杂的级联操作。
尽管我们利用外键，可以实现相关的级联操作，但是，利用触发器，我们可以实现更加复杂的级联操作。
5、自动计算数值。
利用触发器，可以监控数据库中某些敏感值，例如，如果当前公司账目上可用资金少于100万元，则立即给公司老板告警等等。
*/
-- 7.1 创建触发器：
-- create trigger trigger_name
-- {before | after} {isnert | update | delete} on table_name
-- for each row
-- begin
-- 	-- 触发器的逻辑处理语句
-- end;
/**
trigger_name 是触发器的名称，
{BEFORE | AFTER} 指定触发时机（在操作之前或之后触发），
{INSERT | UPDATE | DELETE} 指定触发的操作类型，
table_name 是触发器所属的表名，
FOR EACH ROW 表示对每一行数据触发。
在 BEGIN 和 END 之间，可以编写触发器的逻辑处理语句，例如插入、更新、删除数据，调用存储过程等
*/

-- 7.2 删除触发器：
-- drop trigger {if exits} trigger_name; 

-- 7.3 案例：
-- 创建两个表(product,warehouse)
create table product(
	id int(8) auto_increment primary key,
    name varchar(8) not null,
    price float(4)
)charset=utf8;
create table warehouse(
	id int(8) auto_increment primary key,
    `time` date not null,
    log varchar(20)
)charset=utf8;

-- 创建触发器：
-- 创建before_insert的触发器，向product插入数据之前记录插入日志
create trigger before_insertProduct
before insert on product
for each row
insert into warehouse(time,log) values(now(),'insert a product');
-- 验证触发器记录操作日志
insert into product values(null,'苹果',4.50);
select id,name,price from product;
select id,time,log from warehouse;


# 八、存储过程(封装实现某种功能的sql语句,存储在数据库中,经过第一次编译后用户通过存储过程的名字调用不需要再次编译)
/**
优点：
1.提高性能：存储过程只在创造时进行编译，以后每次执行存储过程都不需再重新编译，
而一般SQL语句每执行一次就编译一次,所以使用存储过程可提高数据库执行速度，效率要比正常SQL语句高。
2.简化应用程序逻辑：当对数据库进行复杂操作时，可用存储过程将此复杂操作封装起来后与数据库提供的事务处理结合一起使用。
3.减少网络流量：由于存储过程在数据库服务器上执行，只需发送参数和调用请求，而不是整个查询语句，从而减少了网络流量，
一个存储过程在程序在网络中交互时可以替代大堆的T-SQL语句，所以也能降低网络的通信量，提高通信速率。
4.存储过程可以重复使用,可减少数据库开发人员的工作量。
5.安全性高,可设定只有某些用户才具有对指定存储过程的使用权
缺点：
如果使用大量存储过程，那么使用这些存储过程的每个连接的内存使用量将会大大增加，不利于逻辑运算；
MySQL 不提供调试存储过程的功能，很难调试存储过程
*/
-- 8.1  创建存储过程
-- 8.1.1 当存储过程只有一条语句时,begin...and...可以省略
create procedure pro_select_emp() select * from emp;
-- 8.1.2 当存储过程有多条语句时,经常需要用到DELIMITER修改结束命令
delimiter //
create procedure sumRes(in num1 int,in num2 int,out res int)
begin
	set res=num1+num2;
end //
delimiter ;

-- 8.2 调用存储过程
call pro_select_emp();
-- @sum:定义的调用结果显示的字符
call sumRes(2,1,@sum);
select @sum;

-- 8.3 删除存储过程
drop procedure pro1_select_emp;


# 九、数据库设计
/**
数据库设计包括以下几个部分：
	1、需求设计（需求分析）
	2、概念结构设计  -- E-R 图
	3、逻辑结构设计  -- 三大范式
	4、物理结构设计
	5、数据库的实施
	6、数据库的运行与维护
*/






