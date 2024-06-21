--Q1
select extract(year from transaction_date) as year, product_id, spend as curr_year_spend,
        lag(spend) over(partition by product_id order by extract(year from transaction_date)) as prev_year_spend,
        round(100*(spend - (lag(spend) over(partition by product_id order by extract(year from transaction_date)))) / 
        lag(spend) over(partition by product_id order by extract(year from transaction_date)), 2) as yoy_rate
from user_transactions

--Q2
select distinct card_name,
        first_value(issued_amount) over(partition by card_name order by issue_year, issue_month) as issued_amount
from monthly_cards_issued
order by first_value(issued_amount) over(partition by card_name order by issue_year, issue_month) desc

--Q3
with row_table as (
  select user_id, spend, transaction_date, 
        row_number() over(partition by user_id order by transaction_date) as row_no
  from transactions
)

select user_id, spend, transaction_date
from row_table
where row_no = 3

--Q4
with max_date as (
  select user_id, transaction_date,
        max(transaction_date) over(PARTITION BY user_id) as max_trans_date
  from user_transactions
)

select transaction_date, user_id, count(user_id)
from max_date
where transaction_date = max_trans_date
group by user_id, transaction_date
order by transaction_date, user_id 

--Q5
 select user_id, tweet_date,
        round(avg(tweet_count) over(partition by user_id order by tweet_date
                                    rows between 2 preceding and current row), 2) as rolling_avg_3d
 from tweets

--Q6
with t1 as (
  select *, 
        transaction_timestamp - lag(transaction_timestamp) 
          over(PARTITION BY merchant_id, credit_card_id, amount order by transaction_timestamp) as time
  from transactions
)

select count(*)
from t1
where time <= '10 minutes'


--Q7
with rank_cat as (
  select category, product, sum(spend) as total_spend,
          rank() over(PARTITION BY category order by sum(spend) desc) as ranking
  from product_spend
  where extract(year from transaction_date) = 2022
  group by category, product
)

select category, product, total_spend
from rank_cat
where ranking <= 2

--Q8
with t1 as (
  select a.artist_name,
        dense_rank() over(order by count(s.song_id) desc) as artist_rank
  from artists a   
  join songs s 
  on a.artist_id = s.artist_id
  join global_song_rank r  
  on s.song_id = r.song_id
  where r.rank <=10 
  group by a.artist_name
)

select * 
from t1
where artist_rank <= 5

