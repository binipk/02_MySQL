
-- =====================
-- CONSTRAINTS
-- =====================
-- 제약조건
-- 테이블 작성 시 각 컬럼에 값 기록에 대한 제약조건을 설정할 수 있다.
-- 데이터 무결성 보장 목적
-- 입력/수정하는 데이터에 문제가 없는지 자동으로 검사해 주기 위한 목적
-- PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY 제약조건을 설정할 수 있다.

-- 제약조건 조회
-- 'menudb' 데이터베이스의 'tbl_menu' 테이블에 설정된 제약조건들을 조회
SELECT *
FROM information_schema.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'menudb'  -- 제약조건이 설정된 데이터베이스 이름
  AND table_name = 'tbl_menu';  -- 제약조건이 설정된 테이블 이름


## NOT NULL
-- NULL값을 허용하지 않는 제약조건
-- 제약조건 확인용 테이블 생성 및 테스트 데이터 INSERT 후 조회하기
DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull (
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255)
) ENGINE=INNODB;

INSERT INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_notnull;


# UNIQUE
-- 중복값 허용하지 않는 제약조건
-- 제약조건 확인용 테이블 생성 및 테스트 데이터 INSERT 후 조회하기
DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique (
    user_no INT NOT NULL, -- 컬럼 레벨로 적용함 -- 몬소린지는 좀 알아봐야 할듯
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255),
    UNIQUE (phone) -- 테이블 레벨로 적용했다 라는데 몬소리인지 좀 알아봐야 할듯...
) ENGINE=INNODB;

INSERT INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_unique;


INSERT INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (3, 'user01', 'pass01', '홍길동', '남', '010-1234-5670', 'hong123@gmail.com'),
    (4, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_unique;


-- ===============================
-- PRIMARY KEY
-- ===============================
-- PRIMARY KEY는 테이블에서 정확히 한 행을 식별하기 위해 사용할 컬럼을 의미한다.
-- 이 컬럼은 각 행을 고유하게 식별하는 역할을 하며, 테이블의 식별자 역할을 한다.
-- 한 테이블당 한 개의 PRIMARY KEY만 설정할 수 있다.
-- PRIMARY KEY는 NOT NULL + UNIQUE 제약조건을 포함하고 있다. 즉, 이 컬럼의 값은 반드시 NULL이 될 수 없고, 중복될 수 없다.
-- PRIMARY KEY는 컬럼 레벨과 테이블 레벨 모두에서 설정할 수 있다.
-- 한 개 컬럼에 PRIMARY KEY를 설정할 수 있으며, 여러 개의 컬럼을 묶어서 PRIMARY KEY를 설정할 수도 있다. (복합키)
-- 예를 들어, 여러 컬럼을 묶어서 하나의 식별자로 사용하는 경우가 복합키(Composite Key)이다.

-- 예시: 한 컬럼을 PRIMARY KEY로 설정하는 방법
CREATE TABLE example_table (
id INT PRIMARY KEY,  -- id 컬럼을 PRIMARY KEY로 설정
name VARCHAR(100)
);

-- 예시: 여러 컬럼을 묶어서 PRIMARY KEY로 설정하는 방법 (복합키)
CREATE TABLE example_table_complex (
part_id INT,
order_id INT,
PRIMARY KEY (part_id, order_id)  -- 복합키 설정: part_id와 order_id 두 컬럼을 묶어서 PRIMARY KEY 설정
);

DROP TABLE IF EXISTS user_primarykey;
CREATE TABLE IF NOT EXISTS user_primarykey (
--     user_no INT PRIMARY KEY,
    user_no INT,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    PRIMARY KEY (user_no)
) ENGINE=INNODB;

INSERT INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_primarykey;


































