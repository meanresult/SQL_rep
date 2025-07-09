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
            ,COUNT(	CASE WHEN S.CustomerID IS NULL THEN '구매이력없음'
					WHEN S.CustomerID IS NOT NULL THEN '구매이력있음'
					END 
				   ) AS 구매이력
FROM 		CUSTOMER AS C
LEFT JOIN 	SALES AS S
ON 			C.MEM_NO = S.CustomerID;
-- ________________________________________________________________________________________________________
