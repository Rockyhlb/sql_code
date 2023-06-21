create database zy;
use zy;
create table goods_zhouyue (
	`id` varchar(8),
	`type` varchar(8),
	`name` varchar(10),
	`price` float(4),
	`num` int(4),
	`add_time` date
)charset=utf8;

insert into goods_zhouyue values( 1,'食品','喜之郎果冻',12,6,'2023-06-21');
insert into goods_zhouyue values( 2,'食品','旺仔牛奶糖',12,6,'2023-04-23');
