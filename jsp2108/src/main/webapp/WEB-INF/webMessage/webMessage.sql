show tables;

create table webMessage(
	idx int not null auto_increment primary key,
	title varchar(100) not null,
	content text not null,
	sendId varchar(20) not null,
	sendSw char(1) not null,					/* 보낸메시지s 휴지통g 휴지통삭제x */
	sendDate datetime default now(),
	receiveId varchar(20) not null,
	receiveSw char(1) not null,				/* 새메시지n 읽은메시지r 휴지통g 휴지통삭제x */
	receiveDate datetime default now()
);

desc webMessage;

insert into webMessage values(default, '안녕! 말쑥아', '주말에 시간있니?', 'hkd1234', 's', default, 'kms1234', 'n', default);
insert into webMessage values(default, '답장! 반갑다 길동아', '주말에 프로젝트 계획이 있어서 다음에 만나자', 'kms1234', 's', default, 'hkd1234', 'n', default);

select * from webMessage order by idx desc;

select * from webMessage where receiveSw='n' || receiveSw='r' order by idx desc;