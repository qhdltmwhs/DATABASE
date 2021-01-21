--2021-01-21
/*
1. 사원테이블에서 부서별 인원수가 6명 이상인 부서코드 검색?
*/
select deptno, count(deptno)
from emp
group by deptno
having count(deptno) >= 6;

/*
2. 사원테이블로부터 부서번호, 업무별 급여합계를 계산하고자한다.
    다음과 같은 결과를 출력할 수 있는 SQL문장 작성?
*/    
select deptno,
            sum(decode(job, 'CLERK', sal, 0)) "CLERK",
            sum(decode(job, 'MANAGER', sal, 0)) "MANAGER",
            sum(decode(job, 'PRESIDENT', sal, 0)) "PRESIDENT",
            sum(decode(job, 'ANALYST', sal, 0)) "ANALYST",
            sum(decode(job, 'SALESMAN', sal, 0)) "SALESMAN"
from emp
group by deptno
order by deptno asc;

/*
3. 사원테이블로부터 년도별, 월별 급여합계를 출력할 수 있는 SQL문장 작성?
*/
select to_char(hiredate, 'YYYY') 년, to_char(hiredate, 'MM') 월, SUM(SAL)
from emp
group by to_char(hiredate, 'YYYY'), to_char(hiredate, 'MM')
order by 1;

/*
4. 사원테이블에서 부서별 COMM(커미션)을 포함하지 않은 연봉의 합과 
    포함한 연봉의 합을 구하는 SQL을 작성하시오.
*/
select deptno, sum(sal*12) "연봉"
from emp
group by deptno
order by deptno asc;

select deptno, sum((sal+nvl(comm, 0))*12) "연봉"
from emp
group by deptno
order by deptno asc;

/*
5. 사원테이블에서 SALESMAN을 제외한 JOB별 급여합계?
*/
select job, sum(sal)
from emp
group by job
having job != 'SALESMAN';