-- 1/
select distinct city
from station
where mod(id,2)=0

--2/
select count(city) - count(distinct city)
from station

--3/
select ceil(avg(salary) - avg(replace(salary, '0', '')))
from employees

--4/
SELECT round(cast(sum(item_count*order_occurrences)/sum(order_occurrences) as decimal ), 1)
FROM items_per_order;

--5/
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;

--6/
select user_id, date(max(post_date))- date(min(post_date)) as diff
from posts
where post_date BETWEEN '01-01-2021' and '01-01-2022'
group by user_id
having count(post_id) >=2

--7
select card_name, max(issued_amount) - min(issued_amount) as diff
from monthly_cards_issued
group by card_name
order by max(issued_amount) - min(issued_amount) DESC

--8/
select manufacturer, 
        count(product_id) as drug_count,
        sum(cogs) - sum(total_sales) as total_loss
from pharmacy_sales
where cogs > total_sales
group by manufacturer
order by total_loss DESC

--9/
select *
from cinema
where mod(id,2) != 0 and 
        description not like 'boring'
order by rating desc

--10/
select teacher_id, count(distinct subject_id) as cnt
from teacher
group by teacher_id

--11/
select user_id, count(follower_id) as followers_count
from followers
group by user_id
order by user_id

--12/
select class
from courses
group by class
having count(student) >=5








