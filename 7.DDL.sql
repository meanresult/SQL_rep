CREATE DATABASE WNCAMP_CLASS;

USE WNCAMP_CLASS;

-- 학과 테이블 및 컬럼 만들기 ----------------------------------------------------------------------------------------------

CREATE TABLE 학과
(
	학과번호 CHAR(2)
    ,학과명 VARCHAR(20)
    ,학과장명 VARCHAR(20)
    
);
INSERT INTO 학과
VALUES 
	('AA', '컴퓨터공학과','안재이')
    ,('BB', '소프트웨어학과', '한지훈')
    ,('CC', '융합학과', '신땡콩');

-- 학생 테이블 및 컬럼 만들기 ----------------------------------------------------------------------------------------------
    
CREATE TABLE 학생
(
	학번 CHAR(5),
    이름 VARCHAR(20),
    생일 DATE,
    연락처 VARCHAR(20),
    학과번호 CHAR(2)
);

INSERT INTO 학생
VALUES 
	('S0001','이윤주','2020-01-30','01033334444','AA')
    ,('S0001','이승은','2021-02-23',NULL,'AA')
    ,('S0003','백재용','2018-03-31','01077778888','DD');
    
SELECT * FROM 학생;
    
-- GENERATED 컬럼 만들기 -------------------------------------------------------------------------------------


CREATE TABLE 회원
(
	아이디 VARCHAR(20) PRIMARY KEY, 
    회원명 VARCHAR(20),
    키 INT,
    몸무게 INT,
    체질량지수 DECIMAL(4,1) AS (몸무게/POWER(키/100,2)) STORED
);

INSERT INTO 회원(아이디, 회원명, 키, 몸무게)
VALUES ('APPLE','한사과',178,70);

SELECT * FROM 회원;

INSERT INTO 회원(아이디, 회원명, 키, 몸무게)
VALUES ('JEEHUN', '한지훈', 174, 68);

-- 수정 ALTER,
-- 삭제 DROUP,
-- 테이블 컬럼 추가 ADD,
-- 변경 MODIFY/CHANGE,
-- 테이블이름 RENAME

	-- 컬렴 추가  ------------------------
	ALTER TABLE 학생
	ADD 성별 CHAR(1);
    


	-- 컬렴 타입 수정 ------------------------
	ALTER TABLE 학생
	MODIFY COLUMN 성별 VARCHAR(2);
	DESCRIBE 학생;

	-- 컬렴명 변경 ------------------------
	ALTER TABLE 학생
	CHANGE COLUMN 성별 GENDER CHAR(1);
	DESCRIBE 학생;

	-- 컬렴 삭제 ------------------------
	ALTER TABLE 학생
	DROP COLUMN GENDER;
    
    -- 테이블명 변경 ----------------------
    ALTER TABLE 학생
    RENAME 급식친구들 ;
	
    -- 확인 -----------------------------
    DESCRIBE 급식친구들;
 
 
 
/* 
__________________________________________________________________________________________________________________    
제약조건 : 무결성
PRIMARY KEY = NOT NULL + UNIQUE
CHECK
DEFAULT
FOREIGN KEY : 다른 컬럼의 기본키 
__________________________________________________________________________________________________________________
*/


-- 테이블 생성( + 제약조건 ) ------------------------------------------------------------------
CREATE TABLE 학과1
(
	학과번호 CHAR(2) PRIMARY KEY
    ,학과명 VARCHAR(20) NOT NULL
    ,학과장명 VARCHAR(20)
    
);

CREATE TABLE 학생1
(
	학번 CHAR(5) PRIMARY KEY, 
    이름 VARCHAR(20) NOT NULL,
    생일 DATE NOT NULL,
    연락처 VARCHAR(20) UNIQUE,
    학과번호 CHAR(2) REFERENCES 학과1(학과번호),
    성별 CHAR(1) check(성별 IN('남', '여')),
    등록일 DATE DEFAULT(CURDATE()),
    FOREIGN KEY (학과번호) references 학과1(학과번호)
);

SELECT * FROM 학생1;

-- 데이터 추가 -----------------------------------------------------------------------------
INSERT INTO 학과1
VALUES 
	('AA', '컴퓨터공학과','안재이')
    ,('BB', '소프트웨어학과', '한지훈')
    ,('CC', '융합학과', '신땡콩');

SELECT * FROM 학과1;



SELECT * FROM 학생1;

INSERT INTO 학생1(학번, 이름, 생일, 연락처, 학과번호)
VALUES 
	('S0001','이윤주','2020-01-30','01033334444','AA')
    ,('S0002','이승은','2021-02-23','01058452314','AA')
    ,('S0003','백재용','2018-03-31','01077778888','CC');
    
CREATE TABLE 과목
(
	과목번호 CHAR(5) PRIMARY KEY
    ,과목명 VARCHAR(20) NOT NULL
    ,학점 INT NOT NULL CHECK(학점 BETWEEN 2 AND  4)
    ,구분 VARCHAR(20) CHECK(구분 IN('전공','교양','일반'))
);

INSERT INTO 과목(과목번호, 과목명, 구분, 학점)
VALUES
('C0001','데이터베이스실습', '전공' 2),
('C0002','데이터베이스 설계와 구축', '전공', 4),
('C0003','데이터 분석', '전공', 3);

INSERT INTO 과목(과목번호, 과목명, 구분, 학점) 
VALUES
('C0001','데이터베이스실습', '전공', 2),
('C0002','데이터베이스 설계와 구축', '전공', 4),
('C0003','데이터 분석', '전공', 3);

-- 복합키 ---------------------------------------------------
CREATE TABLE 수강_1
    (
       수강년도 CHAR(4) NOT NULL
      ,수강학기 VARCHAR(20) NOT NULL
                  CHECK(수강학기 IN ('1학기','2학기','여름학기','겨울학기'))
      ,학번 CHAR(5) NOT NULL
      ,과목번호 CHAR(5) NOT NULL
      ,성적 NUMERIC(3,1) CHECK(성적 BETWEEN 0 AND 4.5)
      ,PRIMARY KEY(수강년도, 수강학기, 학번, 과목번호)
      ,FOREIGN KEY (학번) REFERENCES 학생1(학번)
      ,FOREIGN KEY (과목번호) REFERENCES 과목(과목번호)
    );
    
    ALTER TABLE 수강_1
    modify COLUMN 성적 NUMERIC(3,1) CHECK(성적 BETWEEN 0 AND 4.6);
    
    describe 수강_1;
    
    INSERT INTO 수강_1(수강년도, 수강학기, 학번, 과목번호, 성적)
    VALUES ('2023', '1학기', 'S0001', 'C0001', 4.3);
    
    INSERT INTO 수강_1(수강년도, 수강학기, 학번, 과목번호, 성적)
    VALUES ('2023', '1학기', 'S0001', 'C0002', 4.5);
    
    INSERT INTO 수강_1(수강년도, 수강학기, 학번, 과목번호, 성적)
    VALUES ('2023', '1학기', 'S0002', 'C0002', 4.5);    
    
-- 대리키 -----------------------------------------------------------------------------------
CREATE TABLE 수강_2
    (
	  수강번호 INT PRIMARY KEY AUTO_INCREMENT
      ,수강년도 CHAR(4) NOT NULL
      ,수강학기 VARCHAR(20) NOT NULL
                  CHECK(수강학기 IN ('1학기','2학기','여름학기','겨울학기'))
      ,학번 CHAR(5) NOT NULL
      ,과목번호 CHAR(5) NOT NULL
      ,성적 NUMERIC(3,1) CHECK(성적 BETWEEN 0 AND 4.5)
      ,FOREIGN KEY (학번) REFERENCES 학생1(학번)
      ,FOREIGN KEY (과목번호) REFERENCES 과목(과목번호)
    );

    INSERT INTO 수강_2(수강년도, 수강학기, 학번, 과목번호, 성적)
    VALUES ('2023', '1학기', 'S0001', 'C0001', 4.3);
    
    SELECT * FROM 수강_2;
    
    -- 제약조건의 추가 ----------------------------------------------
    
    ALTER TABLE 학생1 ADD CONSTRAINT CHECK (학번 LIKE 'S%');
    
    SELECT *
	FROM information_schema.table_constraints
	WHERE table_schema = 'wncamp_class'
	AND table_name = '학생1';
    
    SHOW CREATE TABLE 학생1;
    
    SELECT * FROM 학생1;
    
    INSERT INTO 학생1(학번, 이름, 생일,학과번호)
    VALUES ('S0004','한지훈','1995-04-20','CC');
    
    DESCRIBE 학생1;
    
    SELECT * FROM 학생1;
    
    -- 연습 ----------------------------------------------
    
