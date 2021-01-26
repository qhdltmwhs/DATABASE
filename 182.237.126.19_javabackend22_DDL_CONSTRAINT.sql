--CONSTRAINT (제약조건)
/*
1. not null
2. unique
3. primary key
4. foreign key
5. check
*/

/*********************************************************************/
--1. not null
/*********************************************************************/
drop table sawon1;
create table sawon1(
    no number(4),
    name varchar2(50) not null,
    hiredate date constraint sawon1_hiredate_nn not null
);
desc sawon1;
/*
이름       널?       유형           
-------- -------- ------------ 
NO                NUMBER(4)    
NAME     NOT NULL VARCHAR2(50) 
HIREDATE NOT NULL DATE
*/
insert into sawon1 values(1, '홍길동', sysdate);

--ORA-01400: cannot insert NULL into ("JAVABACKEND22"."SAWON1"."HIREDATE")
insert into sawon1 values(2, '홍길서', null);

--ORA-01400: cannot insert NULL into ("JAVABACKEND22"."SAWON1"."NAME")
insert into sawon1 values(3, null, sysdate);

--ORA-01400: cannot insert NULL into ("JAVABACKEND22"."SAWON1"."HIREDATE")
insert into sawon1(no, name) values(4, '홍길북');

select * from user_constraints where table_name = 'SAWON1';
/*********************************************************************/
--2.unique(중복데이타 허용안함,null은허용)
/*********************************************************************/
drop table sawon2;
--컬럼수준--
create table sawon2(
    no number(4),
    id varchar2(50) constraint sawon2_id_uq unique,             --컬럼수준--
    name varchar2(50),
    email varchar2(50) constraint sawon2_email_uq unique    --컬럼 수준--
);

insert into sawon2 values(1, 'xxx', '홍길동', 'aaa@gmail.com');

--ORA-00001: unique constraint (JAVABACKEND22.SAWON2_EMAIL_UQ) violated
insert into sawon2 values(2, 'yyy', '홍길서', 'aaa@gmail.com');

--ORA-00001: unique constraint (JAVABACKEND22.SAWON2_ID_UQ) violated
insert into sawon2 values(3, 'xxx', '홍길남', 'ccc@gmail.com');

insert into sawon2 values(5, null, '홍길북', null);
insert into sawon2 values(6, null, '청길남', null);

select * from sawon2;

--테이블수준--
drop table sawon3;
create table sawon3(
    no number(4),
    id varchar2(50)  
    name varchar2(50),
    email varchar2(50),
    constraint sawon3_id_uq unique(id),             --테이블수준--
    constraint sawon3_email_uq unique(email)    --테이블수준--
);

/*********************************************************************/
--3. primary key(unique + not null)
/*********************************************************************/
drop table sawon5;
create table sawon5(
    no number(4) constraint sawon5_no_pk primary key,
    name varchar2(50) not null,
    sal number(10, 3) default 0 not null
);    
desc sawon5;
insert into sawon5 values(1, '이소라', 200.225); 

--ORA-00001: unique constraint (JAVABACKEND22.SAWON5_NO_PK) violated
insert into sawon5 values(1, '삼소라', 200.225);

--ORA-01400: cannot insert NULL into ("JAVABACKEND22"."SAWON5"."NO")
insert into sawon5 values(null, '사소라', 200.225);

--ORA-01400: cannot insert NULL into ("JAVABACKEND22"."SAWON5"."NO")
insert into sawon5(name, sal) values('사소라', 8000.9090);

drop table sawon51;
 --컬럼수준--
create table sawon51(
    no number(4) primary key,                --컬럼수준--
    name varchar2(50) not null,
    sal number(10, 3) default 0 not null
);
desc sawon6;
--테이블수준--
drop table sawon6;
create table sawon6(
    no number(4),
    name varchar2(50) not null,
    sal number(10, 3) default 0 not null,
    constraint sawon6_no_pk primary key(no)     --테이블수준--
);

desc sawon61;
--테이블수준--
drop table sawon61;
create table sawon61(
    no number(4),
    name varchar2(50) not null,
    sal number(10, 3) default 0 not null,
    primary key(no)     --테이블수준--
);


--ERD Tool  
desc sawon62;
drop table sawon62;
create table sawon62(
    no number(4),
    name varchar2(50) not null,
    sal number(10, 3) default 0 not null
);
alter table sawon62 add constraint sawon62_no_pk primary key(no);

--primary key 복합키(컬럼이여러개)-->테이블 레벨에서만 설정이 가능
drop table student_locker;
create table student_locker(
    ban number(2),
    locker_no number(2),
    name varchar2(20),
    constraint stu_locker_ban_locker_no_pk primary key(ban, locker_no)
);
insert into student_locker values(1, 1, 'KIM');
insert into student_locker values(1, 2, 'JIM');
insert into student_locker values(1, 3, 'MIM');

insert into student_locker values(2, 1, 'CIM');
insert into student_locker values(2, 2, 'SIM');
insert into student_locker values(2, 3, 'AIM');

insert into student_locker values(3, 1, 'UIM');
insert into student_locker values(3, 2, 'QIM');
insert into student_locker values(3, 3, 'WIM');

--ORA-00001: unique constraint (JAVABACKEND22.STU_LOCKER_BAN_LOCKER_NO_PK) violated
insert into student_locker values(1, 1, 'KIM');

--ORA-01400: cannot insert NULL into ("JAVABACKEND22"."STUDENT_LOCKER"."LOCKER_NO")
insert into student_locker values(1, null, 'VIM');

--ORA-01400: cannot insert NULL into ("JAVABACKEND22"."STUDENT_LOCKER"."BAN")
insert into student_locker values(null, 4, 'VIM');

select * from student_locker where ban = 1;
select * from student_locker where ban =1 and locker_no = 1;
select * from student_locker where ban =1 and locker_no = 2;
select * from student_locker where ban =1 and locker_no = 3;

/*********************************************************************/
--4. foreign key(외래키)
/*********************************************************************/
/*
    parent  table (부모 테이블, 참조되는 테이블)
    child    table (자식 테이블, 참조하는 테이블)
*/
--foreign key (외래키) case1
--parent table
drop table dept2;
create table dept2(
    deptno number(4) primary key,
    dname varchar2(30) not null,
    loc varchar2(30)
);
insert into dept2 values(10, '인사', '서울');
insert into dept2 values(20, '생산', '울산');
insert into dept2 values(30, '영업', '제주');
insert into dept2 values(40, '홍보', '대전');
select * from dept2;

--child table
drop table emp2;
create table emp2(
    empno number(4) primary key,
    ename varchar2(20),
    sal number(10,0),
    deptno number(4) constraint emp2_deptno_fk references dept2(deptno)
);

insert into emp2 values(1111, 'KIM', 30000, 10);
insert into emp2 values(2222, 'HIM', 40000, 10);
insert into emp2 values(3333, 'DIM', 23000, 10);

insert into emp2 values(4444, 'BIM', 34000, 20);
insert into emp2 values(5555, 'FIM', 22000, 20);

insert into emp2 values(6666, 'SIM', 77000, 30);
insert into emp2 values(7777, 'PIM', 88000, 30);

insert into emp2 values(8888, 'EIM', 0, null);
insert into emp2 values(9999, 'QIM', 0, null);

--ORA-02291: integrity constraint (JAVABACKEND22.EMP2_DEPTNO_FK) violated - parent key not found
insert into emp2 values(8888, 'MIN', 88000, 90);
select * from emp2;

update emp2 set deptno = 40 where empno = 1111;

--ORA-02291: integrity constraint (JAVABACKEND22.EMP2_DEPTNO_FK) violated - parent key not found
update emp2 set deptno = 90 where empno = 1111;

--ORA-02292: integrity constraint (JAVABACKEND22.EMP2_DEPTNO_FK) violated - child record found
delete dept2 where deptno = 10;

select * from emp2 natural join dept2;
select * from emp2 left outer join dept2 on dept2.deptno = emp2.empno;

--foreign key (외래키) case2
/*
    parent  table (부모 테이블, 참조되는 테이블)
    child    table (자식 테이블, 참조하는 테이블)
*/
--parent table
drop table dept3;
create table dept3(
    deptno number(4) primary key,
    dname varchar2(30) not null,
    loc varchar2(30)
);
insert into dept3 values(10, '인사', '서울');
insert into dept3 values(20, '생산', '울산');
insert into dept3 values(30, '영업', '제주');
insert into dept3 values(40, '홍보', '대전');
select * from dept3;

--child table
drop table emp3;
create table emp3(
    empno number(4) primary key,
    ename varchar2(20),
    sal number(10,0),
    deptno number(4),
    constraint emp3_deptno_fk foreign key(deptno) references dept3(deptno)
);

insert into emp3 values(1111, 'KIM', 30000, 10);
insert into emp3 values(2222, 'HIM', 40000, 10);
insert into emp3 values(3333, 'DIM', 23000, 10);

insert into emp3 values(4444, 'BIM', 34000, 20);
insert into emp3 values(5555, 'FIM', 22000, 20);

insert into emp3 values(6666, 'SIM', 77000, 30);
insert into emp3 values(7777, 'PIM', 88000, 30);

insert into emp3 values(8888, 'EIM', 0, null);
insert into emp3 values(9999, 'QIM', 0, null);

--ORA-02291: integrity constraint (JAVABACKEND22.EMP3_DEPTNO_FK) violated - parent key not found
insert into emp3 values(1000, 'TIM', 9090, 90);

--ORA-02292: integrity constraint (JAVABACKEND22.EMP3_DEPTNO_FK) violated - child record found
delete dept3 where deptno = 10;

/*********************************************************************/
--5. check constraint
/*********************************************************************/
drop table emp4;
create table emp4(
    empno number(4) primary key,
    ename varchar2(50) not null,
    sal number(10),
    gender char(1) default 'm',
    constraint emp4_sal_ck check(sal >= 500 and sal <= 1000),
    constraint emp4_gender_ck check(gender = 'm' or gender = 'f')
);
insert into emp4 values(1, 'KIM', 800, 'f');
insert into emp4 values(2, 'LEE', 900, 'm');

ORA-02290: check constraint (JAVABACKEND22.EMP4_SAL_CK) violated
insert into emp4 values(3, 'PARK', 1200, 'f');

ORA-02290: check constraint (JAVABACKEND22.EMP4_SAL_CK) violated
insert into emp4 values(4, 'CHOI', 300, 'm');

ORA-02290: check constraint (JAVABACKEND22.EMP4_GENDER_CK) violated
insert into emp4 values(5, 'SIM', 800, 'x');

select * from emp4;

/*********************************************************************/
--drop, rename
/*********************************************************************/
drop table emp5;
create table emp5(
    empno number(4) primary key,
    ename varchar2(50) not null,
    sal number(10,2) default 0 not null,
    gender char(1) default 'f'
);
insert into emp5 values(1, 'KIM', 300, 'f');
insert into emp5 values(2, 'KIO', 400, 'm');
insert into emp5 values(3, 'KIP', 500, 'f');
insert into emp5 values(4, 'KIQ', 700, 'm');
commit;
select * from emp5;

drop table emp6;
create table emp6(
    empno number(4) primary key,
    ename varchar2(50) not null,
    sal number(10,2) default 0 not null,
    gender char(1) default 'f'
);
insert into emp6 values(1, 'KIM', 300, 'f');
insert into emp6 values(2, 'KIO', 400, 'm');
insert into emp6 values(3, 'KIP', 500, 'f');
insert into emp6 values(4, 'KIQ', 700, 'm');
commit;
select * from emp6;

rename emp6 to emp66;
desc emp6;
desc emp66;
select * from emp66;
