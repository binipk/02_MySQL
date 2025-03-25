use empdb;
-- 1. employee 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오

SELECT
    EMP_NAME
FROM
    employee
WHERE
    EMP_NAME LIKE '%연';

-- 2. employee 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 출력하시오

SELECT
    EMP_NAME, PHONE
FROM
    employee
WHERE
    PHONE NOT LIKE '010%';

-- 3. employee 테이블에서 메일주소 '_'의 앞이 4자이면서, DEPT_CODE가 D9 또는 D5이고 고용일이 90/01/01 ~ 01/12/31이면서, 월급이 270만원 이상인 사원의 전체 정보를 출력하시오

# SELECT
#     *
# FROM
#     employee
# WHERE -- PASS

-- 4. employee테이블에서 현재 근무중인 사원을 이름 오름차순으로 정렬해서 출력.

SELECT
    EMP_NAME, QUIT_YN
FROM
    employee
WHERE
    QUIT_YN = 'N' -- 안나간 사람 필터링
ORDER BY
    EMP_NAME; -- 오름차순 기본값

-- 5. 사원별 입사일, 퇴사일, 근무기간(일)을 조회하세요. 퇴사자 역시 조회되어야 합니다.

/* 출력 (24 row)
    선동일 1990-02-06 00:00:00  12488 N
    송종기 2001-09-01 00:00:00  8263  N
    노옹철 2001-01-01 00:00:00  8506  N
    송은희 1996-05-03 00:00:00  10210 N
    ...
*/

SELECT
    EMP_NAME 이름
,   DATE_FORMAT(HIRE_DATE, '%Y-%m-%d (%W)') 입사일
,   CASE
        WHEN QUIT_DATE IS NULL THEN '미정'
        ELSE QUIT_DATE
        END '퇴사일'
,   DATEDIFF(COALESCE(QUIT_DATE, Current_DATE), HIRE_DATE) 근속일수
,   CASE
        WHEN QUIT_YN LIKE 'N' THEN '재직중'
        ELSE '퇴사'
        END 재직여부
FROM
    employee;

SELECT * FROM employee;

-- 6. 재직 중이고 휴대폰 마지막 자리가 2인 직원 중 입사일이 가장 최근인 직원 3명의 사원번호,
-- 직원명, 전화번호, 입사일, 퇴직여부를 출력하세요.
-- 참고. 퇴사한 직원은 퇴직여부 컬럼값이 ‘Y’이고, 재직 중인 직원의 퇴직여부 컬럼값은 'N'

SELECT
    EMP_ID, EMP_NAME, PHONE, HIRE_DATE, QUIT_YN
FROM
    employee
WHERE
    QUIT_YN = 'N'
AND
    PHONE LIKE '%2'
ORDER BY
    HIRE_DATE DESC
LIMIT
    3;


-- 7. <1단계> 전체 직원 중 연결된 관리자가 있는 직원의 인원을 출력하세요.
-- 참고. 연결된 관리자가 있다는 것은 관리자사번이 NULL이 아님을 의미함

SELECT
    COUNT(*)
FROM
    employee
WHERE
    MANAGER_ID IS NOT NULL

