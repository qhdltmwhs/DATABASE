--그룹함수 
--전체사원이 그룹
SELECT 
            SUM(SAL) "전체사원 급여합", 
            MAX(SAL) "전체사원 최대급여", 
            MIN(SAL) "전체사원 최소급여", 
            ROUND(AVG(SAL)) "전체사원 급여평균",
            ROUND(VARIANCE(SAL)) 분산,
            ROUND(STDDEV(SAL)) 표준편차,
            AVG(COMM) "전체사원 평균커미션",      --이때...!  NULL을 제외(무시)하고계산함 값이 이상해짐
            COUNT(EMPNO) "전체사원 수",      --NULL을 제외하지만 PRIMARY_KEY(NULL이 존재할수없음) 사용으로 인한 정상 카운트
            COUNT(*) "전체사원 수",      --* NULL을 포함하여 카운트한다.
            COUNT(COMM) "커미션받는 사원"
FROM EMP;

--부서별로 그룹핑
SELECT DEPTNO, 
           COUNT(*) "부서별인원수",
           ROUND(AVG(SAL)) "부서별급여평균",
           MAX(SAL) "부서별최대급여",
           MIN(SAL) "부서별최소급여",
           SUM(SAL) "부서별급여합"
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO ASC;

--부서별,직급별 그룹핑
SELECT DEPTNO, JOB, COUNT(*) "부서직급별 인원"
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

--HAVING절(GROUPING 이후 FILTERING)
SELECT DEPTNO, AVG(SAL) "부서별급여평균"
FROM EMP
--WHERE AVG(SAL >= 1500) 사용불가능
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000
ORDER BY "부서별급여평균" DESC;

--직급별
SELECT JOB, COUNT(*) "직급별인원수"
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 2
ORDER BY 2;

--직급별로 최대, 최소 급여를 출력
SELECT LEV, MAX(SALARY), MIN(SALARY) 
FROM TEMP
GROUP BY LEV;

--직급별로 최소 급여를 받는 사원의 사번, 이름 출력(subquery)
SELECT MIN(LPAD(SALARY, 9, 0)||EMP_ID||EMP_NAME)
FROM TEMP;

SELECT LEV, 
           SUBSTR(MIN(LPAD(SALARY, 9, 0)||EMP_ID||EMP_NAME), 10, 8) "사번",
           SUBSTR(MIN(LPAD(SALARY, 9, 0)||EMP_ID||EMP_NAME), 10, 8) "이름",
           TO_NUMBER(SUBSTR(MIN(LPAD(SALARY, 9, 0)||EMP_ID||EMP_NAME), 1, 9)) "급여"
FROM TEMP
GROUP BY LEV;

--가로출력
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO;

SELECT DEPTNO, SUM(DECODE(JOB, 'CLERK', SAL, 0)) "CLERK",
                        SUM(DECODE(JOB, 'MANAGER', SAL, 0)) "MANAGER",
                        SUM(DECODE(JOB, 'PRESIDENT', SAL, 0)) "PRESIDENT",
                        SUM(DECODE(JOB, 'ANALYST', SAL, 0)) "ANALYST",
                        SUM(DECODE(JOB, 'SALESMAN', SAL, 0)) "SALESMAN"
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

SELECT TO_CHAR(HIREDATE, 'YYYY'), SUM(SAL) FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')
ORDER BY 1;
