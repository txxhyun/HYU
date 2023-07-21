use sakila;
#문제 1-1
select customer_id,
	   count(amount) cnt_customer,
       avg(amount) avg_amount
from payment
where amount >= 2
group by 1;

#문제 1-2
select LEFT(first_name,1) 'char',
	   count(first_name) 'cnt'
from actor
group by left(first_name,1)
order by cnt DESC;

#문제 1-3
select last_name,
	   count(distinct first_name) unique_cnt,
	   count(last_name) cnt
from actor
group by last_name having unique_cnt <> cnt;


