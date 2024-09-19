-- 문제 1) 각 영수 금액이 요일 별 매출액에서 차지하는 비율을 계산
-- 비율은 반올림하여 소수점 둘째자리까지만 & 영수 금액이 높은 것부터 출력
SELECT t1.day
  , t1.total_bill
  , (SELECT ROUND(100 * t1.total_bill / SUM(t2.total_bill), 2)
     FROM tips AS t2
     WHERE t1.day = t2.day
     ) AS pct
FROM tips AS t1
ORDER BY t1.total_bill DESC;



-- 문제 2) 각 영수 금액이 이 레스토랑의 전체 매출액에서 차지하는 비율을 계산
-- 비율은 반올림하여 소수점 둘째자리까지만 & 영수 금액이 높은 것부터 출력

-- 방법 (1) SELECT절 서브쿼리
SELECT t1.day
  , t1.total_bill
  , (SELECT ROUND(100 * t1.total_bill / SUM(t2.total_bill), 2)
     FROM tips AS t2
     ) AS pct
FROM tips AS t1
ORDER BY t1.total_bill DESC;


-- 방법 (2) Window Function
SELECT day
  , total_bill
  , ROUND(100 * total_bill / SUM(total_bill) OVER(), 2) AS pct
FROM tips
ORDER BY total_bill DESC;