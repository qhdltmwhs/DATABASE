--2021-01-19
--1
SELECT NAME, SUBSTR(JUMIN, 3, 4) "Birthday" FROM STUDENT WHERE DEPTNO1 = '101';
SELECT NAME, CONCAT(CONCAT(SUBSTR(JUMIN, 3, 2), '월 '), CONCAT(SUBSTR(JUMIN, 5, 2), '일')) "Birthday"
FROM STUDENT WHERE DEPTNO1 = '101';

--2
SELECT NAME, TEL, SUBSTR(TEL, 1, INSTR(TEL, ')', 1, 1)-1) "AREA CODE" FROM STUDENT WHERE DEPTNO1 = '201';

--3
SELECT NAME, JUMIN, REPLACE(JUMIN, SUBSTR(JUMIN, 7), '*******') "REPLACE" FROM STUDENT WHERE DEPTNO1 = '101'; 
SELECT NAME, JUMIN, REPLACE(JUMIN, SUBSTR(JUMIN, 7), '-*******') "REPLACE" FROM STUDENT WHERE DEPTNO1 = '101'; 

--4
SELECT NAME, TEL, REPLACE(TEL, SUBSTR(TEL, INSTR(TEL, '-')+1), '****') "REPLACE" FROM STUDENT WHERE DEPTNO1 = '101'; 

--2021-01-20
--1
select deptno, count(deptno)
from emp
group by deptno
having count(deptno) >= 6;

--2
select deptno,
            sum(decode(job, 'CLERK', sal, 0)) "CLERK",
            sum(decode(job, 'MANAGER', sal, 0)) "MANAGER",
            sum(decode(job, 'PRESIDENT', sal, 0)) "PRESIDENT",
            sum(decode(job, 'ANALYST', sal, 0)) "ANALYST",
            sum(decode(job, 'SALESMAN', sal, 0)) "SALESMAN"
from emp
group by deptno
order by deptno asc;

--3
select to_char(hiredate, 'YYYY') 년, to_char(hiredate, 'MM') 월, SUM(SAL)
from emp
group by to_char(hiredate, 'YYYY'), to_char(hiredate, 'MM')
order by 1;

--4
select deptno, sum(sal*12) "연봉"
from emp
group by deptno
order by deptno asc;

select deptno, sum((sal+nvl(comm, 0))*12) "연봉"
from emp
group by deptno
order by deptno asc;

--5
select job, sum(sal)
from emp
group by job
having job != 'SALESMAN';

--2021-01-21
--1
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno
order by 2;

--2
select e.empno, e.ename, e.sal, d.dname
from emp e, dept d
where e.deptno = d.deptno and e.sal >= 2000
order by e.sal desc;

--3
select e.empno, e.ename, e.job, e.sal, d.dname
from emp e, dept d
where e.deptno = d.deptno and e.job = 'MANAGER' and e.sal >= 2500
order by e.empno asc;

--4
select e.empno, e.ename, e.sal, g.grade
from emp e, salgrade g
where e.sal >= g.losal and e.sal <= g.hisal and g.grade = 4
order by 3 desc;

--5
select e.empno, e.ename, d.dname, e.sal, g.grade
from emp e, dept d, salgrade g
where (e.deptno = d.deptno) and (e.sal >= g.losal and e.sal <= g.hisal)
order by g.grade;

--6
select e1.ename, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno(+);

--7
select e1.ename, e2.ename, e3.ename
from emp e1, emp e2, emp e3
where (e1.mgr = e2.empno) and (e2.mgr = e3.empno);

--8
select e1.ename, e2.ename, e3.ename
from emp e1, emp e2, emp e3
where (e1.mgr = e2.empno(+)) and (e2.mgr = e3.empno(+));