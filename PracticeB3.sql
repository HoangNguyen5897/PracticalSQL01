 -- 1/ Revising the Select Query II
select name
from city
where CountryCode = "USA" and population > 120000

-- 2/ Japanese Cities' Attributes
select *
from city
where CountryCode = "JPN"

--3/ Weather Observation Station 1
select city, state
from station

--4/ Weather Observation Station 6
select distinct city
from station
where left(city,1) in ('a', 'e', 'i', 'o', 'u')

--5/ Weather Observation Station 7
select distinct city
from station
where right(city,1) in ('a', 'e', 'i', 'o', 'u')

--6/ Weather Observation Station 9
select distinct city
from station
where left(city,1) not in ('a', 'e', 'i', 'o', 'u')

--7/ Employee Names
select name
from employee
order by name

--8/ Employee Salaries
select name
from employee
where salary > 2000 and months < 10
order by employee_id

--9/ 
select product_id
from products
where low_fats like "y" and recyclable like "y"

--10/
select name
from customer
where referee_id != 2 or referee_id is NULL

--11/
select name, population, area
from world
where area >= 3000000 or population >= 25000000

--12/
select distinct author_id as id
from views
where author_id = viewer_id
order by author_id 

--13/
SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date is NULL

--14/
select * from lyft_drivers
where yearly_salary not between 30000 and 70000

--15/
select uber_advertising.advertising_channel
from uber_advertising
where year = 2019 and money_spent > 100000






