use 분석실습;

select * from sales;

select left(invoicedate,7) as '주문날짜(월별)', sum(Quantity) as 수량,  sum(Quantity*Unitprice) as 매출액, count(distinct invoiceNO) as 주문건수  , count(distinct customerID) as 주문고객수  from sales
group by left(invoicedate,7);

select * from sales;

select country as 나라, sum(Quantity) as 수량,  sum(Quantity*Unitprice) as 매출액, count(distinct invoiceNO) as 주문건수  , count(distinct customerID) as 주문고객수  from sales
group by 나라
order by 매출액 desc;

-- --------------------------------------------------------------------
select  	country as 나라
			, StockCode as 제품코드
			, Description as 제품설명
			, sum(Quantity) as 수량
			,  sum(Quantity*Unitprice) as 매출액
			, count(distinct invoiceNO) as 주문건수  
			, count(distinct customerID) as 주문고객수  
from 		sales
group by 	나라, 제품코드, 제품설명
order by 	매출액 desc;

/*
⬛ 확인사항_______________________________________________-
특정 제품(stockcode ='21615' 의 매출지표(매출액, 주문수량) 파악

*/
select * from sales;

select  	StockCode as 제품코드
			, Description as 제품설명
from		sales
where 		stockcode ='21615';

select  	StockCode as 제품코드
			, Description as 제품설명
			, sum(Quantity) as 수량
			, sum(Quantity*Unitprice) as 매출액
			, count(distinct invoiceNO) as 주문건수  
			, count(distinct customerID) as 주문고객수  
from 		sales
where 		stockcode ='21615'
GROUP BY 	StockCode, Description
order by 	매출액 desc;

/*
⬛ 확인사항_______________________________________________
특정 제품(stockcode ='21615','21731' 의 기간별 매출현황을 확인하고 싶습니다

생각해볼 것 
*/

-- 각 제품별로 추출 
SELECT 		StockCode AS 제품코드
			,LEFT(InvoiceDate,7) AS 월별
			, SUM(UnitPrice) AS 매출
            , COUNT(DISTINCT InvoiceNo) AS 주문건수
            , COUNT(DISTINCT customerid) AS 주문고객수
FROM 		SALES
WHERE 		stockcode IN ('21615', '21731')
GROUP BY 	제품코드, 월별
ORDER BY 	제품코드 DESC , 매출 DESC;

-- 합하려 추출 
SELECT 		LEFT(InvoiceDate,7) AS 월별
			, SUM(UnitPrice) AS 매출
            , COUNT(DISTINCT InvoiceNo) AS 주문건수
            , COUNT(DISTINCT customerid) AS 주문고객수
FROM 		SALES
WHERE 		stockcode IN ('21615', '21731')
GROUP BY 	월별
ORDER BY 	매출 DESC;
--  ___________________________________________________________________________________________________________________

/*
⬛ 확인사항_______________________________________________
2011년 9월 10일부터 2011년 9월 25일까지 약 15일 동안 진행한 이벤트의 매출을 확인하고 싶습니다

생각해볼 것 
*/

SELECT * FROM SALES;

SELECT 		CASE
			WHEN InvoiceDate BETWEEN '2011-09-10' AND '2011-09-25' THEN '이벤트기간'
			WHEN InvoiceDate BETWEEN '2011-08-10' AND '2011-08-25' THEN '일반판매'
            END AS 이벤트기간
			,SUM(UnitPrice*Quantity) AS 주문매출
			,SUM(Quantity) AS 주문상품수
            ,COUNT(DISTINCT CustomerID) AS 고객수
            ,COUNT(DISTINCT InvoiceNo) AS 주문건수
FROM 		SALES
WHERE 		InvoiceDate BETWEEN '2011-09-10' AND '2011-09-25'
OR	  		InvoiceDate BETWEEN '2011-08-10' AND '2011-08-25'
GROUP BY 	이벤트기간;
-- ______________________________________________________________________________________________________________

/*
⬛ 확인사항_______________________________________________
2011년 9월 10일부터 2011년 9월 25일까지 약 15일까지 특정 제품(stockcode='17012A' 및 17012C', 17021', 17084N'에 실시한 이벤트에
대해 해당 제품의 매출을 확인하고 싶습니다 
*/

SELECT 		CASE WHEN InvoiceDate BETWEEN '2011-09-10' AND '2011-09-25' THEN '이벤트기간'
				WHEN InvoiceDate BETWEEN '2011-08-10' AND '2011-08-25' THEN '이벤트전주'
			END AS 이벤트기간
			,SUM(UnitPrice*Quantity) AS 주문매출
			,SUM(Quantity) AS 주문상품수
			,COUNT(DISTINCT CustomerID) AS 고객수
			,COUNT(DISTINCT InvoiceNo) AS 주문건수 
FROM 		SALES
WHERE 		stockcode IN ('17012A', '17012C', '17021', '17084N')
GROUP BY 	이벤트기간;

-- _____________________________________________________________________________________________________________

/*
⬛ 확인사항_______________________________________________
2010년 12월 1일부터 2010년 12월 10일까지 특정 제품(stockcode='21730','21615')을 구매한 고객 정보만 출력하고 싶습니다.
출력을 원하는 고객 정보는 [고객 ID, 이름, 성별, 생년월일, 가입 일자, 등급, 가입 채널입니다. 
*/

SELECT 		DISTINCT S.CustomerID
			, CONCAT( first_name , last_name)
            , GENDER, birth_dt
            , entr_dt
            , grade
            , sign_up_ch
FROM 		SALES AS S
INNER JOIN 	CUSTOMER AS C
ON 			S.CustomerID = C.mem_no
WHERE 		InvoiceDate BETWEEN '2010-12-01' AND '2010-12-10'
						AND stockcode IN ('21730','21615');
        
-- __________________________________________________________________________________________________________________

/*
⬛ 확인사항_______________________________________________
전체 멤버십 가입 고객 중에서 구매 이력이 없는 고객과 구매 이력이 있는 고객 정보를 구분하고 싶습니다 
*/

SELECT * FROM SALES;
SELECT * FROM CUSTOMER;

SELECT 		DISTINCT MEM_NO AS 고
			, CONCAT( last_name, first_name ) AS 이름 
            ,CASE WHEN S.CustomerID IS NULL THEN '구매이력없음'
				 WHEN S.CustomerID IS NOT NULL THEN '구매이력있음'
			END AS 구매이력

FROM 		CUSTOMER AS C
LEFT JOIN 	SALES AS S
ON 			C.MEM_NO = S.CustomerID
ORDER BY 	구매이력;

-- 구매이력 있는 고객과 없는 고객 구분

SELECT 		COUNT(DISTINCT MEM_NO) AS 고객번호
            ,COUNT(	CASE WHEN S.CustomerID IS NOT NULL THEN '구매이력있음'
					END 
				   ) AS 구매이력있음
			,COUNT(	CASE WHEN S.CustomerID IS NULL THEN '구매이력없음'
					END 
				   ) AS 구매이력없음
FROM 		CUSTOMER AS C
LEFT JOIN 	SALES AS S
ON 			C.MEM_NO = S.CustomerID;
-- ________________________________________________________________________________________________________

/*
⬛ 확인사항_______________________________________________
A 브랜드 매장의 매출 평균 지표 ATV, AMV, AvgFrq, Avg.Units의 값을 알고 싶습니다.
*/

SELECT 		SUM(UnitPrice*Quantity) AS 매출액
			,SUM(Quantity) AS 주문수량
            , COUNT(DISTINCT InvoiceNo) AS 주문건수
            , COUNT(DISTINCT CustomerID) AS 주문고객수 
            
            , SUM(UnitPrice*Quantity)/COUNT(DISTINCT InvoiceNo) AS ATV
            , SUM(UnitPrice*Quantity)/COUNT(DISTINCT CustomerID) AS AMV
            , COUNT(DISTINCT InvoiceNo)*1.00/COUNT(DISTINCT CustomerID)*1.00 AS AvgFrq
            , SUM(Quantity)*1.00/COUNT(DISTINCT InvoiceNo)*1.00 AS AvgUnits
FROM 		SALES;

-- _____________________________________________________________________________________________________

/*
⬛ 9.5.1 확인사항_______________________________________________
연도 및 월별 매출 평균 지표 ATV, AMV, AvgFrq, Avg.Units의 값을 알고 싶습니다.
*/

SELECT * FROM SALES
LIMIT 1;

SELECT 		YEAR(InvoiceDate) as 연도
			, MONTH(InvoiceDate) as 월
			, SUM(UnitPrice*Quantity) AS 매출액
			, SUM(Quantity) AS 주문수량
            , COUNT(DISTINCT InvoiceNo) AS 주문건수
            , COUNT(DISTINCT CustomerID) AS 주문고객수 
            
            , SUM(UnitPrice*Quantity)/COUNT(DISTINCT InvoiceNo) AS ATV
            , SUM(UnitPrice*Quantity)/COUNT(DISTINCT CustomerID) AS AMV
            , COUNT(DISTINCT InvoiceNo)*1.00/COUNT(DISTINCT CustomerID)*1.00 AS AvgFrq
            , SUM(Quantity)*1.00/COUNT(DISTINCT InvoiceNo)*1.00 AS AvgUnits
FROM 		SALES
GROUP BY 	YEAR(InvoiceDate)
			, MONTH(InvoiceDate);
            
-- ________________________________________________________________________________________________________________

/*
⬛ 9.6.1 확인사항_______________________________________________
2011년에 가장 많이 판매된 제품 TOP 10의 정보를 확인하고 싶습니다.
*/

SELECT * FROM SALES LIMIT 1;

SELECT 		StockCode AS 상품코드
			,Description
			,SUM(Quantity) AS "판매된 갯수"
FROM 		SALES
WHERE 		YEAR(InvoiceDate) = 2011
GROUP BY 	StockCode, Description
order by 	SUM(Quantity) DESC
LIMIT 		10;

-- _____________________________________________________________________________________________________

/*
⬛ 9.6.12 확인사항_______________________________________________
국가별로 가장 많이 판매된 제품 순으로 실적을 구하고 싶습니다.
*/

SELECT * FROM SALES LIMIT 1;

SELECT 		ROW_NUMBER() OVER (PARTITION BY 국가 ORDER BY 판매개수 DESC) AS 랭크
			, 국가
            , 상품코드
            , 상품설명
            , 판매개수
FROM 		(
				SELECT 		Country as 국가
							,StockCode AS 상품코드
							,Description AS 상품설명
							,SUM(Quantity) AS 판매개수
				FROM 		SALES
				GROUP BY 	Country, StockCode, Description
			  ) A
ORDER BY	1;
-- ____________________________________________________________________________________________

/*
⬛ 9.6.3 확인사항_______________________________________________
20대 여성 고객이 가장 많이 구매한 제품 TOP 10의 정보를 확인하고 싶습니다 
*/

SELECT * FROM SALES LIMIT 1;
SELECT * FROM CUSTOMER LIMIT 1;

SELECT 		ROW_NUMBER() OVER (ORDER BY SUM(Quantity) DESC) AS 랭크
			,상품코드
			,상품설명
			,SUM(Quantity) AS 개수
FROM 		(
			SELECT 		StockCode AS 상품코드, Description AS 상품설명, Quantity
			FROM 		SALES AS S
			INNER JOIN 	CUSTOMER AS C
			ON 			S.CustomerID = C.mem_no
			where 		gd = 'F' 
						AND	2025 - YEAR(C.Birth_dt) BETWEEN 20 AND 29
			) A  
GROUP BY  	상품코드
			,상품설명
LIMIT 		10;
-- ________________________________________________________________________________________________
/*
⬛ 9.7.1 확인사항_______________________________________________
특정 제품(stockcode='20725')과 함께 가장 많이 구매한 제품 TOP 10의 정보를 확인하고 싶습니다 
*/

SELECT * FROM SALES ;

SELECT 			StockCode AS 상품코드
				,Description AS 상품설명
				,SUM(Quantity) AS 개수
FROM 			SALES AS A
INNER JOIN 		(
				SELECT DISTINCT InvoiceNo FROM SALES
				WHERE StockCode ='20725'
				) AS B
ON 				A.InvoiceNo = B.InvoiceNo
WHERE 			StockCode <> '20725'
GROUP BY		StockCode ,Description
ORDER BY		3 DESC
LIMIT			10;

-- _________________________________________________________________________________________

/*
⬛ 9.7.2 확인사항_______________________________________________
특정 제품(stockcode='20725')과 함께 가장 많이 구매한 제품 TOP 10의 정보를 확인하고 싶습니다
단, 이 중에서 제품명에 LUNCH가 포함된 제품은 제외합니다  
*/

SELECT 			StockCode AS 상품코드
				,Description AS 상품명
				,SUM(Quantity) AS 개수
FROM 			SALES AS A
INNER JOIN 		(
				SELECT DISTINCT InvoiceNo FROM SALES
				WHERE StockCode ='20725'
				) AS B
ON 				A.InvoiceNo = B.InvoiceNo
WHERE 			StockCode <> '20725' 
				AND A.Description NOT LIKE '%LUNCH%'
GROUP BY		StockCode ,Description
ORDER BY		3 DESC
LIMIT			10;

-- ________________________________________________________________________________________________

/*
⬛ 9.8.1 확인사항_______________________________________________
쇼핑몰의 재구매 고객수를 확인하고 싶습니다. 
*/
 
 
 SELECT * FROM SALES LIMIT 1;
  SELECT * FROM CUSTOMER LIMIT 1;

SELECT 		  	A.CUSTOMERID AS 고객ID
				,COUNT(DISTINCT A.INVOICENO) AS 재구매횟수
FROM 		  	SALES AS A 
INNER JOIN	  (	SELECT CustomerID
				FROM SALES 
				WHERE CustomerID <> ''
				GROUP BY CustomerID
			  ) AS B
ON 			  	A.CustomerID = B.CustomerID
GROUP BY		A.CUSTOMERID
HAVING 			COUNT(DISTINCT A.INVOICENO) >= 2;

-- -----------------------------------------

SELECT 		  COUNT(DISTINCT A.CUSTOMERID) AS 고객ID
FROM 		  (	
				SELECT 		CustomerID
				FROM 		SALES 
				WHERE 		CustomerID <> ''
				GROUP BY 	CustomerID
				HAVING 		COUNT(DISTINCT INVOICENO) >= 2
			  ) A;
              
-- ______________________________________________________________________________________

/*
⬛ 9.8.2 확인사항_______________________________________________
특정제품 (StockCode = '21088'의 재구매 고객수와 구매일자 순서를 확인하고 싶습니다
*/

SELECT * FROM SALES;

SELECT 	COUNT(DISTINCT CustomerID) AS 재구매횟수
FROM 	   (SELECT  	CustomerID
						,dense_rank() OVER (PARTITION BY CUSTOMERID ORDER BY INVOICEDATE) AS RNK
			FROM 		SALES AS A
			WHERE 		StockCode = '21088' AND CustomerID <> '' 
			) A
WHERE RNK = 2;

-- ________________________________________________________________________________________
/*
⬛ 9.8.3 확인사항_______________________________________________
2010년 구매이력이 있는 고객들의 2011년 유지율을 확인하고 싶습니다.
*/

SELECT 	COUNT(DISTINCT CustomerID) AS 재구매횟수
FROM 	SALES
WHERE	CUSTOMERID <> ''
AND		CUSTOMERID IN (SELECT CUSTOMERID
					   FROM		SALES
                       WHERE 	CUSTOMERID <>''
								AND YEAR(INVOICEDATE) = '2010'
					  )
AND 	YEAR(INVOICEDATE) = '2011';

-- ________________________________________________________________________________________
/*
⬛ 9.8.4 확인사항_______________________________________________
고객별로 첫 구매이후 재구매까지의 구매기간을 확인하고 싶습니다.
*/

-- [2] 첫 구매 이후 재구매 기간
WITH 구매기록 AS (
  SELECT
    CustomerID,
    InvoiceDate AS 구매일,
    LAG(InvoiceDate) OVER (PARTITION BY CustomerID ORDER BY InvoiceDate) AS 이전구매일
  FROM SALES
  WHERE CustomerID IS NOT NULL
)
SELECT
  C.mem_no,
  C.last_name,
  구매기록.구매일,
  구매기록.이전구매일,
  DATEDIFF(구매기록.구매일, 구매기록.이전구매일) AS 구매간격_일
FROM 구매기록
JOIN CUSTOMER C ON 구매기록.CustomerID = C.mem_no
WHERE 구매기록.이전구매일 IS NOT NULL
ORDER BY C.mem_no, 구매기록.구매일;



