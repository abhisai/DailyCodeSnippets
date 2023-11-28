create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;

1- write a query to produce below output from icc_world_cup table.
team_name, no_of_matches_played , no_of_wins , no_of_losses
with cte as (
select Team_1 AS TEAM, 
case when Winner = Team_1 then 1 else 0 end win_flag from icc_world_cup
UNION ALL
select Team_2 AS TEAM, 
case when Winner = Team_2 then 1 else 0 end win_flag from icc_world_cup
)

select team , count(*) as no_of_matches_played ,sum(win_flag) as no_of_wins , 
count(*) - sum(win_flag) as no_of_loss
from cte 
group by team


with all_teams as 
(select team_1 as team, case when team_1=winner then 1 else 0 end as win_flag from icc_world_cup
union all
select team_2 as team, case when team_2=winner then 1 else 0 end as win_flag from icc_world_cup)
select team,count(1) as total_matches_played , sum(win_flag) as matches_won,count(1)-sum(win_flag) as matches_lost
from all_teams
group by team


2- write a query to print first name and last name of a customer using orders table(everything after first space can be considered as last name)
customer_name, first_name,last_name
select * from orders;

select SUBSTRING(customer_name,1,CHARINDEX(' ',customer_name)) as first_name,
substring(customer_name,CHARINDEX(' ',customer_name)+1,len(customer_name)-CHARINDEX(' ',customer_name)+1) as last_name
from orders;


Run below script to create drivers table:

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');
select * from drivers;
3- write a query to print below output using drivers table. 
Profit rides are the no of rides where end location of a ride is same as start location of immediate next ride for a driver

with cte as (
select * , lead(start_loc,1,NULL) over(partition by id order by start_time) as next_ride_start
from  drivers
)
 
select id ,count(1) as total_rides , 
sum(case when end_loc = next_ride_start then 1 else 0 end) as profit_rides
from cte group by id

-- self join
with rides as (
select *,row_number() over(partition by id order by start_time asc) as rn
from drivers)
select r1.id , count(1) total_rides, count(r2.id) as profit_rides
from rides r1
left join rides r2
on r1.id=r2.id and r1.end_loc=r2.start_loc and r1.rn+1=r2.rn
group by r1.id




id, total_rides , profit_rides
dri_1,5,1
dri_2,2,0

4- write a query to print customer name and no of occurence of character 'n' in the customer name.
customer_name , count_of_occurence_of_n

select customer_name , len(customer_name)-len(replace(lower(customer_name),'n','')) as count_of_occurence_of_n
from orders





5-write a query to print below output from orders data. example output
hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
category , Technology, ,
category, Furniture, ,
category, Office Supplies, ,
sub_category, Art , ,
sub_category, Furnishings, ,
--and so on all the category ,subcategory and ship_mode hierarchies 


select 
'category' as hierarchy_type,category as hierarchy_name
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders
group by category
union all
select 
'sub_category',sub_category
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders
group by sub_category
union all
select 
'ship_mode ',ship_mode 
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders
group by ship_mode 


6- the first 2 characters of order_id represents the country of order placed . write a query to print total no of orders placed in each country
(an order can have 2 rows in the data when more than 1 item was purchased in the order but it should be considered as 1 order)

select * from orders;

with cte as (
select distinct order_id from orders
)
select substring(order_id,1,2) as country , count(1) as number_of_orders from cte
group by substring(order_id,1,2)

select left(order_id,2) as country , count(distinct order_id) as num_of_orders
from orders 
group by left(order_id,2)