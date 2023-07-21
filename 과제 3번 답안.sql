use 고객DB;
#3-1번 문제
select distinct 제품명 `name`, 단가 pirce
from 주문
left join 제품
on 주문.주문제품 = 제품.제품아이디
where 주문.주문제품 in (select 주문제품
					 from 주문
                     group by 주문제품 having count(주문제품) >= 2);
                     
select 제품명, 단가
from 제품
where 제품아이디 in 
(select 주문제품
from 주문
group by 주문제품 having count(주문제품) >= 2 );

#3-2번 문제
select 제품아이디 product_id, 제품명 name, sum(수량) total_cnt, count(distinct 고객이름) customer_cnt
from 고객 A
	left join 주문 B
	on A.고객아이디 = B.주문고객
	left join 제품 C
	on B.주문제품 = C.제품아이디
where 등급 in ('gold', 'vip')
group by 1
order by 3 desc;
    
#3-3번 문제
select 고객아이디 customer_id, 등급 `level`, sum(수량*단가) total
from 고객 A
	left join 주문 B
	on A.고객아이디 = B.주문고객
	left join 제품 C
	on B.주문제품 = C.제품아이디
group by 고객아이디
order by 3 desc limit 5;

select 제품명, 단가
from 제품
where 제품아이디 in 
(select 주문제품
from 주문
group by 주문제품 having count(주문제품) >= 2 );