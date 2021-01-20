--JOIN
--ORACLE JOIN
--CROSS JOIN(CATESIAN PRODUCT)
SELECT EMPNO, ENAME, JOB, MGR, SAL, EMP.DEPTNO AS "EMP.DEPTNO", DEPT.DEPTNO AS "DEPT.DEPTNO", DNAME, LOC
FROM EMP, DEPT;

--TABLE ALIAS ( 테이블의 alias 는 as 기술하면 안된다.!!!)
SELECT EMPNO, ENAME, JOB, MGR, SAL, e.DEPTNO AS "EMP.DEPTNO", d.DEPTNO AS "DEPT.DEPTNO", DNAME, LOC
FROM EMP e, DEPT d;

--EQI JOIN(동등 조건)
select empno, ename, dname, loc
from emp, dept
where emp.deptno = dept.deptno;

--테이블에 alias 를 넣은경우
select empno, ename, dname, loc
from emp e, dept d
where e.deptno = d.deptno;

select empno, ename, dname, loc
from emp e, dept d
where e.deptno = d.deptno and e.deptno = 10;

--NON EQI JOIN(비동등 조건)
select * from emp;
select * from salgrade;

select e.empno, e.ename, e.sal, g.grade
from emp e, salgrade g
where e.sal >= g.losal and e.sal <= g.hisal;

--inner join (조인조건에 만족하는 행만 출력
--부서에 소속된 사원의 사원정보와 부서정보 출력
select empno, ename, dname, loc
from emp e, dept d
where e.deptno = d.deptno;

--outer join (조인조건에 만족하지 않는 행도 포함 출력)
--left outer join [조인조건에 만족하지않는 emp행들출력] 
select empno, ename, dname, loc
from emp e, dept d
where e.deptno = d.deptno(+);

--right outer join [조인조건에 만족하지않는 dept행들출력] 
select empno, ename, dname, loc
from emp e, dept d
where e.deptno(+) = d.deptno;

--full outer join [조인조건에 만족하지않는 emp, dept 행들출력]
select empno, ename, dname, loc
from emp e, dept d
where e.deptno = d.deptno(+)
UNION
select empno, ename, dname, loc
from emp e, dept d
where e.deptno(+) = d.deptno;

--self join
--inner join (매니저를 가지는 사원만 출력)
select e.empno 사원번호, e.ename 사원이름, m.empno 매니저사번, m.ename 매니저이름
from emp e, emp m
where e.mgr = m.empno;

--outer join (매니저가 없는 사원도 출력)
select e.empno 사원번호, e.ename 사원이름, m.empno 매니저사번, m.ename 매니저이름
from emp e, emp m
where e.mgr = m.empno(+);

--3개이상의 테이블 조인의 예)--
select e.empno, e.ename, e.sal, d.dname, d.loc, g.grade
from emp e, dept d, salgrade g
where e.deptno = d.deptno and (e.sal >= g.losal and e.sal <= g.hisal);

--SQL 1999(SQL3) 조인[ANSI조인, 표준조인]
--CROSS JOIN
