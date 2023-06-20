use bigdata;

drop table goods_;
create table goods_ (
	`id` varchar(8),
	`type` varchar(8),
	`name` varchar(10),
	`price` float(4),
	`num` int(4),
	`add_time` datetime
)charset=utf8;

insert into goods_(id,type,name,price,num,add_time) values(1,'书籍','西游记',50.4,20,'2018-01-01 13:40:40');
insert into goods_(id,type,name,price,num,add_time) values(2,'糖类','牛奶糖',7.5,200,'2018-02-02 13:40:40');
insert into goods_(type,name,price) values('糖类','水果糖',2.5);
insert into goods_ values(null,'糖类','水果糖',2.5,null,null);
insert into goods_ values(4,'服饰','休闲西服',800,null,'2016-04-04 13:40:40');
insert into goods_ values(5,'饮品','果汁',3,70,'2016-05-05 13:40:40');
insert into goods_ values(6,'书籍','论语',109,50,'2018-06-06 13:40:40');

select * from goods_;