USE WNTRADE;


-- 제품 테이블의 재고 컬럼 '0보다 크거나 같아야 한다'
SELECT * FROM 제품;
ALTER TABLE 제품 ADD constraint CHECK(재고 >= 0);

SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE constraint_schema = 'wntrade'
AND TABLE_NAME = '제품';

SELECT *
FROM information_schema.table_constraints
WHERE table_schema = 'wntrade'
AND table_name = '제품';

SHOW CREATE TABLE 제품;


-- 제품테이블 재고금액 컬럼 추가 '단가*재고' 자동 계산, 저장
ALTER TABLE 제품 ADD COLUMN 재고금액 DECIMAL(10,0) AS (단가*재고) STORED;

SELECT * FROM 제품;

-- 제품 레코드 삭제시 주문 세부 테이블의 관련 레코드도 함께 삭제되도록 주문 세부 테이블에 설정\

SELECT * FROM 제품;
SELECT * FROM 주문세부;

ALTER TABLE 주문세부
ADD constraint foreign key(제품번호)
references 제품(제품번호)
ON DELETE CASCADE;

SHOW CREATE TABLE 제품;

