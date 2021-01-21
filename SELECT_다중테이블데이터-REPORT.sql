--2021-01-21
/*
1. 부서 테이블과 사원테이블에 사번, 사원명, 부서코드, 부서명을 검색하시오.
   (사원명 오름차순 정렬할 것) 
*/
--Oracle 조인
select empno "사원번호", ename "사원이름", deptno "부서코드", dname "부서명" 
from emp e, dept d
where e.deptno = d.deptno
order by 2;

--ANSI 조인
select empno "사원번호", ename "사원이름", deptno "부서코드", dname "부서명" 
from emp 
natural join dept 
order by 2;

/*
2. 부서 테이블과 사원테이블에서 사번, 사원명, 급여, 부서명을 검색하시오.
    단, 급여가 2000 이상인 사원에 대하여 급여기준으로 내림차순 정렬할 것.
*/
--Oracle 조인
select e.empno "사원번호", e.ename "사원이름", e.sal "급여", d.dname "등급"
from emp e, dept d
where e.deptno = d.deptno and e.sal >= 2000
order by e.sal desc;

--ANSI 조인
select e.empno "사원번호", e.ename "사원이름", e.sal "급여", d.dname "등급"
from emp e
join dept d
on e.deptno = d.deptno and sal >= 2000
order by e.sal desc;

/*
3. 부서 테이블과 사원 테이블에서 사번, 사원명, 업무, 급여, 부서명을 검색하시오.
    단, 엄무가 Manager이며 급여가 2500 이상인 사원에 대하여 사번을 기준으로 오름차순정렬할 것.
*/
--Oracle 조인
select e.empno "사원번호", e.ename "사원이름", e.job "업무", e.sal "급여", d.dname "부서명"
from emp e, dept d
where e.deptno = d.deptno and e.job = 'MANAGER' and e.sal >= 2500
order by e.empno asc;

--ANSI 조인
select e.empno "사원번호", e.ename "사원이름", e.job "업무", e.sal "급여", d.dname "부서명"
from emp e
join dept d
on e.deptno = d.deptno and e.job = 'MANAGER' and e.sal >= 2500
order by e.empno asc;

/*
4. 사원 테이블과 급여 등급 테이블에서 사번, 사원명, 급여, 등급을 검색하시오.
    단, 등급은 급여가 하한값과 상한값 범위에 포함되고 등급이 4이며 급여를 기준으로 내림차순정렬할 것.
*/
--Oracle 조인
select e.empno "사원번호", e.ename "사원이름", e.sal "급여", g.grade "등급"
from emp e, salgrade g
where e.sal >= g.losal and e.sal <= g.hisal and g.grade = 4
order by 3 desc;

--ANSI 조인
select e.empno "사원번호", e.ename "사원이름", e.sal "급여", g.grade "등급"
from emp e
join salgrade g
on e.sal >= g.losal and e.sal <= g.hisal and g.grade = 4
order by 3 desc;

/*
5. 부서 테이블, 사원 테이블, 급여등급 테이블에서 사번, 사원명, 부서명, 급여, 등급을 검색하시오.
    단, 등급은 급여가 하한값과 상한값 범위에 포함되며 등급을 기준으로 내림차순 정렬할 것.
*/
--Oracle
select e.empno "사원번호", e.ename "사원이름", d.dname "부서명", e.sal "급여", g.grade "등급"
from emp e, dept d, salgrade g
where (e.deptno = d.deptno) and (e.sal >= g.losal and e.sal <= g.hisal)
order by g.grade;

--ANSI 조인
select e.empno "사원번호", e.ename "사원이름", d.dname "부서명", e.sal "급여", g.grade "등급"
from emp e
join dept d on e.deptno = d.deptno
join salgrade g on e.sal >= g.losal and e.sal <= g.hisal
order by g.grade;

/*
6. 사원 테이블에서 사원명과 해당 사원의 관리자명을 검색하시오.
*/
--Oracle 조인
select e.ename "사원이름", m.ename "사원의매니져이름"
from emp e, emp m
where e.mgr = m.empno(+);

--ANSI 조인
select e.ename "사원이름", m.ename "사원의매니져이름"
from emp e
left outer join emp m
on e.mgr = m.empno;

/*
7. 사원 테이블에서 사원명, 해당 사원의 관리자명, 해당 사원의 관리자의 관리자명을 검색하시오.
*/
--Oracle 조인
select e.ename "사원이름", m1.ename "사원의 매니져이름", m2.ename "매니져의 매니져이름"
from emp e, emp m1, emp m2
where (e.mgr = m1.empno) and (m1.mgr = m2.empno);

--ANSI 조인
select e.ename "사원이름", m1.ename "사원의 매니져이름", m2.ename "매니져의 매니져이름"
from emp e
join emp m1 on e.mgr = m1.empno
join emp m2 on m1.mgr = m2.empno;

/*
8. 7번 결과에서 상위 관리자가 없는 모든 사원의 이름도 사원명에 출력되도록 수정하시오.
*/
--Oracle 조인
select e.ename "사원이름", m1.ename "사원의 매니져이름", m2.ename "매니져의 매니져이름"
from emp e, emp m1, emp m2
where (e.mgr = m1.empno(+)) and (m1.mgr = m2.empno(+));


--ANSI 조인
select e.ename "사원이름", m1.ename "사원의 매니져이름", m2.ename "매니져의 매니져이름"
from emp e
left outer join emp m1 on e.mgr = m1.empno
left outer join emp m2 on m1.mgr = m2.empno;