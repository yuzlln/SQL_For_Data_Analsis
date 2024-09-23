DROP TABLE IF EXISTS purchase;

CREATE TABLE purchase(
    id           integer
  , price        integer
  , category     varchar(255)
);

INSERT INTO purchase
VALUES
    ( 1, 37300,  'bag')
  , (2, 97300,  'jacket')
  , ( 3, 114600, 'radio')
  , (4, 33300,  'jacket')
  , (5, 32800,  'bag')
  , (6,  26000,  'radio')
  , (7, 57300,  'jacket')
  , (8, 28600,  'radio')
 ;
 
 
 -- 데이터 확인
 SELECT *
 FROM purchase;
 


-- Window Function을 사용한 department별 누적합
SELECT id
	, category
	, price
	, SUM(price) OVER(PARTITION BY category ORDER BY id) AS cum
FROM purchase
ORDER BY category
	, id;



-- 방법 1) Self Join 
SELECT p1.id
	, p1.category
    , p1.price
    , SUM(p2.price) AS cum
FROM purchase AS p1
	INNER JOIN purchase AS p2 ON p1.category = p2.category
		AND p1.id >= p2.id -- p1 기준으로 p1이전의 id 데이터가 모두 결합
GROUP BY p1.id
	, p1.category
    , p1.price
ORDER BY p1.category
	, p1.id;



-- 방법 2) SELECT 서브쿼리
SELECT p1.id
	, p1.category
    , p1.price
    , (SELECT SUM(p2.price)
       FROM purchase AS p2
	   WHERE p1.category = p2.category
	       AND p1.id >= p2.id
	   ) AS cum
FROM purchase AS p1
ORDER BY p1.category
	, p1.id;