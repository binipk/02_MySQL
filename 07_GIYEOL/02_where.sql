🐒유승제 강사🐒 — 오후 4:27
-- ==============================
-- WHERE
-- ==============================

WHERE 비교 연산자
-- 표현식 사이의 관계를 비교하기 위해 사용하고, 비교 결과는 논리 결과 중에 하나 (TRUE/FALSE/NULL)가 된다.
-- 단, 비교하는 두 컬럼 값/표현식은 서로 동일한 데이터 타입이어야 한다.

연산자                    설명
--------------------------------------------------------------------------------
=                        같다
>,<                        크다/작다
>=,<=                    크거나 같다/작거나 같다
<>,!=                    같지 않다 (^= 없음)
BETWEEN AND                특정 범위에 포함되는지 비교
LIKE / NOT LIKE            문자 패턴 비교
IS NULL / IS NOT NULL    NULL 여부 비교
IN / NOT IN                비교 값 목록에 포함/미포함 되는지 여부 비교
WHERE 논리 연산자
-- 여러 개의 제한 조건 결과를 하나의 논리결과로 만들어 줌 (&&, 사용불가)
-- AND &&    여러 조건이 동시에 TRUE일 경우에만 TRUE 값 반환
-- OR     여러 조건들 중에 어느 하나의 조건만 TRUE이면 TRUE값 반환
-- NOT !    조건에 대한 반대값으로 반환(NULL은 예외)
-- XOR        두 값이 같으면 거짓, 두 값이 다르면 참
 -- 1 비교 연산자
select
    menu_name
,   menu_price
,   orderable_status
from
        tbl_menu
where
    orderable_status = 'N';
 -- tbl_menu 테이블에서 가격이 만3천원인 메뉴 이름 ,가격, 주문 여부 출력
 select
     menu_name,
     menu_price,
     orderable_status
    from tbl_menu where menu_price = 13000;
-- 같지 않은 연산자와 함께 where문 사용
select
    menu_name,
    menu_price,
    orderable_status
 from
     tbl_menu
where
    orderable_status ='N'; -- mysql은 비교나 검색을 수행할 때 기본적으로 대소문자 구분없이 사용가능
 --  orderable_status <> 'Y';
 -- orderable_status != 'Y';
 -- 대소비교 연산자와 함께 where문 사용
select
    menu_name,
    menu_price,
    orderable_status
from
    tbl_menu
where
    menu_price > 20000;

 --
select
    menu_name,
    menu_price,
    orderable_status
from
    tbl_menu
where
    menu_price <= 20000;
 -- 2. and 연산자와 함께 where문 사용
 -- 0은 FALSE, 0외의 숫자는 true로 암사적으로 형변환 후 평가
 -- 문자열은 0으로 반환, FALSE로 평가
 -- NULL과의 연산 결과는 null이다 (0 && null제외)
 select 1 and 1, 2 && 2, -1 && 1 , 1 && 'abc';
 select 1 and 0, 0 and 1, 0 and 0, 0 and null;
 select 1 and null, null and null;
 select 1 + null, 1 - null,1 * null,1 / null;
 -- 메뉴에서 주문 여부가 y이면서, 카테고리가 10인 메뉴 목록 조회
 select
     menu_code,
     menu_price,
     category_code,
     orderable_status
     from tbl_menu
 where
     orderable_status = 'Y'
   and
     category_code = 10;

 -- 메뉴에서 메뉴가격이 5000원보다 크고, 카테고리 코드가 10인 메뉴를 구하라
 -- 단, 출력 메뉴코드, 메뉴이름, 메뉴가격,카테고리코드, 주문여부만 출력
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where
    menu_price > 5000
   and
    category_code = 10 ;
 -- 3. or연산자와 함께 where 문 사용
 select 1 or 1, 1 or 0 , 0 or 1;
 select 0 or 0;
 select 1 or null, 0 or null, null or null;
-- 메뉴에서 주문 여부가 y이거나, 카테고리가 10인 메뉴 목록 조회
select
    menu_code,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where
    orderable_status = 'Y'
   or
    category_code = 10;
 -- 우선 순위
 -- and랑 or 중에 and가 더 우선순위가 높다
 select 1 or 0 and 0;
 select (1 or 0) and 0;
 -- 카테고리 번호가 4 또는 가격이 9천원이면서 메뉴번호가 10보다 큰 메뉴를 조회
 -- 모든 컬럼 조회
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
    from tbl_menu
 where
     category_code =4
or
     menu_price = 9000
and
     menu_code > 10;

-- test