update orders 
set city = NULL
where 
order_id in ('CA-2020-161389','US-2021-156909');

select * from orders 
where 
city is NULL;

select * from orders ;

select category, sum(profit) , min(order_date) , max(order_date)
from orders 
group by category;

 
 4- write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category
 select sub_category from orders 
  group by sub_category
  having 
 avg(profit) > max(profit)/2 

 write a query to find students who have got same marks in Physics and Chemistry.

 select * from exams;


select student_id , marks
from exams
where subject in ('Physics','Chemistry')
group by student_id , marks
having count(student_id)=2

select student_id  
from exams
where subject in ('Physics','Chemistry')
group by student_id 
having count(*) = 2 and count (distinct marks) = 1
 