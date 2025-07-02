USE my_db;

-- 사원들의 소속 부서 종류만 조회
SELECT * FROM DEPT AS 부서;
SELECT * FROM EMP;

SELECT distinct DEPTNO
FROM EMP;

-- 급여가 2000이상 3000이하를 받는 사원 정보(부서번호, 이름, 직무, 급여)만 조회 , 결과집합 생성
SELECT DEPTNO, ENAME, JOB, SAL FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

-- 사원번호가 7902, 7788, 7566인  사원 정보(사원번호,부서번호, 이름, 직무 )만 조회
SELECT 
EMPNO
, ENAME
, JOB
, SAL 
FROM EMP
WHERE EMPNO IN (7902, 7788, 7566);

-- 사원 이름이 ‘A’로 시작하는  사원이름, 급여, 업무
SELECT ENAME, SAL, JOB FROM EMP
WHERE ENAME LIKE 'A%';

-- 사원 이름의 두번째 문자가 ‘A’인  모든 사원이름, 급여, 업무
SELECT ENAME, SAL, JOB FROM EMP
WHERE ENAME LIKE '_A%';

-- 사원 이름이 마지막 문자가 ‘N’인  사원이름, 급여, 업무 조회
SELECT ENAME, SAL, JOB FROM EMP
WHERE ENAME LIKE '%N';

-- 커미션을 받지 않는 사원이름, 급여, 업무, 커미션을  조회
SELECT ENAME, SAL, JOB, COMM FROM EMP
WHERE COMM IS NULL;

-- 커미션이 NULL인 경우 0으로 SAL+COMM = TOTAL_SALARY 계산
SELECT *,IFNULL(COMM,0) + SAL AS TOTAL_SALARY FROM EMP;
-- 커미션을 받는 사원들의 커미션 평균
SELECT AVG(COMM) FROM EMP
WHERE COMM IS NOT NULL;

-- DEPTNO, JOB 별 급여합계, 급여평균, 총합계
SELECT 
IF(GROUPING(DEPTNO)=1,'총합계',DEPTNO) AS 부서_번호
, IF(GROUPING(JOB)=1,
				IF(GROUPING(DEPTNO)=1,'-','부서별_급여_평균합계'), JOB) AS 직업
, AVG(SAL) AS 급여_평균 
FROM EMP
GROUP BY DEPTNO, JOB WITH ROLLUP;

-- ------------
SELECT
IF(GROUPING(DEPTNO)=1,'급여_평균_총합계',DEPTNO)
, IF(GROUPING(JOB)=1,
				IF(GROUPING(DEPTNO)=1,'-','부서별_급여_평균합계')
			, JOB)

FROM(
	SELECT DEPTNO
    , JOB
    , SAL 
    FROM EMP
	
)
GROUP BY DEPTNO, JOB WITH ROLLUP;

-- 외에 연습문제 출제해서 풀기