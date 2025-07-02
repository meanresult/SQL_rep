/*
■ 조인의 종류
• 크로스 조인 (카테지안프로덕트) n*m건의 결과셋 #체크리스트 만들 때 
• 이너 조인(내부조인, 이퀴조인, 동등조인) # 결과 셋이 작거나 같음 
• 외부 조인(LEFT/RIGHT/PULL OUTER JOIN) # n
• 셀프 조인(1개의 테이블*2번 조인)
*/

SELECT *
FROM 주문 AS A
INNER JOIN 주문세부 AS B 
ON A.주문번호 = B.주문번호;

SELECT *
FROM 주문 AS A
JOIN 주문세부 AS B 
ON A.주문번호 = B.주문번호;

-- ANSI 
SELECT * 
FROM 부서
CROSS JOIN 사원
WHERE 이름 = '이소미';

-- NON ANSI
SELECT * 
FROM 부서, 사원
WHERE 이름 = '이소미';

-- 고객, 제품 크로스조인
-- ANSI
SELECT * 
FROM 고객 AS C
JOIN 주문 AS O
ON C.고객번호 = O.고객번호;

-- NON ANSI
SELECT * FROM 고객,주문

