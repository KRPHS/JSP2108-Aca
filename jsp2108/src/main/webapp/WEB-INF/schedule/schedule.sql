show tables;

create table schedule(
	idx int not null auto_increment primary key,
	mid varchar(20) not null,
	sDate datetime not null default now(),
	part varchar(10) not null,
	content text not null
);

delete from schedule;
drop table schedule;

insert into schedule value (default, 'hkd1234', default, '모임', '저심약속: 청주사거리 맛집 6시');
insert into schedule value (default, 'hkd1234', '2021-09-02', '모임', '점심약속: 청주사거리 맛집 11시');

select * from schedule;
select * from schedule where date(sDate) = '2021-12-02' and mid = 'hkd1234';
