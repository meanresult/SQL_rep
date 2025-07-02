USE wntrade;

-- Q. 하기 전에
-- DBMS는 비싼 리소스임 간단한 것들은 화면에서 하는 게 낫다 

-- 단일 행 함수의 종류와 사용법

-- 문자형 함수
-- • CHAR_LENGTH( ) : 문자의 개수를 반환하는 함수
-- • LENGTH( ) : 문자열에 할당된 바이트(Byte) 수를 반환하는 함수
SELECT char_length(담당자명) FROM 고객;
SELECT LENGTH(고객회사명) FROM 고객;

-- ■ CONCAT( ), CONCAT_WS( )
-- • CONCAT( ) : 문자열을 연결할 때 사용하는 함수
-- • CONCAT_WS( ) : 구분자와 함께 문자열을 연결할 때 사용하는 함수

SELECT CONCAT(고객회사명, 담당자명) FROM 고객;
SELECT CONCAT_WS(' ', 고객회사명, 담당자명) FROM 고객;

-- ■ LEFT( ), RIGHT( ), SUBSTR( )
-- • LEFT( ) : 문자열의 왼쪽부터 길이만큼 문자열을 반환하는 함수
-- • RIGHT( ) : 문자열의 오른쪽부터 길이만큼 문자열을 반환하는 함수
-- • SUBSTR( ) : 지정한 위치로부터 길이만큼의 문자열을 반환하는 함수

SELECT LEFT(주문일,7) FROM 주문;
SELECT RIGHT(주문일,5) FROM 주문;
SELECT SUBSTR(고객번호,3,2) FROM 고객;

-- ■ SUBSTRING_INDEX( )
-- • SUBSTRING_INDEX( ) : 지정한 구분자를 기준으로 문자열을 분리해서 가져올 때 사용하는 함수

SELECT * FROM 고객;
SELECT substring_index(주소,' ',1) FROM 고객;

-- [3]. 날짜 / 시간형 함수
-- NOW(), SYSDATE(), CURDATE(), & CURTIME()
-- 현재 날짜+시간 가져오기 : 
-- 쿼리 시작시점 NOW() : 쿼리(SELECT)를 시작하는 시점
-- 함수 시작시점 SYSDATE() : 함수(SYSDATE,SYSTIME)를 시작하는 시점

SELECT NOW()
, SYSDATE()
, CURDATE()
, CURTIME();

-- TEST(NOW와 SYS의 차이점)
SELECT NOW() AS NOW_1
, SLEEP(5)
, NOW() AS NOW_2
, SYSDATE() AS SYS_1
, SLEEP(5)
, SYSDATE() AS SYS_2;

-- 연도, 분기, 월, 일, 시, 분, 초 반환 함수

SELECT YEAR(NOW());

-- 기관 반환 함수
SELECT NOW()
, DATEDIFF(NOW(), '2025-6-1') -- END~ START
, TIMESTAMPDIFF(YEAR, NOW(),'2023-12-20') AS YEAR
, TIMESTAMPDIFF(MONTH, NOW(),'2023-12-20') AS MONTH
, TIMESTAMPDIFF(WEEK, NOW(),'2023-12-20') AS WEEK;

SELECT NOW()
, LAST_DAY(NOW()) -- 이번달의 마지막 일자
, DAYOFYEAR(NOW()) -- 오늘이 올해 몇번째 날인지 
, MONTHNAME(NOW()) -- 이번 달 이름을 영문으로 
, WEEKDAY('2025-07-01'); -- 요일, 월요일이 0~;

-- 태어난지 며칠 되었나?
SELECT DATEDIFF(CURDATE(),'1995-04-20') AS '태어난 일'
-- 천일 기념일
, DATE_ADD('2022-12-25', INTERVAL 1000 DAY) As 1000일
-- 나는 몇요일의 아이일까?
, DAYNAME('1995-04-20') AS '나는 몇 요일의 아이?';

-- SECTION 03 기타 단일 행 함수

-- 형 변환
-- 형 변환 함수는 파이썬에서 하는 게 좋음
-- CAST() ANSI SQL, CONVERT() MYSQL

SELECT CAST('1' AS UNSIGNED)
, CAST(2 AS CHAR(1))
, CONVERT('1', UNSIGNED)
, CONVERT(2, CHAR(1));

-- 제어 함수

-- ■ IF() 
-- • IF(조건, 참값, 거짓값) : 조건의 결과가 참이면 수식1을 반환하고, 그렇지 않으면 수식2의 결과를 반환함

SELECT 단가, 주문수량, (단가*주문수량) AS 구매금액, IF(단가*주문수량 > 20000, 'VIP', '일반') AS 등급 FROM 주문세부;

-- ■ IFNULL( ), NULLIF( )
-- • NULL과 관련된 제어 흐름 함수

-- • IFNULL(속성, 2 ) : 수식1이 NULL이 아니면 수식1의 값을 반환하고, NULL이면 수식2의 값을 반환함
SELECT  IFNULL(상사번호, '없음') FROM 사원;
SELECT IFNULL(지역, '미입력') FROM 고객;

-- • NULLIF(조건, 출력1 ) : 조건을 비교하여 값이 같으면 NULL을 반환하고, 값이 다르면 출력1의 값을 반환함
SELECT NULLIF(12*10, 120)
, NULLIF(12*10, 1200);

SELECT 고객번호, 담당자명, NULLIF(마일리지, 0) AS 유효마일리지
FROM 고객;

-- CASE 문 / 룰베이스에 추가하여 사용
-- SELECT * 
-- CASE WHEN 조건1 THEN 결과1
-- 			WHEN 조건2 THEN 결과2 
-- END

SELECT 
CASE
WHEN 12500*450 > 5000000 THEN '초과'
WHEN 2500*450 > 4000000 THEN '달성'
ELSE '미달성'
END;

-- 고객, 마일리지 1만점>VIP, 5천점 > COLD, 1천점> SILVER, BRONZE
SELECT 고객번호, 고객회사명, 마일리지,
CASE
	WHEN 마일리지 > 10000 THEN 'VIP'
	WHEN 마일리지 > 5000 THEN 'GOLD'
	WHEN 마일리지 > 1000 THEN 'SILVER'
	ELSE 'BRONZE'
END AS 등급
FROM 고객;

-- 주문금액 = 수량*단가, 할인금액 = 주문금액*할인율, 실주문금액 = 주문금액 - 할인금액 -> 주문세부 TABLE
SELECT 단가*주문수량 AS 주문금액, 주문금액*할인율 AS 할인금액 FROM 주문세부
-- 사원 테이블에서 이름, 생일, 만나이, 입사일, 입사일 수, 500일 기념일 계산
-- 주문테이블에서 주문번호, 고객번호, 주문일, 년도, 분기, 월, 일, 요일, 한글로 요일
