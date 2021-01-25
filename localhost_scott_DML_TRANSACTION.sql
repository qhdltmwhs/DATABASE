
/*
localhost scott에 접속
*/

--transaction시작
update emp set sal = 6000 where ename = 'KING';
select sal from emp where ename = 'KING';
--transaction종료
commit;
select sal from emp where ename = 'KING';

--transaction시작
update emp set sal = 9999 where ename = 'KING';
select sal from emp where ename = 'KING';
--transaction종료
rollback;
select sal from emp where ename = 'KING';

--LOCK 경합 (scott)
select * from dept;
insert into dept values(90, '경리과', '부산');
commit;

--transaction시작
--90번 부서가 lock이 걸림
update dept set dname = '인사과'
where deptno = 90;
select * from dept;
--transaction종료
rollback;
select * from dept;