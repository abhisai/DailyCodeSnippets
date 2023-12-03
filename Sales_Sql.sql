CREATE TABLE salespeople (
 salesperson_id INT PRIMARY KEY,
 salesperson_name VARCHAR(255)
);

CREATE TABLE sales (
 sale_id INT PRIMARY KEY,
 salesperson_id INT,
 customer_id INT
);

INSERT INTO salespeople VALUES
 (1, 'John Doe'),
 (2, 'Jane Smith'),
 (3, 'Bob Johnson');

INSERT INTO sales VALUES
 (101, 1, 1001),
 (102, 1, 1002),
 (103, 1, 1003),
 (104, 2, 1001),
 (105, 2, 1002),
 (106, 3, 1003);
 
 
 select * from salespeople
 
 select * from sales
 
 --Find the salespeople who have made sales to all available customers
 
 select * from salespeople p 
where 
(p.salesperson_id) in (select s.salesperson_id from sales s group by s.salesperson_id
                      having count(*) = (select count(DISTINCT customer_id) from sales))
 
 