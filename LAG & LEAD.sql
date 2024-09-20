SELECT id
	, date
	, salary
    
	-- 1) 2칸 뒤에 있는 값이 null이면 0으로 대체
	, LAG(salary, 2, 0) OVER(ORDER BY temperature) AS 'lag'
	
	-- 2) 2칸 앞에 있는 값이 null이면 0으로 대체
	, LEAD(salary, 2, 0) OVER(ORDER BY temperature) AS 'lead'
FROM sample;
