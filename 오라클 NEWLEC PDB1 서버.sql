DROP TABLE MEMBER;
CREATE TABLE MEMBER 
(
  ID VARCHAR2(50) 
, PWD NVARCHAR2(50) 
, NAME NVARCHAR2(50) 
, GENDER NCHAR(2) 
, AGE NUMBER(3)
, BIRTHDAY CHAR(10)
, PHONE CHAR(13)
, REGDATE DATE 
);

DROP TABLE NOTICE;
CREATE TABLE NOTICE
(
     ID		NUMBER,
     TITLE 		NVARCHAR2(100),
     WRITER_ID	NVARCHAR2(50),
     CONTENT	CLOB,
     REGDATE  	TIMESTAMP,
     HIT		NUMBER,
     FILES		NVARCHAR2(1000)
);

DROP TABLE "COMMENT";
CREATE TABLE "COMMENT"
(
     ID		NUMBER,
     CONTENT	NVARCHAR2(2000),
     REGDATE  	TIMESTAMP,
     WRITER_ID	NVARCHAR2(50),
     NOTICE_ID	NUMBER
);

DROP TABLE ROLE;
CREATE TABLE ROLE
(
     ID		VARCHAR2(50),
     DISCRIPTION 	NVARCHAR2(500)
);

DROP TABLE MEMBER_ROLE;
CREATE TABLE MEMBER_ROLE
(
     MEMBER_ID	NVARCHAR2(50),
     ROLE_ID		VARCHAR2(50)
);
 
 
SELECT LENGTH('ab') FROM DUAL;
SELECT LENGTHB('ab') FROM DUAL;
 
SELECT LENGTH('한글') FROM DUAL;
SELECT LENGTHB('한글') FROM DUAL;
 
SELECT * FROM SYS.nls_database_parameters;
 
ALTER TABLE MEMBER MODIFY ID NVARCHAR2(50);
ALTER TABLE MEMBER DROP COLUMN AGE;
ALTER TABLE MEMBER ADD EMAIL VARCHAR2(200);
 
insert into member(id, pwd) values('newlec', '111'); 
insert into member(id, pwd) values('test', '111');
select id, name "USER ID", pwd from member;

update member set pwd = '111' , name='손오공' where id = 'dragon';
delete member where id='test'; 

select hit+1 hit from notice;
select name||'('||id||')' name from member;