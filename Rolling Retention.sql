-- Rolling Retention : 기준일을 포함하여 그 이후에 한 번이라도 재방문한 유저의 비율

-- Q. 첫 주문 한 달 이후 2~11개월 뒤에도 이탈하지 않은 고객의 수
WITH customer_proccessing AS (
  SELECT customer_id
    , DATE_FORMAT(first_order_date, '%Y-%m-01') AS first_order_month
    , DATE_FORMAT(last_order_date, '%Y-%m-01') AS last_order_month 
  FROM customer
)
SELECT first_order_month
  , COUNT(DISTINCT customer_id) AS month0
  , COUNT(DISTINCT IF(DATE_ADD(first_order_month, INTERVAL 1 MONTH) <= last_order_month, customer_id, NULL)) AS month1
  , COUNT(DISTINCT IF(DATE_ADD(first_order_month, INTERVAL 2 MONTH) <= last_order_month, customer_id, NULL)) AS month2
  , COUNT(DISTINCT IF(DATE_ADD(first_order_month, INTERVAL 3 MONTH) <= last_order_month, customer_id, NULL)) AS month3
  , COUNT(DISTINCT IF(DATE_ADD(first_order_month, INTERVAL 4 MONTH) <= last_order_month, customer_id, NULL)) AS month4
  , COUNT(DISTINCT IF(DATE_ADD(first_order_month, INTERVAL 5 MONTH) <= last_order_month, customer_id, NULL)) AS month5
  , COUNT(DISTINCT IF(DATE_ADD(first_order_month, INTERVAL 6 MONTH) <= last_order_month, customer_id, NULL)) AS month6
  , COUNT(DISTINCT IF(DATE_ADD(first_order_month, INTERVAL 7 MONTH) <= last_order_month, customer_id, NULL)) AS month7
  , COUNT(DISTINCT IF(DATE_ADD(first_order_month, INTERVAL 8 MONTH) <= last_order_month, customer_id, NULL)) AS month8
  , COUNT(DISTINCT IF(DATE_ADD(first_order_month, INTERVAL 9 MONTH) <= last_order_month, customer_id, NULL)) AS month9
  , COUNT(DISTINCT IF(DATE_ADD(first_order_month, INTERVAL 10 MONTH) <= last_order_month, customer_id, NULL)) AS month10
  , COUNT(DISTINCT IF(DATE_ADD(first_order_month, INTERVAL 11 MONTH) <= last_order_month, customer_id, NULL)) AS month11
FROM customer_proccessing
GROUP BY first_order_month;