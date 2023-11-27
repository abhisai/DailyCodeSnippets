alter table  dbo.employee add dob date;
update employee set dob = dateadd(year,-1*emp_age,getdate())

select * from employee;

1- write a query to print emp name , their manager name and diffrence in their age (in days) for employees whose year of birth is 
before their managers year of birth

select e.emp_name , m.emp_name , datediff(day,e.dob,m.dob)
from employee e join employee m
on e.manager_id = m.emp_id 
where 
datepart(year,e.dob) < datepart(year,m.dob)

2- write a query to find subcategories who never had any return orders in the month of november (irrespective of years)

select * from orders;
select * from returns;

select sub_category 
from orders o
left join returns r on o.order_id=r.order_id
where DATEPART(month,order_date)=11
group by sub_category
having count(r.order_id)=0;




3- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
write a query to find order ids where there is only 1 product bought by the customer.


select order_id , count(order_id) 
from orders
group by order_id 
having count(order_id) = 1

4- write a query to print manager names along with the comma separated list(order by emp salary) of all employees directly reporting to him.

select * from employee
select m.emp_name , STRING_AGG(e.emp_name,',') 
from employee e join employee m
on e.manager_id = m.emp_id
group by m.emp_name

select e2.emp_name as manager_name , string_agg(e1.emp_name,',') as emp_list
from employee e1
inner join employee e2 on e1.manager_id=e2.emp_id
group by e2.emp_name


5- write a query to get number of business days between order_date and ship_date (exclude weekends). 
Assume that all order date and ship date are on weekdays only

select order_id,order_date,ship_date ,
datediff(day,order_date,ship_date) -2*datediff(week,order_date,ship_date) as no_of_business_day
from orders






6- write a query to print 3 columns : category, total_sales and (total sales of returned orders)

select * from orders
select * from returns 

select o.category ,
(select sum(sales) as total_sales from orders group by category having category = o.category) as total_sales, 
sum(sales) as total_returned_sales 
from orders o join returns r 
on o.order_id = r.order_id
group by category

select o.category,sum(o.sales) as total_sales
,sum(case when r.order_id is not null then sales end) as return_orders_sales
from orders o
left join returns r on o.order_id=r.order_id
group by category

7- write a query to print below 3 columns
category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)

select * from orders;

select category ,
SUM(case when datepart(year,order_date) = 2019 then sales else 0 end ) as total_sales_2019,
SUM(case when datepart(year,order_date) = 2020 then sales else 0 end ) as total_sales_2020
from orders 
group by category


select category,sum(case when datepart(year,order_date)=2019 then sales end) as total_sales_2019
,sum(case when datepart(year,order_date)=2020 then sales end) as total_sales_2020
from orders 
group by category

8- write a query print top 5 cities in west region by average no of days between order date and ship date.

select * from orders;
select top 5 city, AVG(datediff(DAY,order_date,ship_date)) as diff_days
from orders
where region = 'West'
group by city 
order by diff_days desc 

--9- write a query to print emp name, manager name and senior manager name (senior manager is manager's manager)

select * from employee 

select e.emp_name , m.emp_name as manager_name , mm.emp_name as managers_manager_name
from employee e 
inner join employee m  on e.manager_id = m.emp_id
inner join employee mm on m.manager_id = mm.emp_id

