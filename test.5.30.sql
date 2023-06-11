use bigdata;
select * from emp;

#  分组查询 group by 
-- where是分组前条件查询  - having是分组后条件查询
-- 根据性别分组，统计男性员工和女性员工的数量
select id from emp group by gender;
select gender,count(*) from emp group by gender;
-- 根据性别分组，统计男性员工和女性员工的平均年龄
select gender,avg(age) from emp group by gender;
-- 统计年龄小于45，再按工作地址分组，筛选出员工数量大于3的地址
select workaddress,count(*) '员工' from emp where age<45 
group by workaddress having count(*)>=3;
-- select * from emp where age<45;
-- 统计各个工作地址上班的男性及女性员工的数量
select workaddress,gender,count(*) '数量' from emp 
group by gender,workaddress;

# 排序查询 order by  asc(升序) desc(降序)
-- age 升序
select * from emp order by age  asc;

# 分页查询 Limit  (类似于访问数组，从下标0开始，起始位置和终止位置)
-- 查看第一页员工数据，每页展示10条数据
select * from emp limit 0,10;
select * from emp limit 10;
-- 查询第二页数据，每页展示10条记录--->(页码-1)*页展示记录数
select * from emp limit 10,10;

drop table dept;
-- 创建dept表，并插入数据 
create table dept( 
id int auto_increment comment 'ID' primary key, 
name varchar(50) not null comment '部门名称' 
)comment '部门表',char set = utf8; 
show tables;
INSERT INTO dept (id, name) VALUES (1, '研发部'), (2, '市场部'),
(3, '财务部'), (4, '销售部'), (5, '总经办'), (6, '人事部');

-- 创建emp表，并插入数据 
create table emp2( 
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
alter table emp2 add constraint fk_emp2_dept_id 
foreign key (dept_id) references dept(id);

INSERT INTO emp2 (id, name, age, job,salary, entrydate, managerid, dept_id) VALUES 
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

select * from emp2;





