/*
■ 관계형 데이터베이스 : 관계연산
프로젝션 : 컬럼 리스트
셀렉션 : WHERE 문에 들어가는 연산 
조인 : 
■ 조인의 종류
• 크로스 조인 (카테지안프로덕트) n*m건의 결과셋 #체크리스트 만들 때 
• 이너 조인(내부조인, 이퀴조인, 동등조인) # 결과 셋이 작거나 같음 JOIN의 조건 컬럼에서 동일한 것만 가져오기 
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
SELECT * FROM 고객,주문;

USE wntrade;
-- 내부조인 : 가장 일반적인 조인 방식, 두 테이블에서 조건에 만족하는 행만 연결 추출
-- 연결컬럼을 찾아서 매핑 
-- ANSI SQL 조인 
SELECT * FROM 부서, 사원;

SELECT E.사원번호, E.직위, E.이름, D.부서번호, D.부서명  FROM 사원 AS E
INNER JOIN 부서 AS  D
ON  E.부서번호 = D.부서번호
WHERE 이름 = '이소미';

-- 주문, 제품 제품명을 연결
SELECT * FROM 제품, 주문세부;
SELECT 주문세부.주문번호, 제품.제품명 FROM 주문세부
INNER JOIN 제품
ON 주문세부.제품번호 = 제품.제품번호 ;

/*
[예제 5-3] 고객 회사들이 주문한 주문건수를 주문건수가 많은 순서대로 보
이시오. 이때 고객 회사의 정보로는 고객번호, 담당자명, 고객회사명을 보이
시오.
*/
SELECT * FROM 고객,주문;
SELECT 고객.고객번호, 고객.담당자명, 고객.고객회사명, COUNT(*) FROM 고객
INNER JOIN 주문
ON 고객.고객번호 = 주문.고객번호
GROUP BY 고객.고객번호-- ,고객.담당자명,고객.고객회사명
ORDER BY COUNT(*) DESC;

/*
■ [예제 5-4] 고객별(고객번호, 담당자명, 고객회사명)로 주문금액 합을 보이되,
주문금액 합이 많은 순서대로 보이시오.
*/

SELECT * FROM 고객,주문;
SELECT * FROM 고객
INNER JOIN 주문
ON 고객.고객번호 = 주문.고객번호;

SELECT * FROM 주문세부;

SELECT 고객.고객번호, 고객회사명, 담당자명, SUM(주문세부.주문수량*단가) AS 총주문금액 FROM 고객
INNER JOIN 주문
ON 고객.고객번호 = 주문.고객번호
INNER JOIN 주문세부
ON 주문.주문번호 = 주문세부.주문번호
GROUP BY 고객.고객번호, 고객회사명, 담당자명
ORDER BY 총주문금액 DESC;

/*[예제 5-5] 고객 테이블과 마일리지등급 테이블을 크로스 조인하시오. 그 다
음 고객 테이블에서 담당자가 ‘이은광’인 고객에 대하여 고객번호, 담당자명,
마일리지와 마일리지등급 테이블의 모든 컬럼을 보이시오.*/

SELECT 고객번호, 담당자명, 마일리지, 마일리지등급.* FROM 고객
CROSS JOIN 마일리지등급
WHERE 담당자명 = '이은광';

SELECT 고객번호, 담당자명, 마일리지, 마일리지등급.* FROM 고객
INNER JOIN 마일리지등급
ON 마일리지 between 하한마일리지 AND 상한마일리지
WHERE 담당자명 = '이은광';

-- 카테지안 프로덕트 : 범위성 테이블과 나올 수 있는 모든 조합을 확인
-- 내부조인 : 연결(컬럼)된 테이블에서 매핑된 행의 컬럼을 가져올 때
-- 기준 테이블의 결과를 유지하면서 매핑된 컬럼을 가져오려 할 때  

-- 외부조인
-- LEFT, RIGHT 양쪽 다 -> MY SQL은 지원 X 

-- 부서, 사원
SELECT * FROM 부서, 사원;

SELECT * FROM 사원
LEFT JOIN 부서
ON 사원.부서번호 = 부서.부서번호;

-- 고객명, 주문, 주문금액
SELECT * FROM 주문세부;

SELECT 고객.고객번호, 담당자명, 주문.주문번호, SUM(단가*주문수량) AS '총 주문금액' FROM 고객
LEFT JOIN 주문
ON 고객.고객번호 = 주문.고객번호
LEFT JOIN 주문세부
ON 주문.주문번호 = 주문세부.주문번호
GROUP BY 고객.고객번호, 담당자명, 주문.주문번호;

SELECT 고객.고객번호, 담당자명, SUM(단가*주문수량) AS '총 주문금액' FROM 고객
LEFT JOIN 주문
ON 고객.고객번호 = 주문.고객번호
LEFT JOIN 주문세부
ON 주문.주문번호 = 주문세부.주문번호
GROUP BY 고객.고객번호, 담당자명;

-- 사원이 없는 부서
SELECT 부서명, 사원번호, 이름 FROM 부서
LEFT JOIN 사원
ON 부서.부서번호 = 사원.부서번호
WHERE 사원번호 IS NULL
UNION
SELECT 부서명, 사원번호, 이름 FROM 부서
RIGHT JOIN 사원
ON 부서.부서번호 = 사원.부서번호
WHERE 부서명 IS NULL;

-- 등급이 할당되지 않는 고객 - 없음 
SELECT * FROM 고객,마일리지등급;

SELECT * FROM 고객
LEFT JOIN 마일리지등급
ON 고객.마일리지 BETWEEN 하한마일리지 AND 상한마일리지;

-- 
-- 주문, 고객  - 고객중에 주문이 없는 경우
SELECT * FROM 고객,주문;

SELECT * FROM 고객
LEFT JOIN 주문
ON 고객.고객번호 = 주문.고객번호
WHERE 주문번호 IS NULL;

SELECT * FROM 고객
RIGHT JOIN 주문
ON 고객.고객번호 = 주문.고객번호;

SELECT 고객번호,사원번호,주문일,요청일,발송일 FROM 주문
WHERE 고객번호 IS NULL;

-- 셀프조인 
select*FROM 사원;
SELECT A.이름, A.직위, B.이름 AS 상사, B.직위
FROM 사원 AS A
INNER JOIN 사원 AS B
ON A.상사번호  = B.사원번호;

select*FROM 사원;
SELECT A.이름, A.직위, B.이름 AS 상사, B.직위
FROM 사원 AS A
LEFT JOIN 사원 AS B
ON A.상사번호  = B.사원번호
WHERE B.이름 IS NULL; -- WHERE이 먼저 실행되기 때문에 엘리어스가 안먹힘

-- 주문, 고객 FULL OUTER JOIN
SELECT * FROM 주문
LIMIT 3;

SELECT * FROM 주문
LEFT JOIN 고객
ON 주문.고객번호 = 고객.고객번호
UNION
SELECT * FROM 주문
RIGHT JOIN 고객
ON 주문.고객번호 = 고객.고객번호;

-- 입사일이 빠른 선배 - 후배 관계 찾기 
SELECT A.이름, A.직위,A.입사일, B.이름, B.직위,B.입사일  FROM 사원 AS A 
INNER JOIN 사원 AS B
ON A.상사번호 = B.사원번호
WHERE A.입사일 > B.입사일
UNION
SELECT A.이름, A.직위,A.입사일, B.이름, B.직위,B.입사일  FROM 사원 AS A 
INNER JOIN 사원 AS B
ON A.상사번호 = B.사원번호
WHERE A.입사일 < B.입사일;

-- 제품별로 주문수량합, 주문금액 합
SELECT * FROM 제품,주문세부;
SELECT 제품.제품번호, 제품명,SUM(주문수량) AS '총 주문수량', SUM(주문수량*주문세부.단가) AS 주문금액 FROM 제품
INNER JOIN 주문세부
ON 제품.제품번호 = 주문세부.제품번호
GROUP BY 제품.제품번호, 제품명;


-- 아이스크림 제품의 주문년도, 제품명 별 주문수량 합
SELECT * FROM 주문세부, 제품;
SELECT YEAR(주문일), 제품명, SUM(주문수량) FROM 주문
INNER JOIN 주문세부
ON 주문.주문번호 = 주문세부.주문번호
INNER JOIN 제품
ON 주문세부.제품번호 = 제품.제품번호
WHERE 제품명 LIKE '%아이스크림'
group by YEAR(주문일), 제품명;

-- 주문이 한번도 안된 제품도 포함한 제품별로 주문수량합, 주문금액 합
USE WNTRADE;
SELECT * FROM 제품,주문세부;
SELECT 제품.제품번호,제품명, SUM(주문수량) AS 주문수량합 ,SUM(제품.단가*주문수량) AS 주문금액합 FROM 제품
LEFT JOIN 주문세부
ON 제품.제품번호 = 주문세부.제품번호
GROUP BY 제품번호;

-- 고객 회사 중 마일리지 등급이 'A'인 고객의 정보  (고객번호, 담당자명, 고객회사명, 등급명, 마일리지)
SELECT * FROM 고객,마일리지등급;
SELECT 고객번호, 담당자명, 고객회사명, 등급명, 마일리지 FROM 고객
INNER JOIN 마일리지등급
ON 마일리지 BETWEEN 하한마일리지 AND 상한마일리지
WHERE 등급명 = 'A';