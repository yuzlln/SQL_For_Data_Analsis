-- Q1. 2020년 1월 가입자가 몇명인지 계산하는 쿼리문을 작성해주세요
SELECT COUNT(DISTINCT user_id) AS user_count
FROM users
WHERE DATE_FORMAT(registered_date, '%Y-%m') = '2020-01';



-- Q2. 유저별로 ‘첫 채팅을 시작한 시간’과 ‘첫 채팅을 건 아티클의 아이디’를 뽑아주세요
SELECT user_id
	, article_id
	, chat_time AS first_chat_time
FROM chat
WHERE (user_id, chat_time) IN (SELECT user_id
								, MIN(chat_time)
								FROM chat
								GROUP BY user_id
								);



-- Q3. 2020년 12월 1일에 가입한 유저의 3일 리텐션을 구해주세요
WITH december AS ( -- 2020년 12월 1일에 가입한 유저
	SELECT *
	FROM users
	WHERE register_date = '2020-12-01'
)

SELECT COUNT(DISTINCT v.user_id) / COUNT(DISTINCT d.user_id) AS retention_3day
FROM december AS d
	LEFT JOIN visitors AS v ON d.user_id = v.user_id
		AND DATE_ADD(d.register_date, INTERVAL 3 DAY) = v.visit_date;