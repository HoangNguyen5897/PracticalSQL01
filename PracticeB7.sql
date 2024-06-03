--1/
select name
from students
where marks >75
order by right(name, 3), id

  
--2/
select user_id, concat(upper(left(name, 1)), lower(substring(name, 2))) as name
from users
order by user_id

  
--3/
SELECT manufacturer, concat('$',round(sum(total_sales) /1000000), ' million') as sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY sum(total_sales) DESC, manufacturer

  
--4/
  SELECT extract(month from submit_date) as mth,
        product_id as product,
        round(avg(stars), 2) as avg_stars
FROM reviews
GROUP BY extract(month from submit_date), product_id
ORDER BY extract(month from submit_date), product_id

  
--5/
SELECT sender_id, count(message_id) as message_count 
FROM messages
WHERE EXTRACT(month from sent_date) = 8 and EXTRACT(year from sent_date) = 2022
GROUP BY sender_id
ORDER BY count(message_id) DESC
LIMIT 2


--6/
select tweet_id
from tweets
where length(content) > 15


--7/
select activity_date as day, 
        count(distinct user_id) as active_users
from activity
where activity_date between (date '2019-07-27' - integer '29') and '2019-07-27'
group by activity_date

  
--8/
select count(distinct id) as number_empl
from employees
where (extract(month from joining_date) between 1 and 7) and
        extract(year from joining_date) = 2022

  
--9/
select position(lower('a') in first_name) as pos
from worker
where first_name = 'Amitah'


--10/
select title, substring(title, length(winery)+2, 4) as year
from winemag_p2
where country = 'Macedonia'


















