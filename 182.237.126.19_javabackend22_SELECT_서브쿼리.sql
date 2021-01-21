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
 