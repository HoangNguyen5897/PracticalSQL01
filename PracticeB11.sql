-- 1/
select country.continent, floor(avg(city.population))
from country
join city
on country.code = city.countrycode
group by country.continent

-- 2/
select round(count(t.email_id) :: decimal  /count(DISTINCT e.email_id) :: decimal, 2) as confirm_rate
from emails e
left join texts t  
on e.email_id = t.email_id
and t.signup_action = 'Confirmed'

-- 3/
with snap_pct AS(
  select a.user_id, a.activity_type, a.time_spent, ab.age_bucket as age_bucket
  from activities a  
  join age_breakdown ab  
  on a.user_id = ab.user_id
  where a.activity_type in ('open', 'send')
)
SELECT 
  round(
    100*sum(case when activity_type = 'send' then time_spent else 0 end) :: decimal/
    (sum(case when activity_type = 'open' then time_spent else 0 end)+ 
      sum(case when activity_type = 'send' then time_spent else 0 end)), 2) :: decimal as send_perc,
      
  round(100*sum(case when activity_type = 'open' then time_spent else 0 end) :: decimal/
    (sum(case when activity_type = 'open' then time_spent else 0 end) + 
      sum(case when activity_type = 'send' then time_spent else 0 end)), 2) :: decimal as open_perc
from snap_pct
group by age_bucket

  
-- 4/
with 
unique_product as(
  select count(DISTINCT product_category) as product_cat_count
  from products
),
product as(
  select c.customer_id as customer_id, 
          c.product_id as product_id, 
          p.product_category as product_category
  from customer_contracts c  
  join products p  
  on c.product_id = p.product_id
)

select customer_id 
from product
group by customer_id
having count(distinct product_category) = (select * from unique_product)

-- 5/
select emp1.employee_id as employee_id, 
    emp1.name as name, 
    count(emp2.reports_to) as reports_count, 
    round(avg(emp2.age)) as average_age
from employees as emp1
join employees as emp2
on emp1.employee_id = emp2.reports_to
group by emp1.employee_id, emp1.name
order by emp1.employee_id

-- 6/
select p.product_name as product_name,
        sum(o.unit) as unit
from orders o
left join products p
on o.product_id = p.product_id
where extract(month from o.order_date) = 2 
and extract(year from o.order_date) = 2020
group by p.product_name
having sum(o.unit) >= 100
order by sum(o.unit) desc

-- 7/
select p1.page_id as page_id
from pages p1
left join page_likes p2
on p1.page_id = p2.page_id
where p2 is null
order by p1.page_id 

