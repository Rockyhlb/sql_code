show databases;
use bigdata;
show tables;

show create table students_inf;
show create table students_score;
desc students_inf;
desc students_score;

-- mvn_AbstractFactory所需表：
-- 主表：学生信息表，记录学生信息
CREATE TABLE `students_inf` (
	`id` int(8) NOT NULL,  
	`name` varchar(8) NOT NULL,  
	`sex` varchar(8) DEFAULT '男',  
	`age` int(2) DEFAULT NULL, 
	`enter_time` date DEFAULT NULL,
	`email` varchar(15) DEFAULT NULL, 
	PRIMARY KEY (`id`),
	UNIQUE KEY `email` (`email`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

select * from students_inf;

-- 从表：学生成绩表，记录学生成绩，id作为外键连接到学生信息表，进行约束
create table students_score(
	`score_id` varchar(12) primary key,
    `name` varchar(4) not null,
    `Java` tinyint unsigned default 0,
    `CLanguage` tinyint unsigned default 0,
    `DataBase` tinyint unsigned default 0,
    `OS` tinyint unsigned  default 0,
    constraint fk_sc_scoreId foreign key(score_id) references students_inf(id)
)charset=utf8;

insert into students_score values(12,'美羊羊',67,89,99,78);
-- 无法插入(外键约束)
insert into students_score values(21,'美羊羊',67,89,99,78);

select * from students_score;

