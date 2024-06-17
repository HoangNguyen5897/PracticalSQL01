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
