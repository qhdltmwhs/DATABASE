drop table A;
drop table B;

create table A(val char);
create table B(num number,val char);

insert into A values('A');
insert into A values('B');
insert into A values('C');
insert into A values('D');
insert into A values('E');

insert into B values(1,'C');
insert into B values(2,'D');
insert into B values(3,'E');
insert into B values(4,'F');
insert into B values(5,'G');
commit;