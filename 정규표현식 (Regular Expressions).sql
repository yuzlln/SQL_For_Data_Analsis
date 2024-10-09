-- 1. Caret (^) : 문자열의 시작을 나타냄
SELECT name
FROM user_table
WHERE name REGEXP '^[aeiou].*'; -- 첫 글자가 영어 모음



-- 2. Dollar ($) : 문자열의 끝을 나타냄
SELECT name
FROM user_table
WHERE name REGEXP '.*[aeiou]$'; -- 마지막 글자가 영어 모음



-- 3. Caret & Dollar
SELECT name
FROM user_table
WHERE name REGEXP '^[aeiou].*[aeiou]$'; -- 첫 글자와 마지막 글자가 영어 모음



-- 4. 부정형
SELECT name
FROM user_table
WHERE name NOT REGEXP '^[aeiou].*'; -- 첫 글자가 영어 모음이 아님



-- 5. 특정 단어 포함 여부
SELECT name
FROM user_table
WHERE name REGEXP 'a|e|i|o|u'; -- 영어 모음이 포함