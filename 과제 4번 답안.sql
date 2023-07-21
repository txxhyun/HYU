use sakila ;
# 문제 4-1번
select C.first_name, C.last_name, count(A.rental_rate) cnt
from film A
left join film_actor B
on A.film_id = B.film_id
left join actor C
on B.actor_id = C.actor_id
where A.rental_rate >= 4
group by 1,2
order by 3 desc ;

# 문제 4-2번
select B.category_id, C.name, count(B.category_id) cnt_films
from film A
left join film_category B
on A.film_id = B.film_id
left join category C
on B.category_id = C.category_id
where A.length >= 100
group by 1
order by 3 desc;

# 문제 4-3번
select A.film_id, A.title, sum(A.rental_rate) total
from film A 
left join inventory B
on A.film_id = B.film_id
left join rental C
on B.inventory_id = C.inventory_id
left join payment D
on C.rental_id = D.rental_id
group by 1,2
order by 3 desc
limit 5;

