use bigdata;
show tables;
select * from dept;
select * from emp2;

drop table if exists dept;

-- 创建dept表，并插入数据 
create table dept( 
id int auto_increment comment 'ID' primary key, 
name varchar(50) not null comment '部门名称' 
)comment '部门表',char set=utf8; 
INSERT INTO dept (id, name) VALUES (1, '研发部'), (2, '市场部')
,(3, '财务部'), (4, '销售部'),(5, '总经办'), (6, '人事部');

-- 创建emp_dep表，并插入数据 
create table emp_dep( 
id int auto_increment comment 'ID' primary key, 
name varchar(50) not null comment '姓名', 
age int comment '年龄', 
job varchar(20) comment '职位', 
salary int comment '薪资', 
entrydate date comment '入职时间', 
managerid int comment '直属领导ID', 
dept_id int comment '部门ID' 
)comment '员工表',char set=utf8; 

-- 添加外键 
alter table emp_dep add constraint fk_emp_dept_id 
foreign key (dept_id) references dept(id); 

INSERT INTO emp_dep (id, name, age, job,salary, entrydate, managerid, dept_id) VALUES 
(1, '金庸', 66, '总裁',20000, '2000-01-01', null,5), 
(2, '张无忌', 20, '项目经理',12500, '2005-12-05', 1,1), 
(3, '杨逍', 33, '开发', 8400,'2000-11-03', 2,1), 
(4, '韦一笑', 48, '开发',11000, '2002-02-05', 2,1), 
(5, '常遇春', 43, '开发',10500, '2004-09-07', 3,1), 
(6, '小昭', 19, '程序员鼓励师',6600, '2004-10-12', 2,1), 
(7, '灭绝', 60, '财务总监',8500, '2002-09-12', 1,3), 
(8, '周芷若', 19, '会计',48000, '2006-06-02', 7,3), 
(9, '丁敏君', 23, '出纳',5250, '2009-05-13', 7,3), 
(10, '赵敏', 20, '市场部总监',12500, '2004-10-12', 1,2), 
(11, '鹿杖客', 56, '职员',3750, '2006-10-03', 10,2), 
(12, '鹤笔翁', 19, '职员',3750, '2007-05-09', 10,2), 
(13, '方东白', 19, '职员',5500, '2009-02-12', 10,2), 
(14, '张三丰', 88, '销售总监',14000, '2004-10-12', 1,4), 
(15, '俞莲舟', 38, '销售',4600, '2004-10-12', 14,4), 
(16, '宋远桥', 40, '销售',4600, '2004-10-12', 14,4), 
(17, '陈友谅', 42, null,2000, '2011-10-12', 1,null);

select * from emp_dep;
select * from emp_dep,dept;
select * from emp_dep,dept where emp_dep.dept_id=dept.id;


#  查询每个员工的姓名，及关联的部门的名称（隐式内连接实现 -- 交集），起别名
select emp_dep.name,dept.name from emp_dep,dept where emp_dep.dept_id=dept.id;
select e.name,d.name from emp_dep e,dept d where e.dept_id=d.id;
#  查询每个员工的姓名，及关联的部门的名称（显式内连接实现），起别名
select e.name,d.name from emp_dep e join dept d on e.dept_id=d.id;


# 左外连接（包含交集） -- 和内连接相似，右外连接把“left”改为“right”即可  --  我们在日常开发使用时，更偏向于左外连接。
select e.name,d.name from emp_dep e left join dept d on e.dept_id=d.id;


#  自连接查询，顾名思义，就是自己连接自己，也就是把一张表连接查询多次
-- SELECT 字段列表 FROM 表A 别名A JOIN 表A 别名B ON 条件 ... ; 
-- 在自连接查询中，必须要为表起别名，要不然我们不清楚所指定的条件、返回的字段，到底是哪一张表的字段

-- 查询员工及其领导的名字
select a.name '员工' , b.name '领导' from emp_dep a,emp_dep b where a.managerid=b.id;



