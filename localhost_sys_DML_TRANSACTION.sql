/*
localhost scott에 접속
*/

select * from scott.emp where ename = 'KING';

--LOCK 경합 (sys)
select * from scott.dept;

--90번 부서가 lock이 걸려있으므로 waitting 상태
--90번 부서가 lock이 풀리면 update
--transaction시작
update scott.dept set loc = '서울'
where deptno = 90;

select * from scott.dept;
--transaction종료
rollback;
select * from scott.dept;
