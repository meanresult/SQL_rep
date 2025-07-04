-- SELECT 1개 테이블
-- JOIN 2개 이상 테이블
-- 서브쿼리(내부쿼리)

USE WNTRADE;
SELECT *
FROM 고객
INNER JOIN 주문
ON 고객.고객번호 = 주문.고객번호;

-- 종류
-- 1. 서브쿼리가 반환하는 행의 갯수 : 단일행, 복수행
-- 2. 서브쿼리의 위치에 따라 : 조건절(WHERE), FROM 절, SELECT 절 
-- 3. 상관서브쿼리 : 메인쿼리와 서브쿼리 상관(컬럼)
-- 4. 반환하는 컬럼 수 : 단일컬럼, 다중컬럼 서브쿼리 

SELECT *
FROM 고객
WHERE 마일리지 = (SELECT MAX(마일리지) FROM 고객);


/*■ [예제 6-2] 주문번호 ‘H0250’을 주문한 고객에 대해 고객회사명과 담당자명
을 보이시오.*/
SELECT 고객회사명, 담당자명
FROM 고객
WHERE 고객번호 = (
	SELECT 고객번호
    FROM 주문
    WHERE 주문번호 = 'H0250');
    
SELECT 고객회사명, 담당자명
FROM 고객
LEFT JOIN 주문
ON 고객.고객번호 = 주문.고객번호
WHERE 주문번호 = 'H0250';

/*
■ [예제 6-3] ‘부산광역시’고객의 최소 마일리지보다 더 큰 마일리지를 가진 고
객 정보를 보이시오
*/
SELECT * FROM 고객
WHERE 마일리지 > (
	SELECT MIN(마일리지)
	FROM 고객
	WHERE 도시 = '부산광역시');
    
    
-- 복수행 서브쿼리 IN, ANY(하나라도 만족), SOME(ANY=), ALL(모두 만족 ), EXISTS
SELECT 고객번호
FROM 고객
WHERE 도시 = '부산광역시';

SELECT COUNT(*) AS 주문건수
FROM 주문
WHERE 고객번호 IN (
	SELECT 고객번호
    FROM 고객
    WHERE 도시 = '부산광역시');


/*■ [예제 6-5] ‘부산광역시’ 전체 고객의 마일리지보다 마일리지가 큰 고객의 정
보를 보이시오.*/
SELECT * FROM 고객
WHERE 마일리지 > ALL(
	SELECT 마일리지
    FROM 고객
    WHERE 도시 = '부산광역시');
    
/*■ [예제 6-6] 각 지역의 어느 평균 마일리지보다도 마일리지가 큰 고객의 정보
를 보이시오.*/
SELECT * FROM 고객
WHERE 마일리지 > ANY(
	SELECT AVG(마일리지)
    FROM 고객
    GROUP BY 지역);
    
/*■ [예제 6-7] 한 번이라도 주문한 적이 있는 고객의 정보를 보이시오.*/

SELECT DISTINCT 고객.고객번호, 고객회사명  FROM 고객
INNER JOIN 주문
ON 고객.고객번호 = 주문.고객번호;

SELECT 고객번호, 고객회사명 FROM 고객
WHERE EXISTS 
	(SELECT *
    FROM 주문
    WHERE 고객번호 = 고객.고객번호);
    
-- 위치 : WHERE에 존재하는 서브쿼리
-- GROUP BY의 조건절에 사용하는 서브쿼리
SELECT 도시, AVG(마일리지) AS 평균
FROM 고객
GROUP BY 도시
HAVING 평균 > (
	SELECT AVG(마일리지)
    FROM 고객);
    
-- FROM 절의 서브쿼리 : 테이블이 올 수 있음 , 인라인 뷰(현재 쿼리문에서 볼 수 있는 가상의 테이블) 반드시 별명이 필수 

/*■ [예제 6-9] 담당자명, 고객회사명, 마일리지, 도시, 해당 도시의 평균마일리지
를 보이시오. 그리고 고객이 위치하는 도시의 평균마일리지와 각 고객의 마
일리지 간의 차이도 함께 보이시오.*/

SELECT 도시,  AVG(마일리지) AS 도시_평균마일리지
FROM 고객
GROUP BY 도시; 

SELECT 담당자명, 고객회사명, 마일리지, 고객.도시, 도시_평균마일리지, 도시_평균마일리지 - 마일리지 AS 마일리지차이
FROM 고객, 
(
SELECT 도시,  AVG(마일리지) AS 도시_평균마일리지
	FROM 고객
	GROUP BY 도시 
) AS 도시별요약
WHERE 고객.도시 = 도시별요약.도시; 

-- 스칼라 서브쿼리 

-- 사원별 상사의 이름 출력을 인라인뷰로 구현
SELECT A.이름 AS 사원명, B.이름 AS 상사명
FROM 사원 A
JOIN (SELECT 사원번호, 이름 FROM 사원) B
ON A.상사번호 = B.사원번호 ;

-- 제품별 총 주문 수량과 재고 비교 

SELECT * FROM 제품;
SELECT 제품번호, SUM(주문수량) FROM 주문세부
GROUP BY 제품번호;

SELECT A.제품번호, 제품명, 재고, B.제품별주문수량, 재고-B.제품별주문수량 AS 잔여가능수량
FROM 제품 AS A
JOIN(
	SELECT 제품번호, SUM(주문수량) AS 제품별주문수량 FROM 주문세부
	GROUP BY 제품번호
    ) AS B
ON A.제품번호 = B.제품번호;

-- 고객별 가장 최근 주문일 출력
SELECT * FROM 고객;
SELECT * FROM 주문;
SELECT 고객번호, MIN(주문일) FROM 주문 GROUP BY 고객번호;

SELECT A.고객번호, 고객회사명,  B.최근주문일
FROM 고객 AS A
INNER JOIN (
	SELECT 고객번호, MAX(주문일) AS 최근주문일 FROM 주문 GROUP BY 고객번호 ) AS B
ON A.고객번호 = B.고객번호; 

-- 인라인뷰, 조인 : 유지보수 관점에서는 되도록이면 JOIN을 사용하는 게 좋음 

-- 스칼라 서브쿼리 : SELECT문에 사용하는 서브쿼리 
SELECT 고객번호, (
	SELECT MAX(주문일)
    FROM 주문
    WHERE 주문.고객번호 = 고객.고객번호
)AS 최근주문일
FROM 고객;

-- 고객별 총 주문건수 스칼라 서브쿼리
SELECT * FROM 주문;
SELECT 고객번호, COUNT(*) AS 주문건수 FROM 주문
GROUP BY 고객번호 ;
	
    -- JOIN
    EXPLAIN ANALYZE
    SELECT 고객.고객번호, 담당자명, COUNT(주문.주문번호) AS 총주문건수 FROM 고객
    LEFT JOIN 주문
    ON 고객.고객번호 = 주문.고객번호
    GROUP BY 고객번호;

	-- 서브쿼리
    EXPLAIN ANALYZE
	SELECT 고객.고객번호, (
		SELECT COUNT(*) AS 주문건수 FROM 주문 -- 스칼라 서브쿼리에서는 SELECT 값이 한개여야만 함 ) 
		WHERE 고객.고객번호 = 주문.고객번호
		GROUP BY 주문.고객번호
	) AS 총주문건수
	FROM 고객 ;

-- 각 제품의 마지막 주문단가
SELECT * FROM 주문;
SELECT * FROM 주문세부;
SELECT * FROM 주문세부

SELECT 주문번호,(

)
FROM 주문세부



-- 각 사원별 최대 주문수량 
SELECT * FROM 사원;
SELECT * FROM 주문;
SELECT * FROM 주문세부;

SELECT 주문번호, MAX(주문수량) FROM 주문세부
GROUP BY 주문번호;

SELECT 사원번호, SUM((
	SELECT MAX(주문수량) FROM 주문세부
    WHERE 주문세부.주문번호 = 주문.주문번호
	GROUP BY 주문번호
)) AS 최대주문수량
FROM 주문
GROUP BY 사원번호;

SELECT * FROM 사원;

SELECT 사원번호, 이름,(
	SELECT  MAX((
		SELECT MAX(주문수량) FROM 주문세부
		WHERE 주문세부.주문번호 = 주문.주문번호
		GROUP BY 주문번호
	)) AS 최대주문수량
	FROM 주문
    WHERE 주문.사원번호 = 사원.사원번호
	GROUP BY 사원번호
) AS 최대주문수량
FROM 사원;

-- 각 사원별 최대 주문수량 
SELECT * FROM 주문;
SELECT * FROM 주문세부;
SELECT * FROM 사원;

SELECT MAX(주문수량) AS 최대주문수량 FROM 주문
LEFT JOIN 주문세부
ON 주문.주문번호 = 주문세부.주문번호
GROUP BY 사원번호;

SELECT 이름,(
	SELECT MAX(주문수량) AS 최대주문수량 FROM 주문
	LEFT JOIN 주문세부
	ON 주문.주문번호 = 주문세부.주문번호
    WHERE 주문.사원번호 = 사원.사원번호
	GROUP BY 사원번호
) AS 총주문수량
FROM 사원;

-- -------------
-- CTE 임시테이블 정의, 쿼리 1개 
WITH 도시요약 AS (
	SELECT 도시,AVG(마일리지) AS 도시평균마일리지
    FROM 고객
    GROUP BY 도시
)

SELECT 담당자명, 고객회사명, 마일리지, 고객.도시, 도시평균마일리지
FROM 고객
JOIN 도시요약
ON 고객.도시 = 도시요약.도시;

-- SECTION 04 상관 서브쿼리와 다중 컬럼 서브쿼리

	-- 다중 컬럼 서브쿼리
    -- 고객별 최고 마일리지 
    
    SELECT 고객회사명, 도시, 담당자명, 마일리지 
    FROM 고객
    WHERE (도시,마일리지) IN ( 
		SELECT 도시, MAX(마일리지)
        FROM 고객
        GROUP BY 도시 
    );
	-- 도시별 마일리지가 가장 높은 고객회사명 
    SELECT MAX(마일리지) AS 도시별최고마일리지 FROM 고객
        GROUP BY 도시;
    
    SELECT A.고객번호, 고객회사명, 담당자명, 최고마일리지  FROM 고객 AS A
    INNER JOIN (
		SELECT 고객번호 , 도시, MAX(마일리지) AS 최고마일리지 FROM 고객
        GROUP BY 고객번호, 도시
    ) AS 도시별
    ON A.고객번호 = 도시별.고객번호 ; 
