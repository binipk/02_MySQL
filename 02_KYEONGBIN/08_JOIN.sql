```text
-- =============================
-- JOIN
-- =============================
-- 두개 이상의 테이블의 레코드를 연결해서 가상테이블(relation) 생성
-- 연관성을 가지고 있는 컬럼을 기준(데이터)으로 조합

# relation을 생성하는 2가지 방법
-- 1. join :  특정컬럼 기준으로 행과 행을 연결한다. (가로)
-- 2. union : 컬럼과 컬럼을 연결한다.(세로)
-- join은 두 테이블의 행사이의 공통된 데이터를 기준으로 **선을 연결해서** 새로운 하나의 행을 만든다.

# JOIN 구분
-- 1. Equi JOIN : 일반적으로 사용하는 Equality Condition(=)에 의한 조인
-- 2. Non-Equi JOIN : 동등조건(=)이 아닌 BETWEEN AND, IS NULL, IS NOT NULL, IN, NOT IN, !=  등으로 사용.

# EQUI JOIN 구분
-- 1. INNER JOIN(내부 조인) : 교집합 (일반적으로 사용하는 JOIN)
-- 2. OUTER JOIN(외부 조인) : 합집합
-- LEFT (OUTER) JOIN (왼쪽 외부 조인)
-- RIGHT (OUTER) JOIN (오른쪽 외부 조인)
-- FULL (OUTER) JOIN (완전 외부 조인)
-- 3. CROSS JOIN
-- 4. SELF JOIN(자가 조인)
-- 5. MULTIPLE JOIN(다중 조인)
```
# 테이블에는 고유한 값을 갖고 있는 식별자가 있음  (노란색 열쇠로 표시됨) - Primary Key
# 이걸 가지고 JOIN 할 수 있음

/*
데이터베이스에서 **Primary Key(기본 키)** 는 각 행(레코드)을 **고유하게 식별하는 값**이에요.

예를 들어, 학생 정보를 저장하는 테이블이 있다고 가정해볼게요.

| 학번 (Primary Key) | 이름  | 전공   |
|----------------|------|------|
| 2023001       | 철수  | 컴퓨터공학 |
| 2023002       | 영희  | 경영학 |
| 2023003       | 민수  | 경제학 |

여기서 **"학번"** 열이 Primary Key예요.
→ **각 학생마다 고유한 학번이 있어서, 같은 학번이 중복될 수 없어요.**

### Primary Key를 이용한 JOIN 예제
이제 성적 정보를 저장하는 또 다른 테이블이 있다고 해볼게요.

| 학번 (Primary Key) | 과목  | 점수 |
|----------------|------|----|
| 2023001       | 수학  | 90 |
| 2023002       | 영어  | 85 |
| 2023003       | 과학  | 88 |

여기서도 **"학번"** 이 Primary Key인데, 이 값을 이용해서 **JOIN** 하면,
학생 정보와 성적 정보를 합쳐서 볼 수 있어요.

```sql
SELECT 학생.이름, 성적.과목, 성적.점수
FROM 학생
JOIN 성적 ON 학생.학번 = 성적.학번;
```
🔹 **결과**

| 이름  | 과목  | 점수 |
|------|------|----|
| 철수  | 수학  | 90 |
| 영희  | 영어  | 85 |
| 민수  | 과학  | 88 |

즉, **Primary Key를 사용하면 서로 다른 테이블을 연결(JOIN)해서 데이터를 쉽게 조회할 수 있어요!**
 */

SELECT *
FROM
    tbl_menu a
# INNER JOIN tbl_category b ON a.category_code = b.category_code;
JOIN tbl_category b ON a.category_code = b.category_code;

-- USING
-- 동일한 이름의 컬럼을 기준컬름으로 사용
SELECT
        a.menu_name
    ,   b.category_name
FROM tbl_menu a -- 베이스 테이블
JOIN tbl_category b USING(category_code);



# ===============================
# OUTER JOIN
# ===============================
# 좌/우측 테이블 기준으로 조인. 기준이 된 테이블은 누락되는 행이 없다.
# INNER JOIN에서 해당 테이블의 누락된 행이 모두 추가된다.

# ==================== LEFT  JOIN ====================
SELECT
        a.menu_name
     ,  b.category_name
FROM
    tbl_menu a -- 베이스 테이블
LEFT JOIN
        tbl_category b USING(category_code);


# ==================== RIGHT  JOIN ====================
SELECT
         a.menu_name
     ,   b.category_name
FROM
    tbl_menu a
RIGHT JOIN -- 다 가져오는거라 행의 갯수가 늘어남
        tbl_category b USING(category_code);


# ====================
# CROSS JOIN
# ===================
# 카테이션곱(Cartesian Product)
# 모든 경우의 수를 구하므로, 결과는 두 테이블의 컬럼 수를 곱한 개수가 나온다.
# 한쪽 테이블의 모든 행과 다른쪽 테이블의 모든 행을 조인시킨다.
# CROSS JOIN은 조건절이 없다, 또는 JOIN문의 ON절이 없을 경우
SELECT
    a.menu_name
 ,  b.category_name
FROM
    tbl_menu a
CROSS JOIN tbl_category b;

# CROSS JOIN은 두 테이블의 모든 조합(곱집합, Cartesian Product) 을 생성하는 JOIN 방식이에요.
# 즉, 한 테이블의 모든 행과 다른 테이블의 모든 행을 전부 조합해서 새로운 결과를 만들어냅니다.


# ============================
# SELF JOIN
# ============================
# 조인은 두 개 이상의 서로 다른 테이블을 연결하기도 하지만, 같은 테이블을 조인하는 경우가 있다.
# 이러한 경우 자기 자신과 조인을 맺는 것이라하여 SELF JOIN이라고 한다.

SELECT
    b.category_name 상위카테고리
,   a.category_name 카테고리
FROM
    tbl_category a
JOIN
    tbl_category b
ON
    a.ref_category_code = b.category_code;


SELECT
    *
FROM
    employee a
LEFT JOIN
    department b ON a.DEPT_CODE = b.DEPT_ID;


SELECT
    a.EMP_NAME
,   b.DEPT_TITLE
,   c.JOB_NAME
,   d.LOCAL_CODE
,   e.NATIONAL NAME
FROM
    employee a
LEFT JOiN
    department b ON a.DEPT_CODE = b.DEPT_ID
LEFT JOIN
    job c ON a.JOB_CODE = c.JOB_CODE
LEFT JOiN
    location d ON b.LOCATION_ID = d.LOCAL_CODE
LEFT JOIN
    nation e ON d.NATIONAL_CODE = n.NATIONAL_CODE;


SELECT
    a.EMP_NAME,
    b.DEPT_TITLE,
    c.JOB_NAME,
    d.LOCAL_NAME
FROM employee a
         JOIN department b ON  a.DEPT_CODE = b.DEPT_ID
         JOIN empdb.job c on a.JOB_CODE = c.JOB_CODE
         JOIN location d ON b.LOCATION_ID = d.LOCAL_CODE
         JOIN nation n on d.NATIONAL_CODE = n.NATIONAL_CODE;


-- 1. 재직 중이고 휴대폰 마지막 자리가 2인 직원 중 입사일이 가장 최근인 직원 3명의 사원번호,
-- 사원명, 전화번호, 입사일, 퇴직여부를 출력하세요.
-- 참고. 퇴사한 직원은 퇴직여부 컬럼값이 ‘Y’이고, 재직 중인 직원의 퇴직여부 컬럼값은 ‘N’ (JOIN은 아님)

/*
    -------------------- 출력 예시 ----------------------------
    사원번호    사원명     전화번호        입사일     퇴직여부
    -----------------------------------------------------------
    216         차태연     01064643212     2013-03-01 00:00:00,N
    211         전형돈     01044432222     2012-12-12 00:00:00,N
    206         박나라     01096935222     2008-04-02 00:00:00,N
*/
SELECT
    EMP_ID
,   EMP_NAME
,   PHONE
,   HIRE_DATE
,   QUIT_YN
FROM
    employee
WHERE
    PHONE LIKE ('%2')
AND
    QUIT_YN = 'N'
ORDER BY
    HIRE_DATE DESC
LIMIT
3;


-- 2. 재직 중인 ‘대리’들의 직원명, 직급명, 급여, 사원번호, 이메일, 전화번호, 입사일을 출력하세요.
-- 단, 급여를 기준으로 내림차순 출력하세요.

/*
    ---------------------------------- 출력 예시 ------------------------------------------------
    사원명     직급명     급여       사원번호        이메일                    입사일
    ----------------------------------------------------------------------------------------------
    전지연     대리      3660000     770808-2665412  jun_jy@ohgiraffers.com    2007-03-20 00:00:00
    차태연     대리      2780000     000704-3364897  cha_ty@ohgiraffers.com    2013-03-01 00:00:00
    장쯔위     대리      2550000     780923-2234542  jang_zw@ohgiraffers.com   2015-06-17 00:00:00
    하동운     대리      2320000     621111-1785463  ha_dh@ohgiraffers.com     1999-12-31 00:00:00
    전형돈     대리      2000000     830807-1121321  jun_hd@ohgiraffers.com    2012-12-12 00:00:00

*/

SELECT
    EMP_NAME 사원명
,   JOB_NAME 직급명
,   SALARY 급여
,   EMP_NO 주민번호
,   EMAIL 이메일
,   HIRE_DATE 입사일
FROM
    employee b
JOIN
    job a ON b.JOB_CODE = a.JOB_CODE
WHERE
    b.QUIT_YN = 'N'
AND
    b.JOB_CODE = 'J6'
ORDER BY
    b.SALARY DESC;



-- 3. 재직 중인 직원들을 대상으로 부서별 인원, 급여 합계, 급여 평균을 출력하고,
--    마지막에는 전체 인원과 전체 직원의 급여 합계 및 평균이 출력되도록 하세요.
--    단, 출력되는 데이터의 헤더는 컬럼명이 아닌 ‘부서명’, ‘인원’, ‘급여합계’, ‘급여평균’으로 출력되도록 하세요. (ROLLUP사용)

/*
    -------------------------- 출력 예시 -----------------------------
    부서명         인원      급여합계            급여평균
    ---------------------------------------------------------------
    기술지원부       2       4550000             2275000
    인사관리부       3       7820000             2606666.6666666665
    총무부           3       17700000            5900000
    해외영업1부      6       15760000            2626666.6666666665
    해외영업2부      3       10100000            3366666.6666666665
    회계관리부       4       11000000            2750000
    <null>          21       66930000            3187142.8571428573

*/

