-- 제품 상세 페이지뷰, 스크롤을 거쳐 구매 버튼 클릭까지의 유입 채널별 전환율은? 

WITH pv AS (  -- 1. 제품 상세 페이지뷰를 본 세션
  SELECT user_id
    , session_id
    , event_time AS pv_at
    , source
    , medium
  FROM funnel
  WHERE page_title = '꽃무늬 여성 원피스'
    AND event_name = 'page_view'
)
, scroll AS (  -- 2. 제품 상세 페이지에서 스크롤을 한 세션
  SELECT user_id
    , session_id
    , event_time AS scroll_at
  FROM funnel
  WHERE page_title = '꽃무늬 여성 원피스'
    AND event_name = 'scroll'
)
, click AS (  -- 3. 제품 상세 페이지에서 클릭을 한 세션
  SELECT user_id
    , session_id
    , event_time AS click_at
  FROM funnel
  WHERE page_title = '꽃무늬 여성 원피스'
    AND event_name = 'click'
)

SELECT source
  , medium
  -- 제품 상세 페이지를 본 세션 수
  , COUNT(DISTINCT p.user_id, p.session_id) AS pv 
  -- 제품 상세 페이지를 본 후 스크롤을 내린 세션 수
  , COUNT(DISTINCT s.user_id, s.session_id) AS scroll 
  -- 제품 상세 페이지를 본 후 스크롤을 내려 구매 버튼을 클릭한 세션 수
  , COUNT(DISTINCT c.user_id, c.session_id) AS click 
  -- 제품 상세 페이지를 본 세션 중 스크롤을 내린 세션의 비율
  , COUNT(DISTINCT s.user_id, s.session_id) / COUNT(DISTINCT p.user_id, p.session_id) AS pv_scroll_rate
  -- 제품 상세 페이지에서 스크롤을 내린 세션 중 구매 버튼까지 클릭한 세션의 비율
  , COUNT(DISTINCT c.user_id, c.session_id) / COUNT(DISTINCT s.user_id, s.session_id) AS scroll_click_rate
  -- 제품 상세 페이지를 본 세션 중 스크롤을 내리고 구매 버튼까지 클릭한 세션의 비율
  , COUNT(DISTINCT c.user_id, c.session_id) / COUNT(DISTINCT p.user_id, p.session_id) AS pv_click_rate
FROM pv AS p 
  LEFT JOIN scroll AS s ON p.user_id = s.user_id
    AND p.session_id = s.session_id
    AND p.pv_at <= s.scroll_at
  LEFT JOIN click AS c ON s.user_id = c.user_id
    AND s.session_id = c.session_id
    AND s.scroll_at <= c.click_at
GROUP BY source
	, medium;
