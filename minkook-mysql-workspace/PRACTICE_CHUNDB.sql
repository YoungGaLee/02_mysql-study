
/* ## SELECT(Basic) 실습문제 - chundb ## */
use chundb;

-- 아래의 select문들을 실행하여 각 테이블에 어떤 컬럼과 어떤 데이터가 담겨있는지 파악하고 진행하시오.
SELECT * FROM tb_department;      -- 학과
SELECT * FROM tb_student;         -- 학생
SELECT * FROM tb_professor;       -- 교수
SELECT * FROM tb_class;           -- 과목
SELECT * FROM tb_class_professor; -- 과목별교수 
SELECT * FROM tb_grade;           -- 성적

-- 1. 춘 기술대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 "학과 명", "계열"으로 표시하도록 한다.
/*
    학과 명           | 계열
    ---------------------------------
    국어국문학과      | 인문사회
    영어영문학과      | 인문사회
    사학과            | 인문사회
    철학과            | 인문사회
        ....
    디자인학과        | 예체능
    체육학과          | 예체능
    ---------------------------------
    63개 행 조회
*/

SELECT 
	  concat(A.DEPARTMENT_NAME,"|",A.CATEGORY) as "학과명 | 계열"
FROM 
	tb_department A; 
    
-- 2. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 
--    정렬은 이름으로 오름차순 표시하도록 한다.
/*
    학생 이름 | 주소지
    -------------------------------------------------------------------
    감현제	  | 서울강서등촌동691-3부영@102-505
    강동연	  | 경기도 의정부시 민락동 694 산들마을 대림아파트 404-1404
    강민성	  | 서울시 동작구 흑석동10 명수대 현대아파트 108-703
    강병호	  | 서울시 노원구 하계동 한신 아파트 2동417호
    강상훈	  | 전주시 덕진구 덕진동 전북대학교 식품영양학과
        ...
    황지수	  | 전주시 덕진구 인후 2가 229-36
    황진석	  | 서울시 양천구 신월5동 24-8
    황형철	  | 전남 순천시 생목동 현대ⓐ 106/407   T.061-772-2101
    황효종	  | 인천시서구 석남동 564-4번지
    --------------------------------------------------------------------
    
    588개의 행 조회
*/
SELECT 
 
	  concat( A.STUDENT_NAME,"|",A.STUDENT_ADDRESS) as "학생이름 | 주소지"
FROM 
	tb_student A; 

    
-- 3. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다.
/*
    학과별 정원
    ------------------------------------------
    국어국문학과의 정원은 20명 입니다.
    영어영문학과의 정원은 36명 입니다.
    사학과의 정원은 28명 입니다.
    철학과의 정원은 28명 입니다.
    법학과의 정원은 40명 입니다.
    행정학과의 정원은 32명 입니다.
    ....
    산업디자인학과의 정원은 28명 입니다.
    디자인학과의 정원은 32명 입니다.
    체육학과의 정원은 24명 입니다.
    ------------------------------------------
    63개 행 조회
*/

SELECT 
	 concat( A.DEPARTMENT_NAME,'의 정원은 ', A.CAPACITY,'입니다') as "학과별 정원"
FROM 
	tb_department A; 

-- 4. 도서관에서 대출 도서 장기 연체자들을 찾아 이름을 게시하고자 한다. 
--    그 대상자들의 학번이 다음과 같을 때 대상자들을 찾는 적절한 sql 구문을 작성하시오.
--    A513079, A513090, A513091, A513110, A513119
/*
    student_name
    -------------
    홍경희
    최경희
    정경훈
    정경환
    이경환
    -------------
    
    5개의 행 조회
*/

SELECT 
	 A.STUDENT_NAME
FROM 
	tb_student A
where 
    A.STUDENT_NO in ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
order by 
	A.STUDENT_NO desc;

-- 5. 입학정원이 20 명 이상 30 명 이하인 학과들의 학과 이름과 계열을 출력하시오.
/*
    department_name     | category
    ------------------------------------
    국어국문학과	    | 인문사회
    사학과	            | 인문사회
    철학과	            | 인문사회
    무역학과	        | 인문사회
    회계학과	        | 인문사회
    호텔관광학과	    | 인문사회
    국제경영학과	    | 인문사회
    ....
    치의학과	        | 의학
    미술학과	        | 예체능
    산업디자인학과	    | 예체능
    체육학과	        | 예체능
    -------------------------------------
    
    24개의 행 조회
*/
SELECT 
	 A.department_name
	,A.category
FROM 
	tb_department A
where 
    (A.CAPACITY >= 20 and A.Capacity <= 30);



-- 6. 춘기술대학교는 총장을 제외하고 모든 교수들이 소속학과를 가지고 있다.
--    그럼 춘기술대학교 총장의 이름을 알아낼 수 있는 sql 문장을 작성하시오.
/*
    professor_name
    ---------------
    임해정
    ---------------
    
    1개의 행 조회
*/
SELECT 
	 A.PROFESSOR_NAME
FROM 
	tb_professor A
where 
    A.DEPARTMENT_NO is null;


-- 7. 혹시 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 한다.
--    어떠한 sql 문장을 사용하면 될 것인지 작성하시오.


SELECT 
	 A.STUDENT_NAME
FROM 
	tb_student A
where 
    A.COACH_PROFESSOR_NO is null;
    
-- 8. 수강신청을 하려고 한다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는
--    과목들은 어떤 과목인지 과목번호를 조회해보시오.
/*
    class_no
    ---------
    C0405500
    C0409000
    C3745400
    C0432500
    C3051900
    C3221500
    ---------
    
    6개의 행 조회
*/

SELECT 
	 A.CLASS_NO
FROM 
	tb_class A
where 
    A.PREATTENDING_CLASS_NO is not null;
    
-- 9. 춘 대학에는 어떤 계열(category)들이 있는지 조회해보시오.
/*
    CATEGORY
    --------
    공학
    예체능
    의학
    인문사회
    자연과학
    --------
    
    5개의 행 조회
*/
SELECT 
	  A.CATEGORY
FROM 
	tb_department A
group by 
	  A.CATEGORY;

-- 10. 19 학번 전주 거주자들의 모임을 만들려고 한다. 휴학한 사람들은 제외하고, 재학중인 학생들의 
--     학번, 이름, 주민번호를 출력하는 구문을 작성하시오.
/*
    student_no  | student_name  | student_ssn
    ----------------------------------------------
    A217005	    | 고수현	    | 991119-2122202
    A217214	    | 김승겸	    | 010815-3137815
    A211331	    | 김한준	    | 010914-3164004
    A211112	    | 박하나	    | 990530-2129861
    A217087	    | 안순필	    | 000109-4106936
    A211188	    | 유하미	    | 990514-2172832
    A213066	    | 윤영우	    | 011122-3128518
    A211197	    | 윤학준	    | 000911-3160919
    A211272	    | 정한메	    | 001005-3159253
    A211375	    | 최허현	    | 011102-3154425
    A217201	    | 황숭인	    | 000603-3110188
    ----------------------------------------------
    
    11개의 행 조회
*/

SELECT 
	  A.STUDENT_NO
	 ,A.STUDENT_NAME
	 ,A.STUDENT_SSN
FROM 
	tb_student A
where 
	SUBSTRING(A.STUDENT_NO,1,3) = 'A21'
and 
    A.ABSENCE_YN = 'N'
and 
	A.STUDENT_ADDRESS like '%전주%'
order by 
	A.STUDENT_NAME ASC;
