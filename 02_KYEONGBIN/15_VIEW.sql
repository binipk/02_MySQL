SELECT * FROM tbl_menu;

-- VIEW 생성
CREATE VIEW hansik AS
SELECT
    menu_code, menu_name, menu_price, category_code, orderable_status
FROM
    tbl_menu
WHERE
    category_code = 4;

-- 생성된 VIEW 조회
SELECT * FROM hansik;

SELECT * FROM information_schema.VIEWS;

# 베이스 테이블의 정보가 변경되면 VIEW의 결과도 같이 변경된다.
INSERT INTO tbl_menu VALUES (null, '식혜맛국밥', 5500, 4, 'Y');
INSERT INTO tbl_menu VALUES (99, '식혜맛국밥', 5500, 4, 'Y');

SELECT * FROM hansik;

DELETE FROM hansik WHERE menu_code = 32;

DROP VIEW hansik;

# --------------------------------------------------

CREATE OR REPLACE VIEW hansik AS
SELECT
    menu_code AS '메뉴코드', menu_name '메뉴명', category_name '카테고리명'
FROM
    tbl_menu a
        JOIN tbl_category b ON a.category_code = b.category_code
WHERE
    b.category_name = '한식';

SELECT * FROM hansik;






