-- ===========================
-- 제약조건 조회
-- ===========================
SELECT *
FROM information_schema.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'menudb'  -- 데이터베이스 이름
  AND table_name = 'tbl_menu';      -- 테이블 이름


-- ===========================
-- NOT NULL 제약조건
-- ===========================
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


-- ===========================
-- UNIQUE 제약조건
-- ===========================
DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique (
                                           user_no INT NOT NULL,
                                           user_id VARCHAR(255) NOT NULL,
                                           user_pwd VARCHAR(255) NOT NULL,
                                           user_name VARCHAR(255) NOT NULL,
                                           gender VARCHAR(3),
                                           phone VARCHAR(255) NOT NULL UNIQUE,
                                           email VARCHAR(255),
                                           UNIQUE (phone)
) ENGINE=INNODB;

INSERT INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_unique;

-- 중복된 전화번호로 추가 시도
INSERT INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (3, 'user01', 'pass01', '홍길동', '남', '010-1234-5670', 'hong123@gmail.com'),
    (4, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_unique;


-- ===========================
-- PRIMARY KEY 제약조건
-- ===========================
-- 단일 컬럼 PRIMARY KEY 예시
CREATE TABLE example_table (
                               id INT PRIMARY KEY,
                               name VARCHAR(100)
);

-- 복합 키 예시
CREATE TABLE example_table_complex (
                                       part_id INT,
                                       order_id INT,
                                       PRIMARY KEY (part_id, order_id)
);

DROP TABLE IF EXISTS user_primarykey;
CREATE TABLE IF NOT EXISTS user_primarykey (
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


-- ===========================
-- FOREIGN KEY 제약조건
-- ===========================
DROP TABLE IF EXISTS user_grade;
CREATE TABLE IF NOT EXISTS user_grade(
                                         grade_code INT PRIMARY KEY,
                                         grade_name VARCHAR(255) NOT NULL
) ENGINE = INNODB;

INSERT INTO user_grade
VALUES (10, '일반회원'), (20, '우수회원'), (30, '특별회원');

-- 외래 키가 설정된 테이블
DROP TABLE IF EXISTS user_foreignkey;
CREATE TABLE IF NOT EXISTS user_foreignkey (
                                               user_no INT PRIMARY KEY,
                                               user_id VARCHAR(255) NOT NULL,
                                               user_pwd VARCHAR(255) NOT NULL,
                                               user_name VARCHAR(255) NOT NULL,
                                               gender VARCHAR(3),
                                               phone VARCHAR(255) NOT NULL,
                                               email VARCHAR(255),
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

-- 삭제할 때, 외래 키 제약 조건 위반 예시 (삭제할 수 없음)
-- DELETE FROM user_grade WHERE grade_code = 10;


-- ===========================
-- ON DELETE / ON UPDATE 옵션
-- ===========================
DROP TABLE IF EXISTS user_foreignkey;
CREATE TABLE IF NOT EXISTS user_foreignkey(
                                              user_no INT PRIMARY KEY,
                                              user_id VARCHAR(255) NOT NULL,
                                              user_pwd VARCHAR(255) NOT NULL,
                                              user_name VARCHAR(255) NOT NULL,
                                              gender VARCHAR(3),
                                              phone VARCHAR(255) NOT NULL,
                                              email VARCHAR(255),
                                              grade_code INT,
                                              FOREIGN KEY (grade_code)
                                                  REFERENCES user_grade(grade_code)
                                                  ON DELETE CASCADE
                                                  ON UPDATE CASCADE
) ENGINE=INNODB;

INSERT INTO user_grade VALUES (40, '일반회원');
INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 30),
    (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com', 40);

SELECT * FROM user_grade;
SELECT * FROM user_foreignkey;

-- ===========================
-- CHECK 제약조건
-- ===========================
DROP TABLE IF EXISTS user_check;
CREATE TABLE IF NOT EXISTS user_check (
                                          user_no INT AUTO_INCREMENT PRIMARY KEY,
                                          user_name VARCHAR(255) NOT NULL,
                                          gender VARCHAR(5) CHECK(gender IN ('남', '여')),
                                          age INT CHECK(age >= 19)
) ENGINE=INNODB;

INSERT INTO user_check VALUES (null, '홍길동', '남', 25);
INSERT INTO user_check VALUES (null, '유관순', '여', 20);

-- 조건 위반 예시 (오류 발생)
-- INSERT INTO user_check VALUES (null, '안중근', '남성', 40); -- 오류 발생
-- INSERT INTO user_check VALUES (null, '유승제', '남', 18);   -- 오류 발생

SELECT * FROM user_check;

# 설명:
# 제약조건 조회: information_schema.TABLE_CONSTRAINTS에서 테이블의 제약조건을 조회합니다.
#
# NOT NULL: NOT NULL 제약조건을 설정하여 컬럼 값이 반드시 있어야 한다는 조건을 추가합니다.
#
# UNIQUE: 특정 컬럼(예: phone)에 대해 중복된 값을 허용하지 않도록 설정합니다.
#
# PRIMARY KEY: 각 행을 고유하게 식별할 수 있는 컬럼을 설정합니다.
#
# FOREIGN KEY: 다른 테이블의 값을 참조하여 관계를 설정합니다. 참조된 값이 삭제되면 ON DELETE CASCADE로 자동 삭제가 가능합니다.
#
#                                                            ON DELETE / ON UPDATE: 외래 키 제약조건에서 ON DELETE CASCADE 및 ON UPDATE CASCADE 설정으로 부모 데이터가 삭제/수정될 때 자식 데이터도 영향을 받게 합니다.
#
#     CHECK: 특정 조건을 만족하는 값만 삽입될 수 있도록 제한합니다. 예: gender는 '남' 또는 '여'만 허용하고, age는 19 이상이어야 합니다.
#
#     이 SQL 코드를 실행하면 데이터베이스에 테이블을 생성하고 제약조건을 적용한 후 테스트할 수 있습니다.
