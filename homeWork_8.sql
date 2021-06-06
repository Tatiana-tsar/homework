---- Домашняя 8

--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/
select Department, Employee, Salary from
(
select d.name as Department, e.name as Employee, Salary, Dense_rank()
over(partition by e.DepartmentId order by Salary DESC) as kol
from Employee e join Department d on e.DepartmentId=d.Id 
) y
where kol<=3

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17
SELECT member_name,status,SUM(amount*unit_price) AS costs  FROM FamilyMembers,Payments WHERE 
Payments.family_member =FamilyMembers.member_id AND YEAR(date)='2005'
GROUP BY member_name,status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13

SELECT NAME FROM Passenger
GROUP BY name
HAVING count(NAME) >=2

SELECT DISTINCT  name from
(SELECT name, count(*) over(PARTITION BY name) as rn FROM Passenger )L 
WHERE rn>=2


--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

SELECT count(first_name) as count from Student where first_name like 'Anna'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35

select count(id) as count from Schedule WHERE date='2019-09-02'

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
SELECT count(first_name) as count from Student where first_name like 'Anna'

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32 &77
select FLOOR(avg((YEAR(CURDATE())-YEAR(birthday)))) AS age from FamilyMembers
group by status


--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27

select good_type_name, sum(unit_price*amount) as costs FROM  Payments 
join Goods on  Payments.good = Goods.good_id
join GoodTypes on Goods.type= GoodTypes.good_type_id 
where 
YEAR(Payments.date)='2005' 
GROUP BY good_type_name

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37  ?????
SELECT MIN(YEAR(CURDATE())-YEAR(birthday)) AS year from Student  

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44
SELECT MAX(YEAR(CURDATE())-YEAR(birthday))  AS date from Class c JOIN  Student_in_class st ON  (c.id=st.class)
JOIN  Student s ON  st.student=s.id WHERE c.name like '10%'  


--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20
select status, member_name, (unit_price*amount) as costs FROM 
FamilyMembers join Payments on FamilyMembers.member_id=Payments.family_member 
join Goods on  Payments.good = Goods.good_id
join GoodTypes on Goods.type= GoodTypes.good_type_id 
where 
good_type_name='entertainment'


--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55 &&&&

select Trip.company, COUNT(Trip.company)
from Company join Trip on Company.id=Trip.company
GROUP BY Trip.company

SELECT MIN(kol) as min from 
(
select  COUNT(Trip.company) as kol
from Company join Trip on Company.id=Trip.company
GROUP BY Trip.company
)k 



SELECT *,
   CASE WHEN kol=min(kol) THEN continue
   END AS kol_pas
FROM 
( select *, count(*) over(partition by Company.id ) as kol
from Company join Trip on Company.id=Trip.company 
)y


--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45




--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43 &&&&
SELECT DISTINCT last_name from Schedule  join  Subject on
Schedule.subject = Subject. Id 
join Teacher on Schedule.teacher=Teacher.id
WHERE 
Subject.name='Physical Culture'
ORDER BY last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63


select CONCAT(last_name,'.',SUBSTR(first_name,1,1),'.',SUBSTR(middle_name,1,1)) AS name from Student
ORDER BY last_name



