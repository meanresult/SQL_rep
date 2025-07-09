
-- 테이블 생성

/***********************************************************
■ 데이터 3.1.1
■ staff : 임직원에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE staff
(
  employee_id    VARCHAR(10),
  employee_name  VARCHAR(10),
  gender		 VARCHAR(10),
  birth_date	 DATE,
  department_id  VARCHAR(10),
  position		 VARCHAR(10)
)

INSERT INTO staff VALUES('A001','권지수','F','1988-02-03','HR팀','과장')
INSERT INTO staff VALUES('A002','이철희','M','1995-10-23','HR팀','사원')
INSERT INTO staff VALUES('B003','김미나','F','1997-11-08','마케팅팀','대리')
INSERT INTO staff VALUES('B004','신승민','M','2000-03-03','마케팅팀','사원')

-- SELECT  * FROM staff



/***********************************************************
■ 데이터 3.3.1
■ apparel_product_info : 의류 제품에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE apparel_product_info
(
  product_id    VARCHAR(10),
  category1		VARCHAR(10),
  category2		VARCHAR(10),
  product_name	VARCHAR(30),
  price			INT
)

INSERT INTO apparel_product_info VALUES('JK_23FW_01','아우터','재킷','블랙 트위드 재킷',80000)
INSERT INTO apparel_product_info VALUES('JK_23FW_02','아우터','재킷','헤링본 울 재킷',100000)
INSERT INTO apparel_product_info VALUES('CD_23FW_03','아우터','카디건','캐시미어 카디건',40000)
INSERT INTO apparel_product_info VALUES('BL_22SS_04','상의','블라우스','스트라이프 블라우스',35000)
INSERT INTO apparel_product_info VALUES('SK_22SS_05','하의','치마','플레어 스커트',40000)

-- SELECT  * FROM apparel_product_info



/***********************************************************
■ 데이터 3.4.1
■ sales : 매출에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE sales
(
  order_date		DATE,
  refund_date		DATE,
  product_name	    VARCHAR(10),
  sales_amount		INT,
  sales_amount_usd  DECIMAL(38,2)
)

INSERT INTO sales VALUES('2023-01-01',NULL,'신발',80000,60.38)
INSERT INTO sales VALUES(NULL,'2023-01-02','신발',-80000,-60.38)
INSERT INTO sales VALUES('2023-02-10',NULL,'책',40000,30.19)
INSERT INTO sales VALUES('2023-02-10',NULL,'카디건',35000,26.42)
INSERT INTO sales VALUES('2023-03-31',NULL,'신발',40000,30.19)

-- SELECT  * FROM sales



/***********************************************************
■ 데이터 3.5.1
■ student_math_score : 학생들 수학점수에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE student_math_score
(
  학생		VARCHAR(5),
  class		VARCHAR(5),
  수학점수	INT
)

INSERT INTO student_math_score VALUES('A','1반',100)
INSERT INTO student_math_score VALUES('B','1반',90)
INSERT INTO student_math_score VALUES('C','1반',90)
INSERT INTO student_math_score VALUES('D','2반',80)
INSERT INTO student_math_score VALUES('E','2반',65)

-- SELECT  * FROM student_math_score



/***********************************************************
■ 실습 데이터 (1)
■ customer : 고객에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE customer
(
  customer_id		VARCHAR(5),
  last_name			VARCHAR(5),
  first_name		VARCHAR(5),
  phone_number		VARCHAR(20),
  email				VARCHAR(20),
  date_of_birth		DATE
)

INSERT INTO customer VALUES('c001','유','민수','010-1234-5678',NULL,'2000-10-01')
INSERT INTO customer VALUES('c002','김','지은','010-3333-3333','abc@ab.com','1998-10-20')
INSERT INTO customer VALUES('c003','최','진희','010-9876-0001','ddd@cc.com','1997-03-03')
INSERT INTO customer VALUES('c004','김','민국',NULL,'aaa@ab.com','1993-07-20')
INSERT INTO customer VALUES('c005','민','경섭',NULL,NULL,'1980-04-30')

-- SELECT  * FROM customer



/***********************************************************
■ 데이터 4.2.1
■ customer : 고객에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

-- DROP TABLE customer

CREATE TABLE customer
(
  customer_id	VARCHAR(10),
  name			VARCHAR(10),
  gender		VARCHAR(10)
)

INSERT INTO customer VALUES('18466','정하성','M')
INSERT INTO customer VALUES('18798','정호정','F')
INSERT INTO customer VALUES('18434','황성연','F')
INSERT INTO customer VALUES('18772','홍경빈','F')
INSERT INTO customer VALUES('18326','조우준','M')
INSERT INTO customer VALUES('18743','홍이수','M')
INSERT INTO customer VALUES('18785','차서하','M')

-- SELECT  * FROM customer



/***********************************************************
■ 데이터 4.3.1
■ distribution_center : 물류센터에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE distribution_center
(
  center_no				VARCHAR(5),
  status				VARCHAR(10),
  permission_date		DATE,
  facility_equipment	VARCHAR(50),
  address				VARCHAR(100)
)

INSERT INTO distribution_center VALUES('1','영업중','2022-07-04','화물자동차','경기도 이천시 마장면 덕평로 123')
INSERT INTO distribution_center VALUES('2','영업중','2021-06-10','지게차,화물자동차','경기도 용인시 기흥구 언동로 987-2')
INSERT INTO distribution_center VALUES('3','영업중','2022-05-26','항온항습기,지게차','서울시 중구 통일로 555')
INSERT INTO distribution_center VALUES('4','영업종료','2022-07-07',NULL,'경기도 여주시 대신면 대신로 6-1')
INSERT INTO distribution_center VALUES('5','영업종료','2021-02-02',NULL,'경기도 용인시 수지구 손곡로 29')

-- SELECT  * FROM distribution_center



/***********************************************************
■ 데이터 5.1.1
■ sales : 매출에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

-- DROP TABLE sales

CREATE TABLE sales
(
  날짜		VARCHAR(10),
  제품명	VARCHAR(10),
  수량		INT,
  금액		INT
)

INSERT INTO sales VALUES('01월01일','마우스',1,1000)
INSERT INTO sales VALUES('01월01일','마우스',2,2000)
INSERT INTO sales VALUES('01월01일','키보드',1,10000)
INSERT INTO sales VALUES('03월01일','키보드',1,10000)

-- SELECT  * FROM sales



/***********************************************************
■ 데이터 5.2.1
■ customer_ch5 : 고객에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE customer_ch5
(
  customer_id			VARCHAR(5),
  enter_date			DATE,
  first_order_date		DATE,
  cumulative_amount		INT
)

INSERT INTO customer_ch5 VALUES('001','2022-03-10','2022-03-10',10000)
INSERT INTO customer_ch5 VALUES('002','2023-02-15','2023-02-15',50000)
INSERT INTO customer_ch5 VALUES('003','2023-02-15',NULL,NULL)

-- SELECT  * FROM customer_ch5



/***********************************************************
■ 데이터 5.2.2
■ sales_ch5 : 고객 매출에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE sales_ch5
(
  order_id		VARCHAR(5),
  order_date	DATE,
  city			VARCHAR(5),
  customer_id	VARCHAR(5),
  sales_amount	INT
)

INSERT INTO sales_ch5 VALUES('1','2023-01-01','서울','a001',5000)
INSERT INTO sales_ch5 VALUES('2','2023-04-30','서울','a001',10000)
INSERT INTO sales_ch5 VALUES('3','2023-05-10','부산','a001',10000)
INSERT INTO sales_ch5 VALUES('4','2023-05-10','부산','a002',5000)
INSERT INTO sales_ch5 VALUES('5','2023-06-30','부산','a003',5000)

-- SELECT  * FROM sales_ch5



/***********************************************************
■ 실습 데이터 (2)
■ grocery_sales : 식료품 판매에 대한 매출 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE grocery_sales
(
  order_id		 VARCHAR(5),
  order_date	 DATE,
  sales_channel	 VARCHAR(10),
  category_name	 VARCHAR(10),
  product_name   VARCHAR(20),
  sales_amount	 INT,
  sales_quantity INT
)

INSERT INTO grocery_sales VALUES (1,'2023-01-10','자사몰','라면','매운맛라면','1000','1')
INSERT INTO grocery_sales VALUES (2,'2023-01-10','자사몰','라면','매운맛라면','2000','2')
INSERT INTO grocery_sales VALUES (3,'2023-02-15','오픈마켓','라면','짜장라면','3000','2')
INSERT INTO grocery_sales VALUES (3,'2023-02-15','오픈마켓','과자','초코과자','3000','1')
INSERT INTO grocery_sales VALUES (3,'2023-02-15','오픈마켓','과자','땅콩과자','4000','2')
INSERT INTO grocery_sales VALUES (4,'2023-02-22','오픈마켓','과자','초코과자','9000','3')
INSERT INTO grocery_sales VALUES (5,'2023-02-22','편의점','과자','초코과자','12000','4')
INSERT INTO grocery_sales VALUES (6,'2023-03-20','직영매장','음료','아메리카노','3000','3')

-- SELECT  * FROM grocery_sales



/***********************************************************
■ 데이터 6.1.1
■ employee_info : 임직원 정보에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE employee_info
(
  employee_id	VARCHAR(5),
  employee_name	VARCHAR(10),
  join_date		DATE,
  salary		INT
)

INSERT INTO employee_info VALUES ('a001','이민규','2020-10-03',5000)
INSERT INTO employee_info VALUES ('a002','최태호','2015-02-02',6000)
INSERT INTO employee_info VALUES ('a003','김미나','2016-12-31',7500)
INSERT INTO employee_info VALUES ('a004','이주영','2012-05-20',8000)
INSERT INTO employee_info VALUES ('a005','민다혜','2012-05-26',8000)

-- SELECT  * FROM employee_info



/***********************************************************
■ 데이터 7.2.1
■ product_info : 제품에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE product_info
(
  product_id		VARCHAR(4) ,
  product_name		VARCHAR(100),
  category_id		VARCHAR(3),
  price				INT,
  display_status	VARCHAR(10),
  register_date		DATE
)
INSERT INTO product_info VALUES ('p001','A노트북 14inch','c01',1500000,'전시중','2022-10-02')
INSERT INTO product_info VALUES ('p002','B노트북 16inch','c01',2000000,'전시중지','2022-11-30')
INSERT INTO product_info VALUES ('p003','C노트북 16inch','c01',3000000,'전시중','2023-03-11')
INSERT INTO product_info VALUES ('p004','D세탁기','c01',1500000,'전시중','2021-08-08')
INSERT INTO product_info VALUES ('p005','E건조기','c01',1800000,'전시중','2022-08-09')
INSERT INTO product_info VALUES ('p006','핸드폰케이스','c02',21000,'전시중','2023-04-03')
INSERT INTO product_info VALUES ('p007','노트북 액정보호필름','c02',15400,'전시중','2023-04-03')

-- SELECT  * FROM product_info



/***********************************************************
■ 데이터 7.3.1
■ category_info : 제품 카테고리에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE category_info
(
  category_id   VARCHAR(10),
  category_name VARCHAR(10)
)

INSERT INTO category_info VALUES ('c01','가전제품')
INSERT INTO category_info VALUES ('c02','액세서리')

-- SELECT  * FROM category_info



/***********************************************************
■ 데이터 7.4.1
■ event_info : 이벤트 제품에 대한 정보
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

CREATE TABLE event_info
(
  event_id   VARCHAR(3),
  product_id VARCHAR(4)
)

INSERT INTO event_info VALUES ('e1','p001')
INSERT INTO event_info VALUES ('e1','p002')
INSERT INTO event_info VALUES ('e1','p003')
INSERT INTO event_info VALUES ('e2','p003')
INSERT INTO event_info VALUES ('e2','p004')
INSERT INTO event_info VALUES ('e2','p005')

-- SELECT  * FROM event_info



/***********************************************************
■ 데이터 8.2.1
■ TableA, TableB
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

/*********
--TableA
*********/

CREATE TABLE tablea
(
  id   VARCHAR(1),
  성별 VARCHAR(1)
)

INSERT INTO tablea VALUES ('1','M')
INSERT INTO tablea VALUES ('2','F')
INSERT INTO tablea VALUES ('3','F')

-- SELECT  * FROM tablea



/*********
-- TableB 생성하기
*********/

CREATE TABLE tableb
(
  id       VARCHAR(1),
  전화번호 VARCHAR(5),
  직급     VARCHAR(1)
)

INSERT INTO tableb VALUES ('2','1234','A')
INSERT INTO tableb VALUES ('3','4444','B')
INSERT INTO tableb VALUES ('4','3333','C')

-- SELECT  * FROM tableb



/***********************************************************
■ 데이터 8.3.1
■ sales_2022, sales_2023
■ 방법 : CREATE부터 INSERT INTO의 마지막줄까지 드래그 후 실행(단축키F5)시켜주세요.
************************************************************/

/*********
-- sales_2022 생성하기
*********/

CREATE TABLE sales_2022
(
  order_id       VARCHAR(10),
  order_date	 DATE,
  order_amount   INT
)

INSERT INTO sales_2022 VALUES ('or0001','2022-10-01',100000)
INSERT INTO sales_2022 VALUES ('or0002','2022-10-03',100000)
INSERT INTO sales_2022 VALUES ('or0003','2022-10-03',100000)
INSERT INTO sales_2022 VALUES ('or0004','2022-12-23',120000)

-- SELECT  * FROM sales_2022



/*********
-- sales_2023 생성하기
*********/

CREATE TABLE sales_2023
(
  order_id       VARCHAR(10),
  order_date	 DATE,
  order_amount   INT
)

INSERT INTO sales_2023 VALUES ('or0005','2023-05-01',50000)
INSERT INTO sales_2023 VALUES ('or0006','2023-07-31',70000)
INSERT INTO sales_2023 VALUES ('or0007','2023-12-31',120000)

-- SELECT  * FROM sales_2023