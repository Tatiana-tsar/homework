---  �������� ������ � 4


-- https://www.hackerrank.com/challenges/asian-population/problem
-- https://leetcode.com/



--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- ������������ �����: ������� view (pages_all_products), � ������� ����� ������������ 
--�������� ���� ��������� (�� ����� ���� ��������� �� ����� ��������). 



--task2 (lesson5)
-- ������������ �����: ������� view (distribution_by_type), � ������ �������� ����� ���������� ����������� ���� ������� �� ���� ����������. �����: �������������,
--�����: �������������, ��� �������� (printer,pc or laptop) , ���������� ����������� ���������� ������� ������� ���� 
--� ���������� ���� ������� �������������



--task3 (lesson5)
-- ������������ �����: ������� �� ���� ����������� view ������ - �������� ��������� pie? RTFM 





--task4 (lesson5)
-- �������: ������� ����� ������� ships (ships_two_words), �� � �������� ������� ������ �������� �� ���� ����

--task5 (lesson5)
-- �������: ������� ������ ��������, � ������� class ����������� (IS NULL) � �������� ���������� � ����� "S"

--task6 (lesson5)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'C' � ��� ����� ������� (����� ������� �������). ������� model


--task1 (lesson5)
-- ������������ �����: ������� view (pages_all_products), � ������� ����� ������������ 
--�������� ���� ��������� (�� ����� ���� ��������� �� ����� ��������). 

create view  pages_all_products as
SELECT model,   
      CASE WHEN num % 2 = 0 THEN num/2 
           ELSE num/2 + 1
      END AS kol_na_page, 
      CASE WHEN vsego % 2 = 0 THEN vsego/2 
           ELSE vsego/2 + 1 
      END AS kol_pages
FROM (   
      SELECT *, ROW_NUMBER() OVER(ORDER BY model ) AS num,  COUNT(*) OVER() AS vsego
      from 
      (
      SELECT model from pc
        union all
      SELECT model FROM Printer
      union all
      SELECT model from laptop 
      ) X
      )d;
     
select * from pages_all_products;
     

--task2 (lesson5)
-- ������������ �����: ������� view (distribution_by_type), � ������ �������� ����� ���������� ����������� ���� ������� �� ���� ����������. �����: �������������,
--�����: �������������, ��� �������� (printer,pc or laptop) , ���������� ����������� ���������� ������� ������� ���� 
--� ���������� ���� ������� �������������


create view distribution_by_type as 


SELECT maker, type, cast((100.0*count_type/count_maker) AS NUMERIC(5,2)) 
from 
(
SELECT distinct maker, type,count(*) OVER(partition by type, maker) count_type, 
count(*) OVER(partition by maker) count_maker  
from product
)p;




--task4 (lesson5)
-- �������: ������� ����� ������� ships (ships_two_words), �� � �������� ������� ������ �������� �� ���� ����

create table ships_two_words as
select name from ships where name like '% %';

select *from ships_two_words;



--task5 (lesson5)
-- �������: ������� ������ ��������, � ������� class ����������� (IS NULL) � �������� ���������� � ����� "S"

select ship from outcomes o where ship not in (select name from ships) 
and
ship not in (select class from classes)
and ship like 'S%';


--task6 (lesson5)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� 
--�� ��������� ������������� = 'C' � ��� ����� ������� (����� ������� �������). ������� model


select p. model from product p, printer p2 where p.model= p2.model and maker='A'
and price > (select avg(price) from product p, printer p2 where p.model= p2.model and maker='C');

select * from product



(select p.model, row_number() over (order by price desc)
from  product p, printer p2 where p.model= p2.model and maker='A'
and price > (select avg(price) from product p, printer p2 where p.model= p2.model and maker='C')
)
union all
(select model, 1 from
(select model, row_number() over(order by price desc) as rn
 from printer p
 )y
where rn < 4
);


