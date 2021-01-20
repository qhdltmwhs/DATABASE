--단일행함수

--문자함수
SELECT UPPER('kim'), LOWER('KIM'), INITCAP('i am a boy') FROM DUAL;
SELECT EMPNO, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME) FROM EMP;
SELECT EMPNO, CONCAT(ENAME, ' 님의 직급은  ') FROM EMP;
SELECT EMPNO, CONCAT(CONCAT(ENAME, ' 님의 직급은  '), JOB) FROM EMP;
SELECT EMPNO, CONCAT(CONCAT(CONCAT(ENAME, ' 님의 직급은  '), JOB), ' 입니다') FROM EMP;

--SUBSTR
SELECT 'ABCDEFGHIJK', SUBSTR('ABCDEFGHIJK', 6) FROM DUAL;
SELECT 'ABCDEFGHIJK', SUBSTR('ABCDEFGHIJK', 6, 3) FROM DUAL;
SELECT EMPNO, ENAME, JOB, SUBSTR(JOB, 6, 3) FROM EMP;
SELECT EMPNO, ENAME, JOB, SUBSTR(JOB, 6) FROM EMP;
SELECT EMP.EMPNO, EMP.ENAME FROM EMP;       --COLUMN 의 풀네임(FULL NAME)
SELECT EMPNO, EMP.ENAME, LENGTH(ENAME) FROM EMP;
SELECT EMP.*, LENGTH(ENAME) FROM EMP;
SELECT EMP.*, LENGTH(ENAME) FROM EMP WHERE LENGTH(ENAME) >= 5;

--INSTR (STRING의 INDEX를 의미)
SELECT INSTR('ABADAFG', 'A'),
            INSTR('ABADAFG', 'A', 1, 1),
            INSTR('ABADAFG', 'A', 1, 2),
            INSTR('ABADAFG', 'A', 1, 3),
            INSTR('ABADAFG', 'A', 2, 1),
            INSTR('ABADAFG', 'A', 2, 2),
            INSTR('ABADAFG', 'A', 2, 3)
FROM DUAL;

SELECT TEL, INSTR(TEL, ')', 1, 1), INSTR(TEL, '-', 1, 1) FROM STUDENT;

--LPAD, RPAD (채우다)
 --이때 LPAD(SAL, 8, '0')의 함수안의 SAL 원래 숫자이나 문자로 변경된다.
SELECT EMPNO, ENAME, SAL, RPAD(ENAME, 8, '*'), LPAD(SAL, 8, '0') FROM EMP;     
SELECT EMPNO, ENAME, SAL, LPAD(RPAD(ENAME, 8, '*'), 10, '#'), LPAD(SAL, 8, '-') FROM EMP; 

--TRIM
SELECT EMPNO, JOB,
            TRIM(LEADING 'S' FROM JOB),
            TRIM(TRAILING 'N' FROM JOB),
            TRIM(BOTH 'M' FROM JOB)
FROM EMP;

--REPLACE
SELECT EMPNO, ENAME, JOB, REPLACE(JOB, 'MAN', 'PERSON') FROM EMP;
SELECT STUDNO, NAME, JUMIN, REPLACE(JUMIN, SUBSTR(JUMIN, 7), '-*******') FROM STUDENT;

--숫자함수
SELECT ROUND(45.6789),
           ROUND(45.6789, 0),
           ROUND(45.6789, 1),
           ROUND(45.6789, 2),
           ROUND(45.6789, 3),
           ROUND(45.6789, -1)
FROM DUAL;            

SELECT TRUNC(45.6789),
           TRUNC(45.6789, 0),
           TRUNC(45.6789, 1),
           TRUNC(45.6789, 2),
           TRUNC(45.6789, 3),
           TRUNC(45.6789, -1)
FROM DUAL; 

SELECT CEIL(15.3), FLOOR(15.3) FROM DUAL;

--조편성 (EX ...)
SELECT CEIL(1/3), CEIL(2/3), CEIL(3/3),
           CEIL(4/3), CEIL(5/3), CEIL(6/3) 
FROM DUAL;

--날짜함수
SELECT SYSDATE FROM DUAL;
SELECT SYSTIMESTAMP FROM DUAL;

SELECT SYSDATE+7 "7일후" FROM DUAL;
SELECT SYSDATE-7 "7일전" FROM DUAL;
SELECT SYSDATE - TO_DATE('2000/06/12', 'YYYY/MM/DD') "일수" FROM DUAL;
SELECT EMPNO, ENAME, HIREDATE, SYSDATE, ROUND((SYSDATE - HIREDATE)/7) 근무주수 FROM EMP;

SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
           TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) "근무달수",
           ADD_MONTHS(HIREDATE, 6) "입사6개월후",
           ADD_MONTHS(SYSDATE, 6) "6개월후",
           NEXT_DAY(HIREDATE, '금') "입사후 첫번째 금요일",
           NEXT_DAY(SYSDATE, '금') "금요일",
           LAST_DAY(HIREDATE) "입사월의 마지막날",
           LAST_DAY(SYSDATE) "이번달의 마지막날"
FROM EMP;           

--EXTRACT FUNCTION(date--->년, 월, 일, 시, 분, 초 를 숫자로 추출)
SELECT EMPNO, ENAME, HIREDATE,
           EXTRACT(YEAR FROM HIREDATE),
           EXTRACT(MONTH FROM HIREDATE),
           EXTRACT(DAY FROM HIREDATE)
FROM EMP;

--날짜의 반올림, 내림
SELECT EMPNO, ENAME, HIREDATE,
           ROUND(HIREDATE, 'MONTH'),
           ROUND(HIREDATE, 'YEAR'),
           TRUNC(HIREDATE, 'MONTH'),
           TRUNC(HIREDATE, 'YEAR')
FROM EMP;

--변환함수
--묵시적
SELECT * FROM EMP WHERE HIREDATE = '1981/11/17';
SELECT * FROM EMP WHERE HIREDATE = TO_DATE('1981/11/17');
SELECT * FROM EMP WHERE HIREDATE = TO_DATE('1981/11/17', 'YYYY/MM/DD');

SELECT * FROM EMP WHERE EMPNO = '7839';
SELECT * FROM EMP WHERE EMPNO = TO_NUMBER('7839');

--TO_CHAR() 날짜-->문자
SELECT SYSDATE, 
           TO_CHAR(SYSDATE, 'YYYY MM DD'),
           TO_CHAR(SYSDATE, 'YYYY/MM/DD'),
           TO_CHAR(SYSDATE, 'YYYY-MM-DD'),
           TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS'),
           TO_CHAR(SYSDATE, 'YEAR-MONTH-DAY'),
           TO_CHAR(SYSDATE, 'YYYY'),
           TO_CHAR(SYSDATE, 'MM'),
           TO_CHAR(SYSDATE, 'DD'),
           TO_CHAR(SYSDATE, 'DY'),
           TO_CHAR(SYSDATE, 'HH')
FROM DUAL;

DESC TEMP;      --테이블 정보

SELECT EMP_ID, EMP_NAME, BIRTH_DATE
FROM TEMP
WHERE TO_CHAR(BIRTH_DATE, 'MM') = '12';

SELECT EMP_ID, EMP_NAME, BIRTH_DATE
FROM TEMP
WHERE TO_CHAR(BIRTH_DATE, 'DY') = '화';

--TO_CHAR() 숫자-->문자
SELECT TO_CHAR(12345678.8888, '99,999,999.9999'),
           TO_CHAR(12345678.8888, '99,999,999.999'),
           TO_CHAR(12345678.8888, '99,999,999.999999999'),
           TO_CHAR(12345678.8888, '9,999,999.9999'),
           TO_CHAR(12345678.8888, '999,999,999.9999'),
           TO_CHAR(12345678.8888, '099,999,999.9999')
FROM DUAL;

SELECT EMP.*, TO_CHAR(SAL, '99,999.9') FROM EMP;
SELECT EMP.*, TO_CHAR(SAL, 'L99,999.9') FROM EMP;
SELECT EMP.*, TO_CHAR(SAL, '$99,999.9') FROM EMP;

--TO_NUMBER()  문자-->숫자
SELECT * FROM EMP WHERE SAL > TO_NUMBER('1000');
SELECT  '1234'+'1'+1, '23.4567'+0.12 FROM DUAL;
SELECT  TO_NUMBER('1234')+TO_NUMBER('1')+1, TO_NUMBER('23.4567')+0.12 FROM DUAL;

--TO_DATE() 문자-->날짜
SELECT EMPNO, ENAME, TO_CHAR(HIREDATE, 'YYYY-MM-DD HH24:MI:SS')
FROM EMP
WHERE HIREDATE >= TO_DATE('1982-01-01 09:35:45', 'YYYY-MM-DD HH24:MI:SS')
AND HIREDATE <= TO_DATE('1987-12-31', 'YYYY-MM-DD');

SELECT 
        TO_DATE('2020', 'YYYY'),
        TO_DATE('04', 'MM'),
        TO_DATE('12', 'DD')
FROM DUAL;

--일반함수
--NVL, NVL2 (NULL VALUE)
SELECT EMPNO, COMM, NVL(COMM,0) FROM EMP;
SELECT EMPNO, COMM, NVL2(COMM,COMM,0) FROM EMP;

SELECT EMPNO, ENAME, SAL, COMM, SAL*12 +NVL(COMM,0) "연봉" FROM EMP;
SELECT EMPNO, ENAME, COMM, NVL2(COMM,SAL*12+COMM,SAL*12+0) FROM EMP;
SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL2(COMM,COMM,0) FROM EMP;

--DECODE
--예)직급별로 인센티브를 부여해서 급여를 지급
SELECT EMPNO, ENAME, SAL, JOB, SAL*DECODE(JOB, 'CLERK', 1.2,
                                                                        'ANALYST', 1.3,
                                                                        'MANAGER', 1.4,
                                                                        'PRESIDENT', 1.5,
                                                                        'SALESMAN', 1.6)  "직급별급여" 
FROM EMP;

SELECT EMPNO, ENAME, SAL, JOB, 
        NVL(SAL*DECODE(JOB, 'SALESMAN', 1.6), SAL)  "직급별급여"                                                                 
FROM EMP;

--CASE구문
SELECT EMPNO, ENAME, SAL, JOB,
           (     
                CASE JOB WHEN 'CLERK' THEN SAL*1.2
                               WHEN 'ANALYST' THEN SAL*1.3
                               WHEN 'MANAGER' THEN SAL*1.4
                               WHEN 'PRESIDENT' THEN SAL*1.5
                               WHEN 'SALESMAN' THEN SAL*1.6
                ELSE    SAL
                END 
             )  "직급별계산급여"
FROM EMP;

SELECT EMPNO, ENAME, SAL, JOB,
           (     
                CASE       
                           WHEN JOB = 'CLERK' THEN SAL*1.2
                           WHEN JOB = 'ANALYST' THEN SAL*1.3
                           WHEN JOB = 'MANAGER' THEN SAL*1.4
                           WHEN JOB = 'PRESIDENT' THEN SAL*1.5
                           WHEN JOB = 'SALESMAN' THEN SAL*1.6
                ELSE    SAL
                END 
             )  "직급별계산급여"
FROM EMP;

SELECT EMPNO, ENAME, SAL, 
            (
                CASE 
                    WHEN SAL >= 3000 AND SAL <= 5000 THEN 'A'
                    WHEN SAL >= 2000 AND SAL < 3000 THEN 'B'
                ELSE 'F'
                END     
            ) "급여등급"  
FROM EMP;
