--sequence
drop sequence test_seq1;
create sequence test_seq1;

drop sequence test_seq2;
create sequence test_seq2
        start with 1
        maxvalue 99999999
        increment by 1
        nocycle
        nocache;

select test_seq1.nextval from dual;

select test_seq1.currval from dual;
/*
ORA-08002: sequence TEST_SEQ2.CURRVAL is not yet defined in this session
08002. 00000 -  "sequence %s.CURRVAL is not yet defined in this session"
*Cause:    sequence CURRVAL has been selected before sequence NEXTVAL
*Action:   select NEXTVAL from the sequence before selecting CURRVAL
*/
select test_seq2.currval from dual;

select test_seq2.nextval from dual;

drop table freeboard;
create table freeboard(
    board_no number(6) primary key,
    board_title varchar2(255),
    board_content varchar2(1000),
    board_wday date default sysdate,
    board_read_count number(6) default 0
);
drop sequence freeboard_no_seq;
create sequence freeboard_no_seq
            increment by 1
            start with 1
            maxvalue 999999999999
            nocycle
            nocache;
            
insert into freeboard(board_no, board_title, board_content)
                    values(freeboard_no_seq.nextval, '제목'||freeboard_no_seq.nextval, '내용'||freeboard_no_seq.nextval);

select * from freeboard;

drop table jumun;
create table jumun(
    j_no varchar2(20) primary key,
    j_title varchar2(100),
    j_price number(10),
    j_date date default sysdate
);
drop sequence jumun_no_seq;
create sequence jumun_no_seq nocycle nocache;

insert into jumun(j_no, j_title, j_price)
                values(to_char(sysdate, 'YYYY-MM-DD')||jumun_no_seq.nextval, '아이패드외5종... ', 45000);
                
select * from jumun;
