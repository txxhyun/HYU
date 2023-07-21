use classicmodels;
#문제 2-1
select A.ordernumber,
	   B.customername
from orders A
	LEFT JOIN customers B
    ON A.customernumber = B.customernumber
order by 1;

#문제 2-2
select mid(A.orderDate,6,2) 'month',
	   sum(priceeach * quantityOrdered) 'total'
from orders as A
	LEFT JOIN orderdetails as B
    on A.ordernumber = B.ordernumber
group by 1
order by 1;

#문제 2-3
select DISTINCT A.customerNumber,
	   A.customerName,
       case when B.orderNumber IS NULL then '0'
       else '1' 
       end as is_order
from customers A
	 left join orders B
     on A.customerNumber = B.customerNumber;