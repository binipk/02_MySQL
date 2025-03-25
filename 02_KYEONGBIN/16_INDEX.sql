CREATE TABLE phone (
        phone_code INT PRIMARY KEY,
        phone_name VARCHAR(100),
        phone_price DECIMAL(10, 2)
);

INSERT INTO phone (phone_code , phone_name , phone_price )
VALUES (1, 'galaxyS23', 1200000),
       (2, 'iPhone14pro', 1433000),
       (3, 'galaxyZfold3', 1730000);

SELECT * FROM phone;

EXPLAIN SELECT * FROM phone
        WHERE phone_name = 'galaxyS23';
# EXPLAIN은 SQL 쿼리 실행 계획(Execution Plan)을 분석하는 명령어입니다.
# 즉, 쿼리가 데이터베이스에서 어떻게 실행될지, 어떤 방식으로 데이터를 검색하는지를 보여줍니다.

# phone_name에 index 추가하기
CREATE INDEX idx_name ON phone(phone_name);

EXPLAIN SELECT * FROM phone
        WHERE phone_name = 'galaxyS23';

# 인덱스 지우기
DROP INDEX idx_name ON phone;





