use empdb;
SELECT * FROM employee;
-- 1. employee 테이블에서 남자만 사원번호, 사원명, 주민번호, 연봉을 나타내세요.
-- 단, 주민번호의 뒷6자리는 *처리하세요.
    SELECT EMP_ID 사원번호
         , EMP_NAME 성명
         , CONCAT(SUBSTR(EMP_NO, 1, 8),'******') AS 주민번호
# RAPD(문자열, 조작해서만들길이, 오른쪽에붙일문자)
#          , RPAD(SUBSTR(EMP_NO, 1, 8),14,'*') AS 주민번호
         , SALARY 연봉
      FROM employee
    WHERE EMP_NO LIKE '%-1%' OR EMP_NO LIKE '%-3%';

    /*
        --------------- 출력 예시 ------------------------
        사원번호    성명      주민번호           연봉
        --------------------------------------------------
        200        선동일     621225-1******   124,800,000
        201        송종기     631126-1******   72,000,000
        202        노옹철     861015-1******   44,400,000
        204        유재식     660508-1******   48,960,000
        205        정중하     770102-1******   46,800,000
        208        김해술     870927-1******   30,000,000
        209        심봉선     750206-1******   48,300,000
        ...
        총 row수는 15
    */



-- 2. EMPLOYEE 테이블에서 사원명, 아이디(이메일 @ 앞부분)을 조회하세요.
        SELECT EMP_NAME emp_name
             , SUBSTRING_INDEX(EMAIL, '@',1) email_id
          FROM employee;

    /*
        --------- 출력 예시 -----------
        emp_name        email_id
        -------------------------------
        선동일          sun_di
        송종기          song_jk
        노옹철          no_hc
        송은희          song_eh
        유재식          yoo_js
        정중하          jung_jh
        박나라          pack_nr
        하이유          ha_iy
        김해술          kim_hs
        ...
        총 row수는 24
    */

-- 3. 파일경로를 제외하고 파일명만 아래와 같이 출력하세요.
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

# 마지막 원소는 -1
# 마지막에서 두번째는 -2 . . .
SELECT file_no 파일번호
     , SUBSTRING_INDEX(file_path, '\\', -1) 파일명
  FROM tbl_files;
/*
출력결과 :
--------------------------
파일번호          파일명
---------------------------
1             salesinfo.xls
2             music.mp3
3             resume.hwp
---------------------------
*/

