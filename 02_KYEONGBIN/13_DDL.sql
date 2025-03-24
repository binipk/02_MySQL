-- ========================================
-- 📌 DDL (Data Definition Language) - 데이터 정의 언어
-- ========================================
-- 💡 DDL은 **데이터베이스 객체(Object)를 생성, 수정, 삭제하는 SQL 명령어**입니다.
-- 💡 주로 테이블, 뷰, 인덱스, 스키마 등을 다룰 때 사용합니다.
-- 💡 DDL은 **자동으로 커밋(Auto-Commit)되므로**, ROLLBACK이 불가능합니다.
-- 💡 DML(INSERT, UPDATE, DELETE)과 혼용할 때 주의해야 합니다.

-- ✅ 주요 DDL 명령어
--  - `CREATE` : 새로운 데이터베이스 객체(테이블, 뷰 등) 생성
--  - `ALTER`  : 기존 객체의 구조 변경 (컬럼 추가, 수정 등)
--  - `DROP`   : 데이터베이스 객체 삭제 (테이블, 뷰 등 완전 삭제)
--  - `TRUNCATE` : 테이블의 모든 데이터 삭제 (ROLLBACK 불가)

SHOW VARIABLES LIKE 'autocommit';
SET autocommit = OFF;


-- ========================================
-- 📌 CREATE - 테이블 생성
-- ========================================
-- 💡 `CREATE TABLE`은 새로운 테이블을 생성하는 SQL 명령어입니다.
-- 💡 `IF NOT EXISTS`를 사용하면 **이미 존재하는 테이블이 있을 경우 에러 없이 넘어갑니다.**

-- ✅ 테이블 생성 기본 문법
-- column_name data_type(length) [NOT NULL] [DEFAULT value] [AUTO_INCREMENT] column_constraint;

-- ✅ 데이터베이스 선택 (사용할 DB 지정)
USE basicdb;

-- 📌 참고: InnoDB 스토리지 엔진 개요
-- https://dev.mysql.com/doc/refman/8.3/en/innodb-introduction.html

CREATE TABLE product1(
    id INT COMMENT '상품아이디',
    name VARCHAR(100) COMMENT '상품명',
    create_at DATETIME COMMENT '등록일'
) ENGINE = INNODB COMMENT '상품테이블'; -- MySQL Default DB가 INNODB 이나 그래도 써주는 것이 좋음

-- 테이블별 스토리지 엔진 확인
SHOW TABLE STATUS LIKE 'product1';

-- 테이블 구조 확인
DESCRIBE product1;
DESC product1;



-- ========================================
-- 📌 COMMENT - 주석 설정
-- ========================================
-- 💡 **테이블 주석 설정**
-- 1. 테이블 생성 시 주석 추가:
-- CREATE TABLE 테이블명 (
--     ...
-- ) COMMENT = 'table comment';

-- 2. 기존 테이블에 주석 수정:
-- ALTER TABLE 테이블명 COMMENT = 'table comment';

-- 💡 **컬럼 주석 설정**
-- 1. 컬럼 생성 시 주석 추가:
-- CREATE TABLE 테이블명 (
--     컬럼명 INT COMMENT 'column1 comment',
--     ...
-- );

-- 2. 기존 컬럼에 주석 수정:
-- ALTER TABLE 테이블명
--     MODIFY 컬럼명 데이터타입 제약조건 COMMENT 'column1 comment';

-- ========================================
-- 📌 DEFAULT - 기본값 설정
-- ========================================
-- 💡 컬럼에 기본값(DEFAULT)을 설정하면, 값이 입력되지 않았을 때 자동으로 기본값이 적용됩니다.
-- 💡 예시:
-- - `DEFAULT 0` : 값이 입력되지 않으면 0이 기본값으로 저장됩니다.

-- 💡 **DATE 타입**의 컬럼은 `CURRENT_DATE`만 기본값으로 설정 가능합니다.
-- 💡 **DATETIME 타입**의 컬럼은 `CURRENT_TIME`, `CURRENT_TIMESTAMP`, `NOW()` 등을 기본값으로 사용할 수 있습니다.


CREATE TABLE IF NOT EXISTS tbl_rent(
    rent_id INT AUTO_INCREMENT PRIMARY KEY,
    contractor_name VARCHAR(255) DEFAULT '익명',
    car_name VARCHAR(255) DEFAULT '람보르기니',
    rent_date DATE DEFAULT (current_date),
    rent_time TIME DEFAULT (current_time),
    created_at DATETIME DEFAULT (current_timestamp)
) ENGINE = INNODB; -- EXIST 이미 존재함
INSERT INTO tbl_rent VALUES (null, default, default,
                             default, default, default);
SELECT * FROM tbl_rent; -- 웹페이지나 프로그램에서 시간 날짜를 기본값으로 자동 입력하도록 만들기 위한 장치 -- 또 어떤 용도로 사용되는지 확인 필요

INSERT INTO tbl_rent(contractor_name) VALUES ('유승제'); -- 이름만 넣었을 뿐인데 차 이름, 시간 등이 모두 자동 입력됨

CREATE TABLE IF NOT EXISTS product1(
        id INT COMMENT '상품아이디',
        name VARCHAR(100) COMMENT '상품명',
        create_at DATETIME COMMENT '등록일'
) ENGINE = INNODB COMMENT '상품테이블';

-- ========================================
-- 📌 AUTO_INCREMENT - 자동 증가
-- ========================================
-- 💡 **AUTO_INCREMENT**는 **PK(Primary Key) 컬럼에 자동으로 고유 번호**를 부여합니다.
-- 💡 새로운 행이 추가될 때, **번호가 중복되지 않게 자동으로 증가**하여 저장됩니다.
-- 💡 **PK 컬럼이 아닌 컬럼**에는 **AUTO_INCREMENT**를 사용할 수 없습니다.
-- 💡 **AUTO_INCREMENT** 값은 **이미 등록된 값에 대해서만 사용** 가능합니다.

CREATE TABLE IF NOT EXISTS product2 (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '상품아이디',
    name VARCHAR(255) COMMENT '상품명',
    created_at DATETIME DEFAULT NOW() COMMENT '등록일'
) ENGINE INNODB COMMENT '상품테이블';

SELECT * FROM product2;


-- ========================================
-- 📌 ALTER - 테이블 구조 변경
-- ========================================
-- 💡 테이블의 구조를 변경하거나 수정하는 작업을 **ALTER** 명령어로 수행합니다.

-- ✅ **변경 항목**
-- - `ADD`    : **컬럼 추가**, **제약조건 추가**
-- - `MODIFY` : **컬럼 자료형 변경**, **컬럼 DEFAULT 값 변경**
-- - `RENAME` : **컬럼명 변경**, **제약조건 이름 변경**
-- - `DROP`   : **컬럼 삭제**, **제약조건 삭제**

DESC product2;

-- ADD 컬럼명 자료형 제약조건 ALTER 기존컬럼
ALTER TABLE product2 ADD price INT NOT NULL AFTER name;

-- DROP 컬럼명 삭제
ALTER TABLE product2 DROP COLUMN price;

-- 컬럼명 변경
-- CHANGE 이전컬럼명 새컬럼명 자료형 제약조건
ALTER TABLE product2 CHANGE COLUMN name prod_name CHAR(100) NOT NULL ;
DESC product2;

-- 컬럼 순서 변경
-- MODIFY 컬럼명 자료형 ALTER 기존컬럼 (자료형은 필수)
ALTER TABLE product2
MODIFY COLUMN prod_name CHAR(100) AFTER created_at;
DESC product2;

-- 컬럼 Default값 변경
-- ALTER TABLE 테이블명 ALTER COLUMN 컬럼명 SET DEFUALT 디폴드값;
ALTER TABLE product2 ALTER COLUMN prod_name SET DEFAULT  '무명';
DESC product2;

-- 컬럼 자료형 변경
-- ALTER TABLE 테이블명 MODIFY 컬럼명 새자료형
ALTER TABLE product2 MODIFY prod_name VARCHAR(100);
DESC product2;

 -- 열 제약조건 추가 및 삭제
ALTER TABLE product1 DROP PRIMARY KEY;
ALTER TABLE product1 ADD PRIMARY KEY (id);

-- ========================================
-- 📌 DROP -- 테이블을 삭제하기 위한 구문
-- ========================================
-- 테이블 삭제
DROP TABLE product2;
DROP TABLE IF EXISTS product1;

-- 한번에 2개의 테이블 삭제
DROP TABLE IF EXISTS encore_bank, kb_bank;
















