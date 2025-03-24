set autocommit = 0;

SHOW VARIABLES LIKE 'autocommit'; # 커밋 상태값 확인 쿼리

-- ===================================
-- TCL
-- ===================================
-- Transaction Control Language 트랜잭션 제어 언어
-- COMMI, ROLLBACK, SAVEPOINT 등이 있다.

-- ========================================
-- 📌 트랜잭션(Transaction) 이란?
-- ========================================
-- 💡 트랜잭션이란, **한꺼번에 수행되어야 할 최소 작업 단위**를 의미합니다.
-- 💡 논리적 작업 단위(LUW, Logical Unit of Work)라고도 합니다.
-- 💡 하나의 트랜잭션 내의 작업은 **모두 완료되거나, 모두 취소**되어야 합니다.
-- 💡 만약 일부 작업만 완료되고 나머지가 실패하면, 전체 작업을 취소(ROLLBACK)해야 합니다.

-- ========================================
-- 📌 트랜잭션의 ACID 원칙
-- ========================================
-- ✅ 1. 원자성(Atomicity)
--     - 트랜잭션 내 모든 작업이 **전부 실행되거나, 전부 실행되지 않아야 함**
--     - 일부만 실행되는 경우를 방지

-- ✅ 2. 일관성(Consistency)
--     - 트랜잭션이 성공하면, **데이터베이스의 무결성이 유지되어야 함**
--     - 예를 들어, 계좌 이체 시 A 계좌에서 돈이 빠져나갔다면, B 계좌에 정확히 추가되어야 함

-- ✅ 3. 독립성(Isolation)
--     - 트랜잭션이 수행되는 동안 **다른 작업이 끼어들지 않아야 함**
--     - 동시 실행되는 트랜잭션 간의 충돌 방지 (ex. `READ_COMMITTED` 수준 적용)

-- ✅ 4. 지속성(Durability)
--     - **트랜잭션이 성공적으로 완료되면, 그 결과는 영구적으로 반영**되어야 함
--     - 시스템 장애가 발생해도 데이터는 보존되어야 함
--     - 트랜잭션이 완료되면 **로그를 남겨 복구 가능해야 함**

-- ========================================
-- 📌 TCL (Transaction Control Language)
-- ========================================
-- ✅ COMMIT
--     - 트랜잭션이 **정상적으로 완료**되었을 때, 변경 내용을 **영구적으로 저장**
--     - 모든 `SAVEPOINT`(저장 지점) 삭제

-- ✅ ROLLBACK
--     - 트랜잭션을 **취소**하고, 가장 최근 `COMMIT` 시점으로 돌아감

-- ✅ SAVEPOINT <savepoint명>
--     - 트랜잭션 내에서 특정 시점에 **저장 지점(Savepoint)**을 설정
--     - 하나의 트랜잭션을 여러 단계로 나눠 관리 가능

-- ✅ ROLLBACK TO <savepoint명>
--     - 트랜잭션을 취소하되, 특정 `SAVEPOINT` 시점까지만 롤백
--     - 전체 취소(ROLLBACK) 대신, 특정 부분만 되돌릴 때 유용

CREATE TABLE kb_bank (
                         id INT PRIMARY KEY ,
                         name VARCHAR(100) NOT NULL,
                         balance BIGINT CHECK(balance >= 0)
);

CREATE TABLE encore_bank (
                             id INT PRIMARY KEY ,
                             name VARCHAR(100) NOT NULL ,
                             balance BIGINT CHECK ( balance >= 0)
);

INSERT INTO kb_bank VALUES (1231, '홍길동', 1000000);
INSERT INTO encore_bank VALUES (456, '신사임당', 1000000);

SELECT * FROM kb_bank;
SELECT * FROM encore_bank;
ROLLBACK;

START TRANSACTION ;
UPDATE kb_bank SET balance = balance - 100000 WHERE id = 1231;
UPDATE encore_bank SET balance = balance - 100000 WHERE id = 456;
ROLLBACK;
COMMIT;

START TRANSACTION;
SELECT menu_name, menu_price FROM tbl_menu;

INSERT INTO tbl_menu
VALUES (NULL, '딸기맛 감자탕', 9500, 4, 'Y');

INSERT INTO tbl_menu
VALUES (null, '생딸기한우국밥', 15000, 4, 'Y');

INSERT INTO  tbl_menu(menu_name, menu_price, category_code, orderable_status)
VALUES ('민트초코맛파전', 10000, 4, 'Y');

SAVEPOINT strawberry;
UPDATE tbl_menu SET menu_name = '수정된 메뉴' WHERE menu_code = 5;
DELETE FROM tbl_menu WHERE menu_code = 7;

ROLLBACK To strawberry ;
ROLLBACK ;












































































