-- 1
select
    employee_name
from
    tbl_employee
where
    employee_name like '%연' ;
-- 2.
select
    employee_name,
    employee_phonenumber
from
    tbl_employee
where
    employee_phonenumber
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
    DEPT_CODE = D9 or DEPT_CODE= D5
  between
    employee_data = 90/01/01 or empolyee_date = 01/12/31
  and
    employee_money >= 270;
-- 4
select
    employee_name
from
    tbl_empolyee
where
    employee_name = works
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
like '%2'
between
    employee_end ='Y'
   or
    employee_works ='N';
-- 7
select
    employee_name,
    employee_grde
from
    tbl_employee
where
    employee_grde not null;