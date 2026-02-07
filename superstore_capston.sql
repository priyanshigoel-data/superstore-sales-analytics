--Super Store

drop table superstore;
create table superstore(
Row_ID	bigint,
Order_ID varchar(50),
Order_Date date,
Ship_Date	date,
Category	varchar(50),
City	varchar(50),
Country	varchar(50),
Customer_ID	varchar(50),
Customer_Name	varchar(100),
Delivery_Pace	varchar(50),
Delivery_Time	int,
Month_Name	varchar(50),
Postal_Code	text,
Product_ID	varchar(50),
Product_Name	varchar(200),
Region	varchar(50),
Sales	float,
Segment	varchar(50),
Ship_Mode	varchar(50),
State	varchar(50),
Sub_Category	varchar(50),
Year int);



--GENERAL / OVERVIEW ANALYSIS

--Q1. What is the total sales reven
SELECT 
    SUM(sales) AS total_sales
FROM superstore;


--Q2. How many total orders are there?
SELECT 
	COUNT(*) AS total_orders
FROM superstore;

SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore;

--Q3. What is average sales per order?
SELECT 
    SUM(sales) / COUNT(DISTINCT order_id) AS avg_order_value
FROM superstore_data;

--Q4. What is the earliest and latest order date?
SELECT 
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order
FROM superstore;





--TIME/TREND ANALYSIS

--Q5. Monthly sales trend (sales per month)
SELECT
    year,
    EXTRACT(MONTH FROM order_date) AS month_no,
    month_name,
    SUM(sales) AS monthly_sales
FROM superstore
GROUP BY 1,2,3
ORDER BY 1,2;


--Q6. Yearly sales trend
select 
	year,
	sum(sales) AS Yearly_sales
from superstore
group by 1
order by 1;

--Q7. Which month had highest sales?

SELECT
    year,
    EXTRACT(MONTH FROM order_date) AS month_no,
    month_name,
    SUM(sales) AS monthly_sales
FROM superstore
GROUP BY 1,2,3
ORDER BY 4 desc
LIMIT 1;

--Q8. Which month had lowest sales?
SELECT
    year,
    EXTRACT(MONTH FROM order_date) AS month_no,
    month_name,
    SUM(sales) AS monthly_sales
FROM superstore
GROUP BY 1,2,3
ORDER BY 4 
LIMIT 1;




--PRODUCT ANALYSIS

--Q9. Top 10 products by sales
select
	product_name,
	sum(sales) AS Prouct_sale
from superstore
group by 1
order by 2 desc
limit 10;

--Q10. Bottom 10 products by sales
select
	product_name,
	sum(sales) AS Prouct_sale
from superstore
group by 1
order by 2
limit 10;

--Q11. Sales by category 
select
	category,
	sum(sales) AS category_sales
from superstore
group by 1;

--Q12. Sales by sub-category
select
	sub_category,
	sum(sales) AS sub_category_sales
from superstore
group by 1;

--Q13. % contribution of each category to total sales

SELECT 
    category,
    SUM(sales) AS category_sales,
    ROUND(
		(SUM(sales) * 100.0 / 
        (SELECT SUM(sales) FROM superstore))::numeric,
        2
    ) AS percentage_contribution
FROM superstore
GROUP BY 1
ORDER BY 3 DESC;





--REGION / GEOGRAPHY ANALYSIS

--Q14. Sales by region
select 
	region,
	sum(sales) AS regional_sales
from superstore
group by 1;

--Q15. Top 5 cities by sales
select 
	city,
	sum(sales) AS city_sales
from superstore
group by 1
order by 2 desc
limit 5;

--Q16. Bottom 5 cities by sales
select 
	city,
	sum(sales) AS city_sales
from superstore
group by 1
order by 2 
limit 5;

--Q17. Number of orders per region
select
	region,
	count(distinct order_id)
from superstore
group by 1;

select* from superstore;






--CUSTOMER ANALYSIS


--Q18. Total unique customers
select 
	count(distinct Customer_id)
from superstore;

--Q19. Top 10 customers by sales
select 
	 customer_name,
	 customer_id,
	sum(sales) AS customer_sales
from superstore
group by 1,2
order  by 3 desc
limit 10;

--Q20. Average sales per customer
SELECT
    SUM(sales) / COUNT(DISTINCT customer_id) AS avg_sales_per_customer
FROM superstore;

--Q21. Repeat customers (customers with >1 order)
SELECT
    customer_name,
    COUNT(order_id) AS order_count
FROM superstore
GROUP BY 1
HAVING COUNT(order_id) > 1
ORDER BY 2 DESC;

--Q22. Sales by segment
select 
	 segment,
	sum(sales) AS segment_sales
from superstore
group by 1
order by 2;





--OPERATIONS / SHIPPING ANALYSIS

--Q23. Average shipping days

select
	AVG(delivery_time) AS Avg_delivery_days
from superstore
order by 2;

--Q24. Shipping days by region
select 
	region,
	avg(delivery_time)
from superstore
group by 1
order by 2;

--Q25. Sales grouped by shipping speed (Fast/Slow)
select
	delivery_pace,
	sum(sales)
from superstore
group by 1
order by 2;

--Q26. Which ship mode is most used?
select
	ship_mode,
	count(*)
from superstore
group by 1;
















