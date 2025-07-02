USE wntrade;

SELECT * FROM 고객;

SELECT COUNT(*)
, COUNT(고객번호)
, COUNT(도시)
, COUNT(지역)
FROM 고객;

SELECT SUM(마일리지)
, AVG(마일리지)
, MIN(마일리지)
, MAX(마일리지)
FROM 고객
WHERE 도시 = '서울특별시';

-- 그룹별 집계 : 컬럼값 > 범주로 집계
-- GROUP BY

-- [예제 4-4] 고객 테이블에서 도시별 고객의 수와 해당 도시 고객들의 평균마일리지를 조회하시오.
SELECT 도시
, COUNT(*) AS 고객순 -- 서브셋의 레코드 전체 *
, AVG(마일리지) AS '평균 마일리지'
FROM 고객
GROUP BY 도시;

/*
 ■ [예제 4-5] 담당자직위별로 묶고, 
같은 담당자직위에 대해서는 도시별로 묶어서 집계한 결과(고객수와 평균마일리지)를 보이시오. 
(이때 담당자직위 순, 도시 순으로 정렬하기)*/

SELECT  담당자직위, COUNT(*) AS 고객수, AVG(마일리지) AS 평균마일리지
FROM 고객
GROUP BY 담당자직위, 도시;

-- 집계 결과에 조건부 출력
select 도시
, COUNT(*) AS 고객수
, AVG(마일리지) AS 평균마일리지
FROM 고객
GROUP BY 도시
HAVING COUNT(*) >= 10;

-- WHERE : 셀렉션의 조건, GROUP BY  이전에 실행 
-- HAVING : GROUP BY 한 집계에 대한 조건, 기준 미달인 

SELECT * FROM 고객;
SELECT 도시 ,SUM(마일리지) AS 마일리지합계 FROM 고객
WHERE 고객번호 LIKE 'T%'
GROUP BY 도시
HAVING 마일리지합계 >= 1000;

SELECT 제품번호, AVG(주문수량)
FROM 주문세부
WHERE 주문수량 >= 30
GROUP BY 제품번호
HAVING AVG(주문수량)>=40;

/* SQL 실행 순서
SELECT - 5
FROM - 1 
WHERE - 2 
GROUP BY - 3
HAVING - 4 
ORDER BY - 6 

ORDER BY를 하는 이유 많은 데이터를 최대한 적게 만들어놓고 정렬시켜야 효과적이기 때문이다 
*/

-- 집계함수 심화 
-- WITH ROLLUP
SELECT * FROM 고객;
SELECT 도시 ,SUM(마일리지) AS 마일리지합계 
FROM 고객
WHERE 고객번호 LIKE 'T%'
GROUP BY 도시 WITH ROLLUP
HAVING 마일리지합계 >= 1000
;
-- ------------------------------------
SELECT 도시, 마일리지합계
FROM (
    SELECT 도시, SUM(마일리지) AS 마일리지합계
    FROM 고객
    WHERE 고객번호 LIKE 'T%'
    GROUP BY 도시
) AS 도시집계
WHERE 마일리지합계 >= 1000

UNION ALL

SELECT '합계' AS 도시, SUM(마일리지합계) AS 마일리지합계
FROM (
    SELECT 도시, SUM(마일리지) AS 마일리지합계
    FROM 고객
    WHERE 고객번호 LIKE 'T%'
    GROUP BY 도시
) AS 도시집계
WHERE 마일리지합계 >= 1000;

SELECT 도시, 합계
FROM(
		SELECT 도시, SUM(마일리지) AS 합계 
		FROM 고객
		WHERE 고객번호 LIKE 'T%'
		GROUP BY 도시 WITH ROLLUP
	) AS 그룹
WHERE (도시 IS NULL OR 합계 >= 1000);

SELECT 도시, SUM(마일리지) AS 합계 
		FROM 고객
		WHERE 고객번호 LIKE 'T%'
		GROUP BY 도시 WITH ROLLUP;
-- --------------------------
/*
■ [예제 4-9] 담당자직위에 ‘마케팅’이 들어가 있는 고객에 대해 고객(담당자직
위, 도시)별 고객수를 보이시오. 담당자직위별 고객수와 전체 고객수도 함께
볼 수 있도록 조회하시오.
*/
SELECT 담당자직위, 도시, COUNT(*)AS 고객수 FROM 고객
WHERE 담당자직위 LIKE '%마케팅%'
GROUP BY 담당자직위, 도시
WITH ROLLUP;


/* ■ GROUPING( )
• WITH ROLLUP의 결과로 나온 NULL에 대해서는 1을 반환하고, 그렇지 않은 NULL
에 대해서는 0을 반환함 */

/*
■ [예제 4-10] 담당자직위가 ‘대표 이사’인 고객에 대하여 지역별로 묶어서 고
객수를 보이고, 전체 고객수도 함께 보이시오.
*/

SELECT 지역
, IF (GROUPING(지역) = 1, '합계행', 지역) AS 도시명
, COUNT(*) AS 고객수
, GROUPING(지역) AS 구분 
FROM 고객
WHERE 담당자직위 = '대표 이사'
GROUP BY 지역 WITH ROLLUP;

-- 값들 붙이기 
SELECT GROUP_CONCAT(DISTINCT 지역)
FROM 고객;

-- 성별에 따른 사원수, null > 총 사원수를 출력
SELECT 
IF(GROUPING(성별)=1, '총 사원
수', 성별) as 성별
, COUNT(*) as 개수
FROM 사원
GROUP BY 성별 WITH ROLLUP;

-- 주문년도별 주문건수
SELECT LEFT(주문일,4) AS 주문년도,COUNT(*) FROM 주문
GROUP BY 주문년도;

-- 주문년도별, 분기별, 전체주문건수 추가
SELECT 
LEFT(주문일,4) AS 주문년도
,CASE
		WHEN SUBSTR(주문일,6,2) < 3 THEN '1분기'
		WHEN SUBSTR(주문일,6,2) < 6 THEN '2분기'
		WHEN SUBSTR(주문일,6,2) < 9 THEN '3분기'
		ELSE '4분기'
	END as 분기별
,COUNT(*) as 주문건수
FROM 주문
GROUP BY 주문년도, 분기별 with ROLLUP;
-- -----------------
SELECT 
year(주문일) AS 주문년도
,quarter(주문일) as 분기별
,COUNT(*) as 주문건수
FROM 주문
GROUP BY 주문년도,분기별 with ROLLUP;
-- ----------------
SELECT
  IF(GROUPING(주문년도) = 1, '전체주문건수', 주문년도) AS 주문년도,
  IF(GROUPING(분기) = 1, 
     IF(GROUPING(주문년도) = 1, '-', '연도별 합계'), 분기) AS 분기,
  COUNT(*) AS 주문건수

FROM (
	  SELECT 
		YEAR(주문일) AS 주문년도
        , QUARTER(주문일) AS 분기
	  FROM 주문
) AS 주문
GROUP BY 주문년도, 분기 WITH ROLLUP;



-- 주문내역에서 월별 발송지연건 
SELECT 
LEFT(주문일,7) AS 주문월 
,COUNT(*)AS '발송지연 건' 
FROM 주문
WHERE 요청일 < 발송일
GROUP BY 주문월 WITH ROLLUP;

SELECT 
monthname(주문일) AS 주문월
,COUNT(*)AS '발송지연 건' 
FROM 주문
WHERE 요청일 < 발송일
GROUP BY 주문월 WITH ROLLUP;

-- 아이스크림 제품별 재고합
SELECT IF(GROUPING(제품명)=1,'총 합계',제품명) as 아이스크림
,SUM(재고) as 재고합 
FROM 제품
WHERE 제품명 LIKE '%아이스크림'
GROUP BY 제품명 WITH ROLLUP;


-- 고객구분(VIP,일반)에 따른 고객수, 평균 마일리지, 총합
SELECT 
CASE
	WHEN 마일리지 > 100000 THEN 'VIP'
    ELSE '일반'
END AS 등급
, COUNT(*) AS 고객수
, AVG(마일리지) as '평균 마일리지'
FROM 고객
GROUP BY 등급 with rollup;

SELECT 
IF(GROUPING(등급)=1,'총개수',등급)
,고객수
,평균_마일리지

FROM(
		SELECT
			CASE
				WHEN 마일리지 > 100000 THEN 'VIP'
				ELSE '일반'
			END AS 등급
		, COUNT(*) AS '고객수'
		, AVG(마일리지) as '평균_마일리지'
		FROM 고객
		GROUP BY 등급 with rollup
)AS 고객;

-- -------------
SELECT 
IF(GROUPING(등급)=1,'총개수',등급) AS 
, COUNT(*) AS '고객수'
, AVG(마일리지) as '평균_마일리지'

FROM(
		SELECT 
			마일리지,
			CASE
				WHEN 마일리지 > 100000 THEN 'VIP'
				ELSE '일반'
			END AS 등급
		FROM 고객
		
)AS 고객
GROUP BY 등급 with rollup;



SELECT
	CASE
		WHEN 마일리지 > 100000 THEN 'VIP'
		ELSE '일반'
	END AS 등급
, COUNT(*) AS '고객수'
, AVG(마일리지) as '평균 마일리지'
FROM 고객
GROUP BY 등급 with rollup;
