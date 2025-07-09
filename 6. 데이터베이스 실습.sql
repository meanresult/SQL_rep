CREATE DATABASE 분석실습 DEFAULT CHARSET UTF8MB4 COLLATE utf8mb4_general_ci;

USE 분석실습;

-- 테이블 생성 ---------------------------------------------------------------------------------------------
CREATE TABLE CUSTOMER (
MEM_NO INT PRIMARY KEY,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
gd CHAR(1),
birth_dt DATE,
entr_dt DATE,
grade VARCHAR(10),
sign_up_ch CHAR(2)
);

CREATE TABLE SALES (
    InvoiceNo VARCHAR(10),
    StockCode VARCHAR(20),
    Description VARCHAR(100),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10, 2),
    CustomerID INT,
    Country VARCHAR(50)
);

-- 프라이머리키 값 변경 -------------------------------------------------------------------------------------
ALTER TABLE CUSTOMER
DROP PRIMARY KEY;

ALTER TABLE CUSTOMER
CHANGE COLUMN MEM_NO mem_no INT,
ADD PRIMARY KEY (mem_no);

-- 컬럼값 변경 --------------------------------------------------------------------------------------------

ALTER TABLE CUSTOMER
CHANGE COLUMN LAST_NAME last_name  VARCHAR(20),
CHANGE COLUMN FIRST_NAME first_name VARCHAR(20);

ALTER TABLE CUSTOMER
CHANGE COLUMN gd gender VARCHAR(20);

-- 데이터 들어갔는지 확인 --------------------------------------------------------------------------------------
select * from customer;





