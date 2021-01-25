/*
<< Transaction >>
트랜잭션의 정의 
    - 트랜잭션(Transaction)은 데이터베이스의 상태를 변환시키는(DML) 하나의 논리적 기능을 수행하기 위한 작업의 단위
*/

/*
Transaction 시작(DML--> insert delete update)
*/
select * from dept;
--transaction시작

insert into dept values(80, '생산1팀', '대전');
insert into dept values(90, '생산2팀', '인천');

select * from dept;
--transaction종료
--모든 데이터 변경사항을 데이터베이스에 영구히 반영시키는 명령어.
commit;
--transaction시작
insert into dept values(60,'기획팀', 'LA');
insert into dept values(70,'영업팀', '서울');

select * from dept;
--transaction종료
--모든 데이터 변경사항을 취소하는 명령어 변경전의 데이터가 복원된다.
rollback;
select * from dept;

/*
localhost scott에 접속
*/

/*
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
/*