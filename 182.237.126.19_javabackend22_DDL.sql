--DDL

select * from dept2;

create table dept2(
    deptno number(2),
    dname varchar(50),
    loc varchar2(50)
);

--ORA-00955: name is already used by an existing object
create table javabackend22.dept2(
    deptno number(2),
    dname varchar(50),
    loc varchar2(50)
);

create table javabackend22.dept3(
    deptno number(2),
    dname varchar(50),
    loc varchar2(50)
);

--default

create table def_table(
    num number(2),
    write_day date
);
insert into def_table(num) values(1);
insert into def_table(num, write_day) values(2, sysdate);
insert into def_table(num, write_day) values(3, sysdate);
insert into def_table(num, write_day) values(4, sysdate);

select * from def_table;


create table def_table2(
    num number(2),
    write_day date default sysdate
);
insert into def_table2(num) values(1);
insert into def_table2(num) values(2);
insert into def_table2(num) values(3);
insert into def_table2(num) values(4);
insert into def_table2(num) values(5);
insert into def_table2(num, write_day) values(6, to_date('2020-06-06', 'YYYY-MM-DD'));
insert into def_table2(num, write_day) values(7, sysdate);
insert into def_table2(num, write_day) values(8, default);
insert into def_table2(num, write_day) values(9, null);
select * from def_table2;

create table def_board(
    no number(5),
    title varchar2(100),
    content varchar2(255),
    write_day date default sysdate,
    read_count number(5) default 0,
    is_secret char(1) default 'F',
    write_user varchar2(30) default 'guest'
);

insert into def_board(no, title, content) values(1, '오늘은 월요일 입니다.', '너무기뻐요');
insert into def_board(no, title, content) values(2, '오늘은 화요일 입니다.', '여전히 너무기뻐요');
insert into def_board(no, title, content) values(3, '오늘은 수요일 입니다.', '좀덜 기뻐요');
insert into def_board(no, title, content, write_day, read_count, is_secret)
                        values(4, '오늘은 수요일 입니다.', '좀덜 기뻐요', to_date('2020/01/01', 'YYYY/MM/DD'), 999, 'T');
insert into def_board(no, title, content, write_day, read_count, is_secret, write_user)
                        values(5, '오늘은 금요일 입니다.', '다시 기뻐요', to_date('2099/09/09', 'YYYY/MM/DD'), 888, 'T', 'guard');                        
commit;
select * from def_board;    

--DATA TYPE

create table data_type(
    no number(4),
    name varchar2(20),
    gender char(1) default 'M',
    height number(5, 2)
); 

insert into data_type values(1234, '김경호', 'M', 175.55);

--ORA-01438: value larger than specified precision allowed for this column
insert into data_type values(12345, '김경미', 'F', 155.55);

--ORA-12899: value too large for column "JAVABACKEND22"."DATA_TYPE"."NAME" (actual: 21, maximum: 20)
insert into data_type values(1111, '김경미는누구게', 'F', 167.55);

--ORA-12899: value too large for column "JAVABACKEND22"."DATA_TYPE"."GENDER" (actual: 6, maximum: 1)
insert into data_type values(1111, '김경미', 'FEMALE', 167.55);

--소수점이하 자리수는 반올림
insert into data_type values(1111, '김경미', 'F', 167.55555555);

--ORA-01438: value larger than specified precision allowed for this column
insert into data_type values(2222, '김경양', 'F', 1167.5);

select * from data_type;

--date, timestamp

create table date_time(
    day1 date,
    day2 timestamp,     --10의 -6승 초
    day3 timestamp(9)   --10의 -9승 초
);    
select * from date_time;

insert into date_time values(sysdate, systimestamp, systimestamp);
insert into date_time values(to_date('1998/12/01 05:30:45', 'YYYY/MM/DD HH:MI:SS'),
                                        to_timestamp('1998/12/01 05:30:45.123456', 'YYYY/MM/DD HH:MI:SS.FF6'),
                                         to_timestamp('1998/12/01 05:30:45.123456789', 'YYYY/MM/DD HH:MI:SS.FF9'));

select to_char(day1, 'YYYY/MM/DD HH:MI:SS'), day2, day3 from date_time;                                         