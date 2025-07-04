-- DML : 데이터 조작어

	-- SECTION 01 : DML의 개요
		-- SELECT 연산
        
        -- DML 
        -- INSERT : INSERT  SELECT, INSERT ON DUPLICATE KEY UPDATE
        -- UPDATE : UPDATE SELECT.UPDATE JOIN
        -- DELETE : DELETE SELECT, DELETE JOIN
        
        --  [예제]
        SELECT * FROM 부서;
        
        INSERT INTO 부서
        VALUES ('A5','마케팅부');
        
        -- 제품
        -- 제품번호:91, 제품명 : 연어피클소스, 단가:5000,재고:40
        
        SELECT * FROM 제품;
        INSERT INTO 제품
        VALUES (79, '연어피클소스', NULL, 5000,40);
		
        SELECT * FROM 사원;
        INSERT INTO 사원
        VALUES
        ('E11', '한지훈', 'HANJEEHUN', '과장','남','1995-04-20',NULL,NULL,'화성시','경기도',NULL,NULL,'A1'),
        ('E12', '신땡콩', 'TAENKKONG', '실장','여','1994-08-28',NULL,NULL,'화성시','경기도',NULL,NULL,'A1'),
        ('E13', NULL, NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A1');
        
        SELECT * FROM 제품;
        
        UPDATE 제품 SET 단가 = 단가*1.1, 재고=재고-10
        WHERE 제품번호 = 79;
        
        DELETE FROM 제품
        WHERE 제품번호 = 79;
        
        DELETE FROM 사원
        ORDER BY 입사일 DESC
        LIMIT 3;
        
        SELECT * FROM 사원;
        
		SELECT * FROM 제품;
        INSERT INTO 제품
        VALUES (79, '연어피클소스', NULL, 5000,40)
        ON duplicate key update
        제품명 = '연어피클', 단가=6000, 재고=50;
        
        
    -- SECTION 02 DML 심화
		-- ■ INSERT INTO SELECT
		-- [에제]
			CREATE TABLE 고객주문요약
            (
            고객번호 CHAR(5) PRIMARY KEY
			,고객회사명 VARCHAR(50)
            ,주문건수 int
            ,최종주문일 date
            );
            
            SELECT * FROM 고객주문요약;
            
            INSERT INTO  고객주문요약
            -- VALUES
            (
            SELECT 고객.고객번호, 고객회사명, COUNT(*), MAX(주문일) AS 최종주문일 
            FROM 고객 LEFT JOIN 주문
            ON 고객.고객번호 = 주문.고객번호
            GROUP BY 고객.고객번호, 고객회사명
            ) AS T
            ON duplicate key update
				주문건수 = T.주문건수,
                최종주문일 = T.최종주문일;
            
            SELECT * FROM 고객주문요약;
            
            SELECT * FROM;
            
            -- -----------------------------------------------------------------------------------------------
            
            UPDATE 제품 -- 테이블 
            -- 수정할 컬럼 
            SET 단가 = ( 
				SELECT *
                FROM (
						SELECT AVG(단가)
                        FROM 제품
                        WHERE 제품명 LIKE '%소스%'
                        ) AS T
            )
            -- 수정할 값 
            WHERE 제품번호 = 78;
            
            -- ------------------------------------------------------------------------------------------------
            
            /*■ [예제 7-13] 한 번이라도 주문한 적이 있는 고객의 마일리지를 10% 인상하시오.*/
            
            SELECT * FROM 제품;
            
            SELECT DISTINCT 고객.고객번호 FROM 고객
            LEFT JOIN 주문
            ON 고객.고객번호 = 주문.주문번호;
            
            UPDATE 고객
				,(
					SELECT DISTINCT 고객번호
					FROM 주문
				) AS 주문고객 -- UPDATE 구문에서 사용하는 서브쿼리는 뷰처럼 취급됨 
                
            SET 마일리지 = 마일리지 * 1.1
            WHERE 고객.고객번호 IN (주문고객.고객번호);
				
			SELECT * FROM 고객
            WHERE 고객번호 IN (SELECT DISTINCT 고객번호
							FROM 주문
                            );
			
            -- -------------------------------------------------------------------
            /* 
			■ UPDATE JOIN
				• INNER JOIN을 사용하여 다른 테이블의 행과 일치하는 행을 수정할 수 있음
				• LEFT OUTER JOIN을 사용하여 그렇지 않은 행을 수정할 수도 있음
				• 변경할 값에는 상수나 수식뿐만 아니라 조인할 테이블에 있는 컬럼에 기반하여
				값을 넣을 수도 있음
            */
            
            -- NON-ANSI SQL 표현
            UPDATE 변경할_테이블A
					, 조인할_테이블 B
			SET 테이블A.컬럼명 = 값
            WHERE 기타_조건 ;
            
            
    -- SECTION 03
    -- SECTION 04
    -- SECTION 05
    
    