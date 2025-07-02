show databases;
use wntrade;
show tables;
select * from 고객;
select * from 고객;
select 고객회사명,담당자명 from 고객
where 담당자직위 = '영업 사원';

-- 프로젝션 연산
select 고객번호, 고객회사명, 담당자명 -- 어떤 컬럼 지정
from 고객 -- 어떤 테이블에서
where 고객회사명 = '유성물산교역'; -- 셀렉션 연산

-- 쿼리 연산 : 각 테이블의 데이터를 셀렉션, 프로젝션 하기
-- 프로젝션 : 컬럼, 연산식, 함수

-- as 별칭 사용법 
select 고객회사명
, 담당자명 as 이름 
, 담당자직위 as 직위 
, 마일리지*1.1 as '마일리지 보너스' -- 특수문자나 띄어쓰기 하고싶으면 따옴표 써야 함 ㅋ 
, 마일리지
from 고객
where 마일리지 > 10000
order by 마일리지 desc;

select 고객회사명
, 담당자명 as '고객회사 담당자'
, 담당자직위 as 직위 -- 어떤 컬럼을 가져올 것인가 
from 고객 -- 어떤 테이블에서 가져올 것인가 
order by 고객회사명 -- 정렬 
limit 100; -- 몇개까지 가져올지 정하기

select 고객회사명
, 담당자명 as '고객회
, 담당자직위
from 고객 -- 명령어들은 대문자로 쓰는 연습해야 됨 
order by 마일리지 desc
limit 3;

desc 고객;
show columns from 사원 like '이%';