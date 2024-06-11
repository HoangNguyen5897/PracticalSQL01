--1 
SELECT 
  SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views, 
  SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END) AS mobile_views 
FROM viewership;

--2
select x, y, z,
    case
        when x+y>z and x+z>y and y+z>x then 'Yes'
        else 'No'
    end triangle
from triangle

--3 
SELECT 
    round(sum(100.0 * case when call_category = 'n/a' or call_category is null then 1 else 0 end)/
            count(*), 1) as call
FROM callers

--4 
select name
from customer
where referee_id != 2 or referee_id is null

--5
select 
    survived,
    sum(case when pclass = 1 then 1 else 0 end) as first_class,
    sum(case when pclass = 2 then 1 else 0 end) as second_class,
    sum(case when pclass = 3 then 1 else 0 end) as third_class
from titanic
group by survived
