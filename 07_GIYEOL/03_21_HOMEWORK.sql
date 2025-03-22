-- 1
select
    empdb_name
from
    tbl_empdb
where
    empdb like '%연' ;
-- 2.
select
    empdb_name,
    empdb_phonenumber
from
    tbl_empdb
where
    empdb_phonenumber
not like '010%' ;
-- 3
select
    employee_mailadd
,   DEPT_CODE
from
    tbl_employee
where
    employee_mailadd
    like '____'
  and
    (DEPT_CODE = D9) or (DEPT_CODE= D5)
  between
    (employee_data = 90/01/01) or (empolyee_date = 01/12/31)
  and
    (employee_money >= 270);
-- 4
select
    employee_name
from
    tbl_empolyee
where
    (employee_name = works)
group by  employee_name ASC;
-- 5
select
    employee_name
    employee_phonenumber,
    employee_date,
    employee_works
from
    tbl_emplyee
where
    employee_phonenumber
like
    '%2'
between
    (employee_end = 'Y')
   or
    (employee_works ='N');
-- 7
select
    employee_name,
    employee_grde
from
    tbl_employee
where
    employee_grde not null;
-- 02.1
select
    employee_num,
    employee_name,
    employee_id,
    employee_money
from
    tbl_employee
where
    row_count(employee_id,*,'15');
-- 2
select
    emp_name,
    emp_id
from
    tbl_empdb
where

-- 3
CREATE TABLE tbl_files (
                           file_no BIGINT,
                           file_path VARCHAR(500)
);
-- drop table tbl_files
INSERT INTO tbl_files VALUES(1, 'c:\\abc\\deft\\salesinfo.xls');
INSERT INTO tbl_files VALUES(2, 'c:\\music.mp3');
INSERT INTO tbl_files VALUES(3, 'c:\\documents\\resume.hwp');
COMMIT;
SELECT * FROM tbl_files;

-- 03.1
select
    emp_money ,
    sum(*) as '급여 총합'
from
    tbl_empdb
where
    emp_sex ='woman' ;
-- 2
select
    empdb_money,
    empdb_specail
from tbl_empdb
where
    empdb_money
group by
    sum(empdb_code = 5);
-- 3
select
    empdb_code
from
    tbl_empdb
where
    empdb_money
group by
    empdb_code = 5;
-- 4

