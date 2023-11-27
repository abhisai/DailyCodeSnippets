select * from returns;
select * from orders;


1- write a query to get region wise count of return orders

select region , count(distinct o.order_id) from 
orders o join returns r 
on o.order_id = r.order_id
group by o.region


2- write a query to get category wise sales of orders that were not returned

select category , sum(sales) from 
orders 
where order_id not in (select order_id from returns)
group by category


select category,sum(o.sales) as total_sales
from orders o
left join returns r on o.order_id=r.order_id
where r.order_id is null
group by category

select * from orders
select * from returns
select distinct return_reason from returns

select * from employee 
select * from dept
3- write a query to print dep name and average salary of employees in that dep .
select dept.dep_name , avg(salary) from employee join dept on dept.dep_id = employee.dept_id 
group by dep_name

4- write a query to print dep names where none of the emplyees have same salary.

select dept.dep_name , count(employee.emp_id) as total_emp , count (distinct employee.salary) as distinct_salary
from employee join dept on dept.dep_id = employee.dept_id 
group by dep_name
having 
count(employee.emp_id) = count (distinct employee.salary)


5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)
  
select o.sub_category
from orders o
inner join returns r on o.order_id=r.order_id
group by o.sub_category
having count(distinct r.return_reason)=3

select * from orders
select count(1) from returns
select distinct return_reason from returns

6- write a query to find cities where not even a single order was returned.
--- These below 2 approaches are wrong as a city can be in both returned as well as in non-returned . Sample city Laguna Niguel
select distinct city from orders o left join returns r on o.order_id = r.order_id where r.order_id is NULL 
select  city , order_id  from orders o 
where 
o.order_id  not in (select r.order_id from returns r)

-- This is correct
select city
from orders o
left join returns r on o.order_id=r.order_id
group by city
having count(r.order_id)=0

7- write a query to find top 3 subcategories by sales of returned orders in east region
select * from orders
select * from returns

select top 3 sub_category , sum(sales) as total_returned_sales from orders o join returns r on o.order_id = r.order_id
where 
o.region = 'East'
group by sub_category
order by total_returned_sales desc


8- write a query to print dep name for which there is no employee
select * from employee 
select * from dept
select dept.dep_name 
from employee right join dept on dept.dep_id = employee.dept_id 
where 
employee.emp_id is NULL


select d.dep_id,d.dep_name
from dept d 
left join employee e on e.dept_id=d.dep_id
group by d.dep_id,d.dep_name
having count(e.emp_id)=0;


9- write a query to print employees name for dep id is not avaiable in dept table

select employee.emp_name
from employee left join dept on dept.dep_id = employee.dept_id 
where 
dept.dep_id is NULL


select e.*
from employee e 
left join dept d  on e.dept_id=d.dep_id
where d.dep_id is null;

