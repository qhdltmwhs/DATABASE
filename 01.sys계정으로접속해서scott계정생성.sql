Run SQL Command Line 실행
--login없이  sqlplus start
C:\Users\stu>sqlplus /nolog

SQL*Plus: Release 11.2.0.2.0 Production on 월 4월 17 14:07:56 2

Copyright (c) 1982, 2014, Oracle.  All rights reserved.
--DAB로 계정접속 
SQL> connect sys/sys as sysdba;
Connected.
--유저생성
SQL>create user scott identified by tiger;

User created.
--현재유저보기
SQL> show user;
USER is "SYS"
--권한이불충분해서 접속안됨
SQL> connect scott/tiger;
ERROR:
ORA-01045: user SCOTT lacks CREATE SESSION privilege; logon denied

SQL> connect sys/sys as sysdba;

--권한부여
SQL> grant connect,resource to scott;

Grant succeeded.
--scott계정으로 접속
SQL> connect scott/tiger;
Connected.
SQL> show user;
USER is "SCOTT"
--USER 패쓰워드변경
SQL>alter user scott identified by lion;
SQL>alter user scott identified by tiger;
--USER UNLOCK,LOCK
SQL>alter user scott account lock;
SQL>alter user scott account unlock;
ORA-01031: insufficient privileges
--권한이불충분해서 LOCK,UNLOCK안됨
SQL> connect sys/sys as sysdba;
--계정대소문자구분하지않기(11g)
SQL>alter system set sec_case_sensitive_logon = false;