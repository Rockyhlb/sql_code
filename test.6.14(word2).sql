
use bigdata;
show tables;

#  五、查询 -- DQL  (单表查询、多表查询) --> 基本查询，条件查询，聚合函数查询，分组查询，排序查询，分页查询
-- 准备数据
create table emp( 
id int comment '编号', 
workno varchar(10) comment '工号', 
name varchar(10) comment '姓名', 
gender char(1) comment '性别', 
age tinyint unsigned comment '年龄', 
idcard char(18) comment '身份证号', 
workaddress varchar(50) comment '工作地址', 
entrydate date comment '入职时间' 
)comment '员工表',charset=utf8;

INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (1, '00001', '柳岩666', '女', 20, '123456789012345678', '北京', '2000-01-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (2, '00002', '张无忌', '男', 18, '123456789012345670', '北京', '2005-09-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (3, '00003', '韦一笑', '男', 38, '123456789712345670', '上海', '2005-08-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (4, '00004', '赵敏', '女', 18, '123456757123845670', '北京', '2009-12-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (5, '00005', '小昭', '女', 16, '123456769012345678', '上海', '2007-07-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (6, '00006', '杨逍', '男', 28, '12345678931234567X', '北京', '2006-01-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (7, '00007', '范瑶', '男', 40, '123456789212345670', '北京', '2005-05-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (8, '00008', '黛绮丝', '女', 38, '123456157123645670', '天津', '2015-05-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (9, '00009', '范凉凉', '女', 45, '123156789012345678', '北京', '2010-04-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (10, '00010', '陈友谅', '男', 53, '123456789012345670', '上海', '2011-01-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (11, '00011', '张士诚', '男', 55, '123567897123465670', '江苏', '2015-05-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (12, '00012', '常遇春', '男', 32, '123446757152345670', '北京', '2004-02-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (13, '00013', '张三丰', '男', 88, '123656789012345678', '江苏', '2020-11-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (14, '00014', '灭绝', '女', 65, '123456719012345670', '西安', '2019-05-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (15, '00015', '胡青牛', '男', 70, '12345674971234567X', '西安', '2018-04-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (16, '00016', '周芷若', '女', 18, null, '北京', '2012-06-01');
select * from emp;


# 5.1 单表查询
-- 5.1.1 查询表中的若干列 --> select 列名1,列名2[,列名3,...]  from 表名;
select id,workno,name,gender from emp;

-- 5.1.2 查询经过处理的列 --> 只需要将列名换成表达式即可，表达式可以是算术表达式、函数和字符串常量
-- 5.1.2.1 查询所有员工的工作地址，起别名
select workaddress '工作地址' from emp;
-- 5.1.2.1 查询公司员工上班地址有哪些种类（去重）
select distinct workaddress '工作地址' from emp;

-- 5.1.3 聚合函数查询(count,sum,avg,max,min) --> SELECT 聚合函数(字段列表) FROM 表名 ; 
/**
	当聚集函数遇到空值时，除count(*)外，都跳过空值而只处理非空值
	聚集函数只能用于select子句和group by中的having子句!!!
*/
-- 5.1.3.1 统计员工数量
select count(*) from emp;  -- 统计总记录数
select count(idcard) from emp;  -- 统计idcard字段不为null的记录数
select count(1) from emp;
-- !!!错误写法
select count(age<33) from emp;
-- 5.1.3.2 统计员工的平均年龄
select avg(age) '平均年龄' from emp; 
-- 5.1.3.3 统计员工的最大年龄
select max(age) '最大年龄' from emp; 
-- 5.1.3.4 统计员工的最小年龄
select min(age) '最小年龄' from emp; 
-- 5.1.3.5 统计员工的总年龄
select sum(age) '总年龄' from emp; 
-- 5.1.3.5 统计西安地区员工的总年龄
select sum(age) '西安地区员工总年龄' from emp where workaddress='西安'; 

-- 5.1.4 条件查询 --> SELECT 字段列表 FROM 表名 WHERE 条件列表;
/** 
(>,<,=,>=,<=,!=,<>,!>,!<,not + 前面的比较运算符)
   (between and,not between and) , (in,not in) , (like,not like)
   (is null,is not null) , (and,or,not)
   and,or,not ( && -- || -- ! )
*/
-- 5.1.4.1 查询年龄等于88的员工
select * from emp where age=88;
-- 5.1.4.2 查询年龄小于30的员工
select * from emp where age<30;
-- 5.1.4.3 查询年龄不等于20的员工(id=1)
select * from emp where age != 20;
select * from emp where age <> 20;
-- 5.1.4.4 查询年龄在15(包含)到20(包含)之间的员工信息
select * from emp where age>=15 && age <=20;
select * from emp where age between 15 and 20;
-- 5.1.4.5 查询性别为女，且年龄在15到20之间的员工信息
select * from emp where age>=15 and age <=20 && gender='女';
-- 5.1.4.6 查询年龄等于18,20,40的员工信息
select * from emp where age=18 or age=20 || age=40;
select * from emp where age in(18,20,40);
-- 5.1.4.7 查询姓名为两个字的员工信息(下划线占位)
select * from emp where name like '__';
-- 5.1.4.8 查询身份证号最后一位是x的员工信息
select * from emp where idcard like '%x';
select * from emp where idcard like '_________________x';
-- 5.1.4.9 查询idcard为空的员工信息
select * from emp where idcard is null;
-- 5.1.4.10 查询idcard不为空的员工信息
select * from emp where idcard is not null;

-- 5.1.5 分组查询(group by)  -->  SELECT 字段列表 FROM 表名 [ WHERE 条件 ] GROUP BY 分组字段名 [ HAVING 分组后过滤条件 ];
/**
group by子句将查询结果按某一列或多列的值分组，值相等的为一组。如果未对查询结果
  分组，聚集函数将作用于整个查询结果，分组后聚集函数将作用于每
  一组，即每一组都有一个函数值。
  
where与having区别 （having也是条件查询，是分组后的条件查询）
  执行时机不同：where是分组之前进行过滤，不满足where条件，不参与分组；而having是分组之后对结果进行过滤。 
  判断条件不同：where不能对聚合函数进行判断，而having可以。 
  执行顺序: where > 聚合函数 > having 
*/
-- 5.1.5.1 根据性别分组,统计男性员工和女性员工的数量
select gender,count(*) from emp group by gender;
-- 5.1.5.2 根据性别分组,统计男性员工和女性员工的平均年龄
select gender,avg(age) from emp group by gender;
-- 5.1.5.3 查询年龄小于45的员工,根据工作地址分组,获取员工数量大于等于三的地址
select workaddress,count(*) address_count from emp where 
age<=45 group by workaddress having address_count >=3;
-- 5.1.5.4 统计各个工作地址上班的男性及女性员工的数量
select workaddress,gender,count(*) '数量' from emp 
group by gender, workaddress;


-- 5.1.6 排序查询 --> SELECT 字段列表 FROM 表名 ORDER BY 字段1 排序方式1,字段2 排序方式2 ;
/**
    order by子句用来给查询结果排序，ASC为升序排列，DESC为降序排列，默认值为升序。
    空值的显示次序由具体系统实现来决定。
*/
-- 5.1.6.1 根据入职时间对公司的员工进行升序降序排序
select * from emp order by entrydate desc;
select * from emp order by entrydate;
-- 5.1.6.2 根据年薪对公司员工进行降序排序，如果年龄相同，再按照入职时间进行降序排序
select * from emp_dep order by salary desc,entrydate desc;


-- 5.1.7 分页查询 --> SELECT 字段列表 FROM 表名 LIMIT 起始索引, 查询记录数 ;
/**
	注意事项：
    1、起始索引从0开始，起始索引 = （查询页码-1）*每页显示的记录数
	2、分页查询是数据库的方言，不同的数据库当中有不同的实现，Mysql当中是limit
    3、如果查询的是第一页数据，起始索引可以忽略，简写为：limit 10
*/
-- 5.1.7.1 查询第一页员工数据，每页显示10条数据
select * from emp limit 10;
select * from emp limit 0,10;
-- 5.1.7.2 查询第二页员工数据，每页显示10条数据(（查询页码-1）*每页显示的记录数)
select * from emp limit 10,10;


# 5.2 多表查询
/**
	表结构之间基本分为三种类型：
    1、一对多（多对一）：部门与员工的关系
		实现：在多的一方建立外键，指向少的一方的主键
    2、多对多：学生与课程的关系
		实现：建立第三张中间表，中间表至少包含两个外键，分别关联两方主键
    3、一对一：用户与用户信息的关系(用户信息是唯一的)
		实现：在任意一方加入外键，关联另一方主键，并且设置外键为唯一约束（unique）
*/

-- 5.2.1 一对多情况下的多表查询
-- 数据准备
-- 创建dept表，并插入数据 
-- create table dept( 
-- id int auto_increment comment 'ID' primary key, 
-- name varchar(50) not null comment '部门名称' 
-- )comment '部门表',char set=utf8; 
-- INSERT INTO dept (id, name) VALUES (1, '研发部'), (2, '市场部')
-- ,(3, '财务部'), (4, '销售部'), (5, '总经办'), (6, '人事部');

-- 创建emp_dep表，并插入数据 
-- create table emp_dep( 
-- id int auto_increment comment 'ID' primary key, 
-- name varchar(50) not null comment '姓名', 
-- age int comment '年龄', 
-- job varchar(20) comment '职位', 
-- salary int comment '薪资', 
-- entrydate date comment '入职时间', 
-- managerid int comment '直属领导ID', 
-- dept_id int comment '部门ID' 
-- )comment '员工表'，char set=utf8; 
-- 添加外键 
-- alter table emp add constraint fk_emp_dept_id 
-- foreign key (dept_id) references dept(id);

-- INSERT INTO emp (id, name, age, job,salary, entrydate, managerid, dept_id) VALUES 
-- (1, '金庸', 66, '总裁',20000, '2000-01-01', null,5), 
-- (2, '张无忌', 20, '项目经理',12500, '2005-12-05', 1,1), 
-- (3, '杨逍', 33, '开发', 8400,'2000-11-03', 2,1), 
-- (4, '韦一笑', 48, '开发',11000, '2002-02-05', 2,1), 
-- (5, '常遇春', 43, '开发',10500, '2004-09-07', 3,1), 
-- (6, '小昭', 19, '程序员鼓励师',6600, '2004-10-12', 2,1), 
-- (7, '灭绝', 60, '财务总监',8500, '2002-09-12', 1,3), 
-- (8, '周芷若', 19, '会计',48000, '2006-06-02', 7,3), 
-- (9, '丁敏君', 23, '出纳',5250, '2009-05-13', 7,3), 
-- (10, '赵敏', 20, '市场部总监',12500, '2004-10-12', 1,2), 
-- (11, '鹿杖客', 56, '职员',3750, '2006-10-03', 10,2), 
-- (12, '鹤笔翁', 19, '职员',3750, '2007-05-09', 10,2), 
-- (13, '方东白', 19, '职员',5500, '2009-02-12', 10,2), 
-- (14, '张三丰', 88, '销售总监',14000, '2004-10-12', 1,4), 
-- (15, '俞莲舟', 38, '销售',4600, '2004-10-12', 14,4), 
-- (16, '宋远桥', 40, '销售',4600, '2004-10-12', 14,4), 
-- (17, '陈友谅', 42, null,2000, '2011-10-12', 1,null);

-- 5.2.1.1 多表普通查询
-- 此方根据笛卡尔积生成很多记录，包含了两张表的所有排列组合情况
select * from emp_dep,dept;
-- 去除无效笛卡尔积 --> 加上连接查询的条件即可
select * from emp_dep,dept where emp_dep.dept_id=dept.id; -- （id=17的员工无dept_id，因此无法查询到 ） 

-- 5.2.1.2 连接查询
-- 一、内连接(隐式内连接，显式内连接) --> 查询表1表2的交集部分
/**
	隐式内连接：SELECT 字段列表 FROM 表1 , 表2 WHERE 条件 ... ; 
	显式内连接：SELECT 字段列表 FROM 表1 [ INNER ] JOIN 表2 ON 连接条件 ... ; 
*/
-- 案例1：查询每一个员工的姓名，及关联部门的名称（隐式内连接实现）
select e.name,d.name from emp_dep e,dept d where e.dept_id=d.id;  
-- 案例2：查询每一个员工的姓名，及关联部门的名称（显式内连接实现）
select e.name,d.name from emp_dep e inner join dept d on e.dept_id=d.id;
select e.name,d.name from emp_dep e join dept d on e.dept_id=d.id;

-- 二、外连接(左外连接，右外连接)
/**
	1、	左外连接
    语    句：SELECT 字段列表 FROM 表1 LEFT [ OUTER ] JOIN 表2 ON 条件 ... ;
	查询范围：查询表1(左表)的所有数据，包含表1和表2交集部分
	2、右外连接与上述同理相反，语句把left改为right即可
*/
/**
注意事项： 
左外连接和右外连接是可以相互替换的，只需要调整在连接查询时SQL中，表结构的先后顺序就可以了。
而我们在日常开发使用时，更偏向于左外连接。

以下两个案例因为是查询所有数据，所以若想看出左连接和外连接的区别，
可以通过观察显示出的结果集中的部门名称
*/
-- 案例1(左外连接)：查询emp_dep所有数据，和对应的部门信息(因为是所有数据，所以无法使用内连接，因为无法交集)
select e.*,d.name '部门名称' from emp_dep e left outer join dept d on e.dept_id=d.id;
select e.*,d.name from emp_dep e left join dept d on e.dept_id=d.id;
-- 案例2(右外连接)：查询emp_dep所有数据，和对应的部门信息
select e.*,d.name '部门名称' from emp_dep e right outer join dept d on e.dept_id=d.id;
select e.*,d.name from emp_dep e right join dept d on e.dept_id=d.id;

-- 三、自连接(自连接查询，联合查询)
-- 1、自连接查询(自己连接自己,把一张表连接查询多次) --> SELECT 字段列表 FROM 表A 别名A JOIN 表A 别名B ON 条件 ... 
/**
注意事项: 
在自连接查询中，必须要为表起别名，要不然我们不清楚所指定的条件、返回的字段，到底 
是哪一张表的字段。 
*/
-- 案例1、查询员工及其所属领导的名字
select a.name,b.name boos from emp_dep a,emp_dep b where a.managerid=b.id;
-- 案例2、查询所有员工及其领导的名字，如果没有领导，也需查询出来
select a.name emploee,b.name boos from emp_dep a left join
emp_dep b on a.managerid=b.id;

-- 2、联合查询(把多次查询的结果合并起来，形成一个新的查询结果集)
/** 
语句：SELECT 字段列表 FROM 表A ... UNION [ ALL ] 
	  SELECT 字段列表 FROM 表B ....; 
对于联合查询的多张表的列数必须保持一致，字段类型也需要保持一致。 
union all 会将全部的数据直接合并在一起，union 会对合并之后的数据去重。
*/
-- 案例1：将薪资低于5000的员工和年龄大于50岁的所有员工查询出来
-- union all 没有对结果进行去重，union 进行去重处理
select * from emp_dep where age > 50 || salary < 5000;
select * from emp_dep a where a.salary<5000 union -- （all）
select * from emp_dep b where b.age>50 order by id;

-- 5.2.1.3  子查询
/**
概念：SQL语句中嵌套SELECT语句，称为嵌套查询，又称子查询。
SELECT * FROM t1 WHERE column1 = ( SELECT column1 FROM t2 ); 
子查询外部的语句可以是INSERT / UPDATE / DELETE / SELECT 的任何一个。

根据子查询结果不同，分为： 
A. 标量子查询（子查询结果为单个值） 
B. 列子查询(子查询结果为一列) 
C. 行子查询(子查询结果为一行) 
D. 表子查询(子查询结果为多行多列) 

根据子查询位置，分为： 
A. WHERE之后 
B. FROM之后 
C. SELECT之后
*/
-- 一、标量子查询(子查询返回的结果是单个值（数字、字符串、日期等），最简单的形式)
-- 常用的操作符：= <> > >= < <= 
-- 案例1、查询"销售部"的所有员工的信息
select * from emp_dep where dept_id = (select id from dept
where name='销售部');
select * from emp_dep e,dept d where e.dept_id=d.id and d.name='销售部';

-- 案例2、查询"张三丰"入职之后的员工信息
select * from emp_dep where entrydate > (select entrydate from 
emp_dep where name='张三丰');

-- 二、列子查询(子查询返回的结果是一列（可以是多行))
-- 常用的操作符：IN 、NOT IN 、 ANY 、SOME 、 ALL
-- 案例1、查询“销售部”和“市场部”的所有员工信息
select * from emp_dep where dept_id in (select id from dept 
where name='销售部' or name='市场部');
-- 案例2、查询比“研发部”其中任意一人工资高的员工信息
-- 查询研发部的工资
select salary from emp_dep where dept_id in (select id from 
 dept where name='研发部');
 -- 列子查询
select * from emp_dep where salary < any (select salary from
 emp_dep where dept_id in (select id from dept 
 where name='研发部'));
 
-- 三、行子查询(子查询返回的结果是一行（可以是多列））
-- 常用的操作符：= 、<> 、IN 、NOT IN
-- 案例一：查询与'张无忌'的薪资及直属领导相同的员工信息
select * from emp_dep where (salary,managerid)=(select 
salary,managerid from emp_dep where name='张无忌');

-- 四、表子查询(子查询返回的结果是多行多列)
-- 常用的操作符：in
-- 案例1：查询与'张无忌','金庸'的职位和薪资相同的员工信息
select * from emp_dep where (job,salary)in(select job,salary
from emp_dep where name='张无忌' or name='金庸');
-- 案例2：查询入职日期是‘2010-02-02’之后员工信息及其部门信息
select e.*,d.* from (select * from emp_dep where 
entrydate>'2008-02-02') e left join dept d on e.dept_id=d.id; 

-- 统计各个部门的员工数量
select d.id,d.name,(select count(1) from emp_dep e where 
e.dept_id=d.id) '数量' from dept d;



