
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



-- ==========================================
-- FOREIGN KEY (외래 키)
-- ==========================================
-- 다른 테이블에서 제공하는 값만 사용할 수 있음
-- 데이터의 무결성을 유지하기 위해 사용됨
-- FOREIGN KEY 제약 조건으로 테이블 간 관계(RELATIONSHIP) 형성
-- 제공된 값 외에는 NULL을 사용할 수 있음

-- 기존에 user_grade 테이블이 존재하면 삭제
DROP TABLE IF EXISTS user_grade;

-- user_grade 테이블 생성 (등급 정보 저장)
CREATE TABLE IF NOT EXISTS user_grade(
    grade_code INT PRIMARY KEY,     -- 등급 코드 (기본 키)
    grade_name VARCHAR(255) NOT NULL -- 등급 이름 (NULL 허용 안 함)
) ENGINE = INNODB; -- InnoDB 엔진 사용 (외래 키 지원)

-- user_grade 테이블에 데이터 삽입 (회원 등급 정보 추가)
INSERT INTO user_grade
VALUES (10, '일반회원'),  -- 일반회원
       (20, '우수회원'),  -- 우수회원
       (30, '특별회원');  -- 특별회원

-- user_grade 테이블의 데이터 확인
SELECT * FROM user_grade;


DROP TABLE IF EXISTS user_foreignkey;
CREATE TABLE IF NOT EXISTS user_foreignkey (
    user_no INT PRIMARY KEY ,
    user_id VARCHAR(255) NOT NULL ,
    user_pwd VARCHAR(255) NOT NULL ,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
#     grade_code INT NOT NULL,
    grade_code INT,
    FOREIGN KEY (grade_code)
    REFERENCES user_grade(grade_code)
        ) ENGINE=INNODB;

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
    (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey;

# -----------------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS user_foreignkey;
CREATE TABLE IF NOT EXISTS user_foreignkey (
   user_no INT PRIMARY KEY ,
   user_id VARCHAR(255) NOT NULL ,
   user_pwd VARCHAR(255) NOT NULL ,
   user_name VARCHAR(255) NOT NULL,
   gender VARCHAR(3),
   phone VARCHAR(255) NOT NULL,
   email VARCHAR(255),
#     grade_code INT NOT NULL,
   grade_code INT NOT NULL,
   FOREIGN KEY (grade_code)
       REFERENCES user_grade(grade_code)
) ENGINE=INNODB;

INSERT INTO user_grade VALUES (40, '일반회원');

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
    (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com', 50);

DELETE FROM user_grade WHERE grade_code = 10;
DELETE FROM user_grade WHERE grade_code = 20;
DELETE FROM user_grade WHERE grade_code = 30;
# 기본적으로 FOREIGN KEY 로 참조된 데이터는 삭제할 수 없음.
# 삭제하려면 먼저 참조하는 데이터를 삭제해야 함 (DELETE FROM user_foreignkey WHERE grade_code = 10;).
# ON DELETE CASCADE 옵션을 설정하면 자동으로 참조 데이터를 삭제할 수 있음.
# ON DELETE CASCADE 가 없으면 수동으로 삭제해야 함.

SELECT * FROM user_foreignkey;

DROP TABLE user_foreignkey;
CREATE TABLE IF NOT EXISTS user_foreignkey(
    user_no INT PRIMARY KEY ,
    user_id VARCHAR(255) NOT NULL ,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT,
    FOREIGN KEY (grade_code)
        REFERENCES user_grade(grade_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=INNODB;

INSERT INTO user_grade VALUES (20, '우수회원');

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 30),
    (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com', 40);

SELECT * FROM user_grade;
SELECT * FROM user_foreignkey;

ROP TABLE IF EXISTS user_foreignkey;
CREATE TABLE IF NOT EXISTS user_foreignkey(
      user_no INT PRIMARY KEY ,
      user_id VARCHAR(255) NOT NULL ,
      user_pwd VARCHAR(255) NOT NULL,
      user_name VARCHAR(255) NOT NULL,
      gender VARCHAR(3),
      phone VARCHAR(255) NOT NULL,
      email VARCHAR(255),
#     grade_code INT NOT NULL,
      grade_code INT ,
      FOREIGN KEY (grade_code)
          REFERENCES user_grade(grade_code)
          ON UPDATE SET NULL
#     ON DELETE SET NULL
) ENGINE=INNODB;

# 1. 부모 테이블의 grade_code 수정
UPDATE user_grade
SET grade_code = 100
WHERE grade_code = 20;

-- 2. 부모 테이블의 행 삭제
DELETE FROM user_grade
WHERE grade_code = 20;

DELETE FROM user_grade
 WHERE grade_code = 300;

SELECT * FROM user_foreignkey;


-- CHECK 제약 조건 위반시 허용하지 않는다.
DROP TABLE IF EXISTS user_check;
CREATE TABLE IF NOT EXISTS user_check (
   user_no INT AUTO_INCREMENT PRIMARY KEY,
   user_name VARCHAR(255) NOT NULL,
   gender VARCHAR(5) CHECK(gender IN ('남', '여')),
   age INT CHECK(age >= 19)
) ENGINE=INNODB;
SHOW CREATE TABLE user_check;
SELECT * FROM information_schema.TABLE_CONSTRAINTS;

INSERT INTO user_check VALUES (null, '홍길동', '남', 25);
INSERT INTO user_check VALUES (null, '유관순', '여', 20);

# INSERT INTO user_check VALUES (null, '안중근', '남성', 40);
# [HY000][3819] Check constraint 'user_check_chk_1' is violated.
# INSERT INTO user_check VALUES (null, '유승제', '남', 18);
# [HY000][3819] Check constraint 'user_check_chk_2' is violated.

SELECT * FROM user_check;










