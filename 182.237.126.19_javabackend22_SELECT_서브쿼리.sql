--SCALAR SUB QUERY
--단일행반환(단일행연산자)

select job from emp where empno=7788;
select * from emp where job='ANALYST';

select * 
from emp 
where job = (select job
              from emp 
              where empno=7788);
              
select *
from emp
where sal >= (
               select sal
               from emp
               where empno=7521
            )
and job=(
            select job 
            from emp
            where empno=7900
        );
--EMP에서최소급여를 받는사원
select * 
from emp
where sal = (select min(sal)
                from emp
                );

--EMP에서부서별 최소급여를 받는사원
--ORA-01427: single-row subquery returns more than one row
select *
from emp
where sal = (select min(sal)
                    from emp
                    group by deptno
            );
--복수행반환(복수행연산자 IN,ANY,ALL)
--EMP에서부서별 최소급여를 받는사원
select *
from emp
where sal in(950,8900,800,1300);
 
select *
from emp
where sal in((select min(sal)
                    from emp
                    group by deptno)); 
 
 --ALL
 select sal from emp where job = 'MANAGER';
 /*
 2975
 2850
 2450
 */
 select empno, ename, sal from emp where sal < 2450;
 
 select empno, ename, sal from emp where sal < all( 2975, 2850, 2450);
 
 select empno, ename, sal from emp 
 where sal < all(select sal 
                      from emp where job = 'MANAGER');
 
 --ANY
 select sal from emp whrer job = 'MANGER';
 /*
 2975
 2850
 2450
 */
 select empno, ename, sal from emp where sal > 2450;
 
 select empno, ename, sal form emp
 where sal > any(2975, 2850, 2450);
 
 select empno, ename, sal from emp 
 where sal > any(select sal 
                        from emp
                        where job = 'MANAGER');
                        
--INLINE VIEW SUBQUERY

--VIEW(논리적 테이블)
select e10.empno, e10.ename from (select *
                                                    from emp
                                                    where deptno = 10
                                                    ) e10 ;

--ORA-01031: insufficient privileges(권한없음) [
create view emp10_view
as
select empno, ename, job, sal
from emp
where deptno = 10;

--VIEW
select * from emp10_view;

--INLINE VIEW(SUBQUERY)
select * from (select empno, ename, job, sal
                    from emp
                    where deptno = 10);
                    
--JOIN VS SCALAR SUBQUERY   ==> JOIN 효율적이다
select empno, ename, dname, loc from emp natural join dept;

--위와 같은 결과를 도출하지만 권장하지 않는다...
select empno, ename, (select dname
                                from dept
                                where emp.deptno = dept.deptno),
                               (select loc
                                from dept
                                where emp.deptno = dept.deptno) from emp;

--JOIN VS INLINE VIEW SUBQUERY  ==> INLINE VIEW 효율적이다
select round(avg(sal)) "10번부서 평균임금"
from (select empno, ename, job, sal
         from emp
         where deptno = 10);

--emp 부서별로 최소연봉을 가진직원의 사번, 이름, 연봉을 읽어오세요

select deptno, min(sal)
from emp
group by deptno;
/*
30	950
20	800
10	1300
*/
select * from emp;
/*
7369	SMITH	CLERK	7902	1980/12/17	800		20
7499	ALLEN	SALESMAN	7698	1981/02/20	1600	300	30
7521	WARD	SALESMAN	7698	1981/02/22	1250	500	30
7566	JONES	MANAGER	7839	1981/04/02	2975		20
*/

select * from (select deptno, min(sal) "min_sal"
                    from emp
                    group by deptno) e1
join emp e2
on  e1."min_sal" = e2.sal;

--동일한 직급을 가진 사원의 평균연봉 보다 연봉이 높은 사원출력

--1. 동일한 직급을 가진 사원의 평균연봉 테이블
select job, round(avg(sal))
from emp
group by job;
/*
CLERK	1038
SALESMAN	1400
PRESIDENT	5000
MANAGER	2758
ANALYST	3000
*/

--2. 사원테이블
select * from emp;

--3. INLINE VIEW 활용 조인결과
select e2.empno, e2.ename, e2.job, e2.sal, e1.job, e1."job_avg_sal"
from (select job, round(avg(sal)) "job_avg_sal"
        from emp
        group by job) e1
join emp e2
on e1.job = e2.job and e1."job_avg_sal" < e2.sal;

--동일한  직급을 가진 사원의 평균연봉 보다 연봉이 높은 사원의 연봉을 5% 차감해서 출력
select e2.empno, e2.ename, e2.job, e2.sal, e2.sal * 0.95 "5%차감된연봉"
from (select job, round(avg(sal)) "job_avg_sal"
        from emp
        group by job) e1
right outer join emp e2
on e1.job = e2.job and e1."job_avg_sal" < e2.sal;


/*
ROWNUM (pseudo(유사) column)
    - 오라클에서만 사용가능한 컬럼
    - SELECT 시에 조건에맞는 행에 순차적부여
    - where 조건문에서 1번을 포함하는 범위조건내에서는 사용가능
    - where 조건문에서 1번을 포함하지않는 범위조건내에서는 사용불가능
*/
-- rownum 컬럼을 추가 순차적
select rownum, empno, ename, sal from emp;

-- rownum 컬럼을 추가 하였으나 정렬로 인한 rownum 순차적이지않음
select rownum, empno, ename, sal
from emp
order by sal desc;

--정렬을 먼저한 테이블 작성
select empno, ename, sal 
from emp 
order by sal desc;

-- from절에 인라인 뷰어를 사용 정렬된 테이블을사용후, 정렬된 테이블의  rownum 컬럼의 순차적 추가
select rownum, e.empno, e.ename, e.sal 
from (select empno, ename, sal 
        from emp 
        order by sal desc) e;

--where 조건문에서 1번을 포함하는 범위조건내에서는 사용가능        
select rownum, e.empno, e.ename, e.sal 
from (select empno, ename, sal 
        from emp 
        order by sal desc) e
where rownum >= 1 and rownum <= 5;  

--where 조건문에서 1번을 포함하지않는 범위조건내에서는 사용불가능
select rownum, e.empno, e.ename, e.sal 
from (select empno, ename, sal 
        from emp 
        order by sal desc) e
where rownum >= 3 and rownum <= 5;  

--해결방법(인라인뷰를 한번더...)
select e1."sal_rank", e1.empno, e1.ename, e1.sal
    from(select rownum "sal_rank", e.empno, e.ename, e.sal 
                from (select empno, ename, sal 
                        from emp 
                        order by sal desc) e) e1
where e1."sal_rank">= 3 and e1."sal_rank" <= 5;