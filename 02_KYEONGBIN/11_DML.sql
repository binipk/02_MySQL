-- ================================
-- 📌 DML (Data Manipulation Language)
-- ================================
-- DML은 데이터를 조작(삽입, 수정, 삭제, 조회)하는 SQL 명령어입니다.
-- 데이터베이스에서 가장 많이 사용되며, 사용자와 DB 간의 인터페이스 역할을 합니다.
-- 주요 명령어: INSERT, UPDATE, DELETE, SELECT(DQL)

-- ================================
-- 📌 INSERT (데이터 삽입)
-- ================================
-- 새로운 데이터를 테이블에 추가하는 구문입니다.
-- 실행 시, 테이블의 행(Row) 개수가 증가합니다.

-- 📌 기본 문법
-- 1️⃣ 모든 컬럼에 값을 삽입 (컬럼 순서대로 모든 값 입력)
--    INSERT INTO <테이블명> VALUES (값1, 값2, ...);

-- 2️⃣ 특정 컬럼에만 값을 삽입 (NULL 허용 컬럼은 생략 가능)
--    INSERT INTO <테이블명> (컬럼명1, 컬럼명2, ...) VALUES (값1, 값2, ...);

--    ✅ NULL 허용 컬럼은 생략 가능 (생략 시 NULL이 대입됨)
--    ✅ NOT NULL 컬럼은 반드시 값이 있어야 함 (단, DEFAULT 값이 있으면 생략 가능)

# 문법 1. 테이블의 선언된 컬럼 순서 그대로 모두 값을 전달해야 한다

INSERT INTO tbl_menu (menu_code, menu_name, menu_price, category_code, orderable_status)
VALUES (NULL, '바나나맛해장국', 8500, 3, 'Y');


# 문법 2. NULL 허용 가능한 (NULLABLE) 컬럼이나 AUTO_INCREAMENT 가 있는 컬럼을 제외하고
# INSERT 하고 싶은 데이터 컬럼을 지정해서 INSERT 가능하다.

INSERT INTO tbl_menu (menu_name, menu_price, category_code, orderable_status)
VALUES ('초콜릿맛죽', 6500,  7, 'Y' );

# 컬럼을 명시하면 INSERT 시 데이터의 순서를 바꾸는 것도 가능

INSERT INTO tbl_menu (orderable_status, menu_price, menu_name, category_code)
VALUES ('Y', 25000, '매생이케잌', 10);

-- ==========================================================================================
--                                                  UPDATE
-- ==========================================================================================

SELECT
    menu_code
,   menu_name
,   category_code
FROM
    tbl_menu

UPDATE
    tbl_menu -- 수정할 대상 테이블
SET
    category_code = 10
,   menu_name = '매생이쉐이크' -- 여러개의 값을 동시에 수정할 경우 콤마(,)를 사용함.
WHERE
    menu_code = 25;

# SUBQUERY 를 활용할 수도 있다.
# 다만 MySQL 은 Oracle 과 달리 delete 시 자기 자신 테이블의 데이터를 사용할 시 1093에러가 발생한다.

UPDATE
    tbl_menu
SET
    category_code = (SELECT menu_code
                     FROM tbl_menu
                     WHERE menu_name = '우럭스무디')
WHERE
    menu_code = 25;
# 이 때 SUBQUERY를 하나 더 사용하여 임시테이블로 사용하게 하면 해결할 수 있다.

UPDATE
    tbl_menu
SET
    category_code = (SELECT tmp.menu_code
                     FROM (SELECT menu_code
                           FROM tbl_menu
                           WHERE menu_name = '우럭스무디') tmp
                     )
WHERE
    menu_code = 25;

SELECT * FROM tbl_menu ORDER BY menu_code;


-- ==========================================================================================
--                                                  DELETE
-- ==========================================================================================

# 테이블의 행을 삭제하는 구문임.
# 테이블의 행의 갯수가 줄어듦

DELETE
FROM tbl_menu
WHERE menu_code = 25;
SELECT * FROM tbl_menu WHERE menu_code = 25;

SELECT * FROM tbl_menu ORDER BY menu_price;

# LIMIT 를 활용한 행삭제(Offset 지정은 안됨)
DELETE
    FROM tbl_menu
    ORDER BY menu_price
    LIMIT 2;

# 테이블 전체 행 삭제
DELETE FROM tbl_menu;
-- 어딘가에 임시로 있다가 Rollback 가능

TRUNCATE table tb_escape_watch;
-- 다 지우고 새로 넣을떄 사용?


# ==============================
# REPLACE
# ==============================
# INSERT 시 PRIMARY KEY 또는 UNIQUE KEY 가 충돌이 발생할 수 있다면
# REPLACE 를 통해 중복된 데이터를 덮어쓸 수 있다.

INSERT INTO tbl_menu VALUES
    (17, '참기름맛소주', 7000, 10, 'Y');


REPLACE INTO tbl_menu VALUES
    (17, '참기름맛소주', 7000, 10, 'Y');

# INTO 는 생략 가능
REPLACE tbl_menu VALUES
    (17, '아이스가리비관자육수', 6000, 10, 'Y');





