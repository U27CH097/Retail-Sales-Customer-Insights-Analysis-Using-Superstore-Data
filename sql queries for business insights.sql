CREATE TABLE superstore (
    order_date DATE,
    Ship_Mode VARCHAR(150),
	Customer_Name TEXT,
	Segment TEXT,
	City TEXT,
	State VARCHAR(150),
	Postal_Code INT,
	Region VARCHAR(100),
	Product_ID TEXT,
	Category TEXT,
	Sub_Category TEXT,
	Product_Name TEXT,
	Sales NUMERIC,
	Quantity INT,
	Discount NUMERIC,
	Profit NUMERIC,
	Profit_Margin_per NUMERIC,
	Order_Month INT
);
--
SELECT* FROM superstore

---Now import the data from .xlsx file via psql tool workspace

---Now build some KPI's


---Total Profit
SELECT SUM(profit) as total_profit
FROM superstore;
--Rs. 286409.0805

---Total Orders
SELECT COUNT(*) as total_orders
FROM superstore;
-- 9993

---Total Sales
SELECT SUM(sales) as total_profit
FROM superstore;
--Rs.2296919.4883

---Profit Margin (%)
SELECT (SUM(profit)/SUM(sales))*100 as profit_margin
FROM superstore
--12.46 percentage

---NOW lets answer some business problems-->
--1. which region generates the highest total sales and profit?

SELECT region as region, SUM(sales) as sales ,SUM(profit) as profit
FROM superstore
GROUP BY region
ORDER BY sales desc
LIMIT 1;

--2. Which product Sub-category are most profitable?

SELECT sub_category as sub_category,SUM(profit) as profit
FROM superstore
GROUP BY sub_category
ORDER BY profit desc;
--LIMIT 1;

--3.what is the average discount given across all orders?

SELECT AVG(discount) as avg_discount
FROM superstore
-->  0.156188

--4.who are top 10 customers by total sales?
SELECT customer_name as customer_name,
sum(sales) as total_sales
FROM superstore
GROUP BY customer_name
ORDER BY total_sales desc
LIMIT 10;

--5.How do monthaly sales trend over time?
SELECT SUM(sales) as monthly_sales,
order_month as month
FROM superstore
GROUP BY order_month
ORDER BY order_month asc;

--6. Are we making loss in any sub-categories  or regions?
SELECT sub_category as sub_category,
sum(profit) as loss
FROM superstore
GROUP BY sub_category
HAVING
SUM(profit)<0;

--7.How many unique customers placed orders?
SELECT DISTINCT customer_name as customer_name
FROM superstore
--total 793 are unique customers

--8.what is the total quantity of items sold per category?
SELECT category as category,
SUM(quantity) as items_sold
FROM superstore
GROUP BY category
ORDER BY items_sold desc;


--9.what is profit margin (%) per segment?
SELECT category as segment,
(SUM(profit)/SUM(sales))*100 as profit_margin_per
FROM superstore
GROUP BY category
ORDER BY profit_margin_per desc;

--10.For each region, identify the top 3 most profitable sub-categories.
WITH ranked_subcategories AS (
    SELECT region,sub_category, sum(profit) as total_profit,
    RANK() OVER(PARTITION BY region ORDER BY SUM(profit) desc) AS profit_rank
    FROM superstore
    GROUP BY region, sub_category
)
SELECT *
FROM ranked_subcategories
WHERE profit_rank <= 3




SELECT* FROM superstore































































