# NOTE :- In this context, it's important to note that the table names used in the examples include underscores and numbers, 
# which differ from the naming conventions used in the LeetCode problem.

Create table If Not Exists Prices_26
(
product_id int, 
start_date date, 
end_date date, 
price int
);

Create table If Not Exists UnitsSold_26
(
product_id int, 
purchase_date date, 
units int
); 

Truncate table Prices_26;
insert into Prices_26 (product_id, start_date, end_date, price) values ('1', '2019-02-17', '2019-02-28', '5');
insert into Prices_26 (product_id, start_date, end_date, price) values ('1', '2019-03-01', '2019-03-22', '20');
insert into Prices_26 (product_id, start_date, end_date, price) values ('2', '2019-02-01', '2019-02-20', '15');
insert into Prices_26 (product_id, start_date, end_date, price) values ('2', '2019-02-21', '2019-03-31', '30');

Truncate table UnitsSold_26;
insert into UnitsSold_26 (product_id, purchase_date, units) values ('1', '2019-02-25', '100');
insert into UnitsSold_26 (product_id, purchase_date, units) values ('1', '2019-03-01', '15');
insert into UnitsSold_26 (product_id, purchase_date, units) values ('2', '2019-02-10', '200');
insert into UnitsSold_26 (product_id, purchase_date, units) values ('2', '2019-03-22', '30');

/*
Q. Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.
Return the result table in any order.

Input: 
Prices table:
+------------+------------+------------+--------+
| product_id | start_date | end_date   | price  |
+------------+------------+------------+--------+
| 1          | 2019-02-17 | 2019-02-28 | 5      |
| 1          | 2019-03-01 | 2019-03-22 | 20     |
| 2          | 2019-02-01 | 2019-02-20 | 15     |
| 2          | 2019-02-21 | 2019-03-31 | 30     |
+------------+------------+------------+--------+
UnitsSold table:
+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |
+------------+---------------+-------+
Output: 
+------------+---------------+
| product_id | average_price |
+------------+---------------+
| 1          | 6.96          |
| 2          | 16.96         |
+------------+---------------+
Explanation: 
Average selling price = Total Price of Product / Number of products sold.
Average selling price for product 1 = ((100 * 5) + (15 * 20)) / 115 = 6.96
Average selling price for product 2 = ((200 * 15) + (30 * 30)) / 230 = 16.96
*/

SELECT * FROM Prices_26;
SELECT * FROM UnitsSold_26;

# TYPE 1:- 
SELECT p.product_id, ROUND(SUM(p.price * u.units) / SUM(u.units), 2) AS average_price
FROM Prices_26 AS p
INNER JOIN UnitsSold_26 AS u
ON p.product_id = u.product_id
AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;

# TYPE 2:- 
SELECT p.product_id, ROUND(SUM(u.units * p.price) / SUM(u.units), 2) AS average_price
FROM Prices_26 AS p
INNER JOIN UnitsSold_26 AS u
ON p.product_id = u.product_id
AND u.purchase_date >= p.start_date
AND u.purchase_date <= p.end_date
GROUP BY p.product_id;


