-- 1. INSERT

-- 1.1 테이블 전체에 데이터 추가
INSERT INTO table_name
	VALUES ('id1', 'Sally', 50000, '1997-12-31'); -- 칼럼 순서대로 입력
    
-- 1.2 값을 지정할 열 지정하기
INSERT INTO table_name (id, salary)
	VALUES ('id4', 15000);
    
    
    
-- 2. UPDATE

-- 2.1 칼럼 전체에 데이터 업데이트
UPDATE table_name
	SET salary = salary + 5000;

-- 2.2 지정 행만 업데이트
UPDATE table_name
	SET salary = salary + 5000
	WHERE Id = 'id4';
    
    
    
-- 3. DELETE

-- 3.1 테이블 전체에 데이터 삭제
DELETE FROM table_name;

-- 3.2 WHERE 조건에 일치하는 행 삭제
DELETE FROM table_name
	WHERE Id = 'id4';