-- Q1
select count(distinct t1.company_id) as duplicate_companies
from job_listings t1
join job_listings t2
on t1.company_id = t2.company_id and
    t1.title = t2.title and 
    t1.description = t2.description
where t1.job_id != t2.job_id

--Q2
WITH appliances AS (SELECT category, product, SUM(spend) as total_spend FROM product_spend
WHERE transaction_date BETWEEN '01/01/2022' AND '01/01/2023'
AND category = 'appliance'
GROUP BY category, product
ORDER BY category, total_spend DESC
LIMIT 2),

electronics AS (SELECT category, product, SUM(spend) as total_spend FROM product_spend
WHERE transaction_date BETWEEN '01/01/2022' AND '01/01/2023'
AND category = 'electronics'
GROUP BY category, product
ORDER BY category, total_spend DESC
LIMIT 2)

SELECT * FROM appliances
UNION
SELECT * FROM electronics
ORDER BY category, total_spend DESC

--Q3
with count_table AS(
  select policy_holder_id
  from callers
  group by policy_holder_id
  having count(case_id) >=3
)

select count(*)
from count_table

-- Q4
SELECT page_id
FROM pages
WHERE page_id NOT IN (
  SELECT page_id
  FROM page_likes
  WHERE page_id IS NOT NULL
);

--Q5
with july_table as 
(
  select user_id as id, extract(month from event_date) as month_j
  from user_actions
  where (extract(month from event_date) =6
  and extract(year from event_date) = 2022)
  and event_type in('sign-in', 'like', 'comment')
  group by user_id, extract(month from event_date)
)

select extract(month from event_date), count(distinct user_id)
from user_actions
where extract(month from event_date) = (select month_j +1 from july_table limit 1)
and user_id in (select id from july_table)
group by extract(month from event_date)

--Q6
WITH t1 AS (
    SELECT 
        to_char(trans_date, 'yyyy-mm') as month,
        country,
        COUNT(id) AS trans_count,
        CASE
            WHEN state = 'approved'
                THEN COUNT(id)
            ELSE 0 
        END AS approved_count,
        SUM(amount) AS trans_total_amount,
        CASE
            WHEN state = 'approved'
                THEN SUM(amount)
            ELSE 0
        END AS approved_total_amount
    FROM transactions
    GROUP BY to_char(trans_date, 'yyyy-mm'), country, state
    ORDER BY month
)
SELECT
    month,
    country,
    SUM(trans_count) AS trans_count,
    SUM(approved_count) AS approved_count,
    SUM(trans_total_amount) AS trans_total_amount,
    SUM(approved_total_amount) AS approved_total_amount
FROM t1
GROUP BY month, country;

--Q7
with first_yr
as(
    select product_id, min(year) as first_year
    from sales s1
    group by product_id
)

select s1.product_id, s1.first_year, s2.quantity, s2.price
from sales s2
join first_yr s1
on s2.product_id = s1.product_id
and s2.year = s1.first_year

--Q8
select customer_id
from customer
group by customer_id
having count(distinct product_key) >= (select count(distinct product_key) from product)

--Q9
SELECT employee_id
FROM Employees
WHERE salary < 30000 AND manager_id NOT IN (SELECT employee_id FROM Employees)
ORDER BY employee_id

--Q10
with single_dep
as(
    select employee_id
    from employee
    group by employee_id
    having count(department_id) =1
)
select employee_id, department_id 
from employee
where employee_id in (select * from single_dep) 
or primary_flag = 'Y'

--Q11
with user_result 
as (
    select u.name as name, count(mr.rating)
    from movierating mr
    join users u
    on u.user_id = mr.user_id
    group by u.name, u.user_id
    order by count(mr.rating) desc, u.name
    limit 1
),

movie_result
as(
    select m.title as title, avg(mr.rating)
    from movies m
    right join movierating mr
    on m.movie_id = mr.movie_id
    where (extract(month from created_at) = 2) and (extract(year from created_at) = 2020)
    group by m.title, m.movie_id
    order by avg(mr.rating) desc, m.title
    limit 1
)
  
select name as results
from user_result
union all
select title
from movie_result

--Q12
with requester
as(
    select requester_id, count(accepter_id)
    from RequestAccepted
    group by requester_id
    order by count(accepter_id) desc
),

accepter
as(
    select accepter_id, count(requester_id)
    from requestaccepted
    group by accepter_id
    order by count(requester_id) desc
),

total
as(
    select * from requester
    union all
    select * from accepter
)

select requester_id as id, sum(count) as num
from total
group by requester_id
order by sum(count) desc
limit 1







