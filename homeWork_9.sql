---Домашняя 9


--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
SELECT grade, marks, 
CASE WHEN grade<8 THEN name= NULL 
ELSE name 
END AS kol_pages 
from (SELECT name, grade, marks from  Students join Grades on marks between min_mark and max_mark)h;


--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem

SELECT *, CASE WHEN rt<max(rt) THEN name=NULL else name END AS kol_pas 
FROM (select name, count(*) OVER(PARTITION BY OCCUPATION) as rt from OCCUPATIONS)l;


SELECT *, CASE WHEN max(rt)-rt>0 THEN name=NULL else name END AS kol_pas FROM (select name, DENSE_RANK() 
OVER(PARTITION BY OCCUPATION ORDER BY name) as rw, count(*) OVER(PARTITION BY OCCUPATION) as rt from OCCUPATIONS)l;


ERROR 1140 (42000) at line 3: In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'l.name'; this is incompatible with sql_mode=only_full_group_by

--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem
SELECT city FROM   station WHERE  city RLIKE '^[QWRTPSDFGHJKLZXCVBNM]';

--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem


SELECT DISTINCT city FROM   station WHERE  city RLIKE '[qwrtypsdfghjklzxcvbnm]$';


--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem

SELECT DISTINCT city FROM   station WHERE  city RLIKE '^[QWRTPSDFGHJKLZXCVBNM].*[QWRTPSDFGHJKLZXCVBNM]$' 
or city RLIKE '[qwrtypsdfghjklzxcvbnm].*[qwrtypsdfghjklzxcvbnm]$';


--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem
SELECT DISTINCT city FROM   station WHERE  city RLIKE '^[QWRTPSDFGHJKLZXCVBNM].*[QWRTPSDFGHJKLZXCVBNM]$' 
and city RLIKE '[qwrtypsdfghjklzxcvbnm].*[qwrtypsdfghjklzxcvbnm]$';


--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem
select name from Employee where salary > 2000 and months<10;

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
SELECT grade, marks, 
CASE WHEN grade<8 THEN name= NULL 
ELSE name 
END AS kol_pages 
from (SELECT name, grade, marks from  Students join Grades on marks between min_mark and max_mark)h;

