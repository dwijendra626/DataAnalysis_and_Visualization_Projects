select 	dayname(date) as day, count(*)
from pizza.orders
group by 1
order by count(*) desc;

select 	*
from pizza.orders;

SELECT 	time, count(distinct order_id) as total_customers
from orders
group by time
order by total_customers desc;

select 	date,
		count(*)
from pizza.orders
group by date;

select  distinct(order_id), count(*)
from 	order_details
group by order_id;

select date, count(order_id)
from orders
group by date;

/* customers we have each day */

-- no. of orders per day
WITH no_of_orders_per_day AS 
(
	SELECT 	o.date, 
			COUNT(o.order_id) AS orders_per_day
	FROM 	orders o
	GROUP BY 1 
)
-- taking the avg of no. of orders per day to get the value on a daily basis 
SELECT  ROUND(AVG(orders_per_day)) AS Average_orders
FROM 	no_of_orders_per_day;

-- are there any peak hours?
SELECT 	EXTRACT(HOUR FROM o.time) AS hour, 
		COUNT(o.order_id) AS no_of_orders
FROM 	orders o
GROUP BY 1
ORDER BY 1;


    
/* how many pizzas are typically in an order ? */

-- no. of pizzas ordered per customer
WITH cte AS 
(
	SELECT 	od.order_id, 
			SUM(od.quantity) AS quantity_per_order
	FROM	order_details od
	GROUP BY 1
)

-- no.of customers ordered per quantity
SELECT	quantity_per_order, 
		COUNT(order_id) AS no_of_orders
FROM	cte
GROUP BY 1
ORDER BY 2 DESC;

/*  Do we have any bestsellers? */
SELECT 		pt.name, 
			p.size, 
			SUM(od.quantity) AS Total_pizzas
FROM 		pizza_types pt
INNER JOIN 	pizzas p
USING 		(pizza_type_id)
INNER JOIN 	order_details od
USING 		(pizza_id)
GROUP BY 	1,2
ORDER BY 	3 DESC
LIMIT 		5;

/* how much money did we make this year? */
SELECT 		concat(round(sum(price*quantity)/1000), 'k') AS Total_revenue
FROM 		pizzas p
INNER JOIN 	order_details od
USING 		(pizza_id);

/* can we identify any seasonality in the sales? */
SELECT 		EXTRACT(MONTH FROM o.date) AS months, 
			ROUND(SUM(p.price * od.quantity),2) AS Total_Revenue
FROM 		orders o
INNER JOIN 	order_details od
USING		(order_id)
INNER JOIN 	pizzas p
USING		(pizza_id)
GROUP BY 	1
ORDER BY 	1;


-- Are there any pizzas we should take of the menu, or any promotions we could leverage?

/* Are there any pizzas we should take of the menu, it means we can check worst selling pizzas where total quantity ordered is low */
select pt.name, p.size, sum(od.quantity) as Total_pizzas
from pizza_types pt
join pizzas p
using (pizza_type_id)
join order_details od
using (pizza_id)
group by 1,2
order by 3
limit 5;



/* revenue analysis */

-- total revenue - '817860.05'
SELECT 		round(sum(price*quantity),2) AS Total_revenue
FROM 		pizzas p
INNER JOIN 	order_details od
USING 		(pizza_id);

-- avg revenue by quarter - '204465.01'
with quarterly_revenue as (
select 	quarter(date) as quarter, 
		sum(p.price * od.quantity) as revenue
FROM 		orders o
INNER JOIN 	order_details od
USING		(order_id)
INNER JOIN 	pizzas p
USING		(pizza_id)
GROUP BY 	1
ORDER BY 	1)

select round(avg(revenue),2) as Avg_Revenue_per_Quarter from
quarterly_revenue;

-- avg revenue by month - '68155'
with monthly_revenue as 
(SELECT 	EXTRACT(MONTH FROM o.date) AS months, 
			ROUND(SUM(p.price * od.quantity),2) AS revenue
FROM 		orders o
INNER JOIN 	order_details od
USING		(order_id)
INNER JOIN 	pizzas p
USING		(pizza_id)
GROUP BY 	1
ORDER BY 	1)

select round(avg(revenue),2) AS Avg_monthly_revenue
from monthly_revenue;

-- monthly revenue
SELECT 		MONTHNAME(o.date) AS months, 
			ROUND(SUM(p.price * od.quantity),2) AS revenue
FROM 		orders o
INNER JOIN 	order_details od
USING		(order_id)
INNER JOIN 	pizzas p
USING		(pizza_id)
GROUP BY 	1
ORDER BY 	1;

-- quarterly revenue
select 		QUARTER(date) AS quarter, 
			SUM(p.price * od.quantity) AS revenue
FROM 		orders o
INNER JOIN 	order_details od
USING		(order_id)
INNER JOIN 	pizzas p
USING		(pizza_id)
GROUP BY 	1
ORDER BY 	1;

-- revenue on each day of the week 
SELECT 		DAYNAME(date) AS dayname,
			SUM(p.price * od.quantity) AS revenue
FROM 		orders o
INNER JOIN 	order_details od
USING		(order_id)
INNER JOIN 	pizzas p
USING		(pizza_id)
GROUP BY 	1
ORDER BY 	1;

-- best selling pizzas by revenue
SELECT 		pt.name, 
			p.size, 
			round(SUM(p.price * od.quantity),2) AS revenue
FROM 		pizza_types pt
INNER JOIN 	pizzas p
USING 		(pizza_type_id)
INNER JOIN 	order_details od
USING 		(pizza_id)
GROUP BY 	1,2
ORDER BY 	3 DESC
LIMIT 		5;


-- worst selling pizza by revenue
select pt.name, p.size, round(SUM(p.price * od.quantity),2) AS revenue
from pizza_types pt
join pizzas p
using (pizza_type_id)
join order_details od
using (pizza_id)
group by 1,2
order by 3
limit 5;

-- average revenue per pizza sale
select round(avg(price),2) as revenue 
from pizzas
join order_details
using (pizza_id);

-- revenue by pizza sizes 
select 	size,
		round(sum(price * quantity),2) as revenue
from 	pizzas
join 	order_details
using 	(pizza_id)
group by size;

-- month on month sales
WITH monthly_sales AS (
	SELECT 	month(o.date) AS monthnumber,
			extract(month from o.date) as monthname,
			round(SUM(p.price * od.quantity),2) AS total_sales
	FROM 		orders o
	INNER JOIN 	order_details od
	USING		(order_id)
	INNER JOIN 	pizzas p
	USING		(pizza_id)
	GROUP BY 	1,2
	ORDER BY 	1 
),
monthly_sales_diff AS (
  SELECT 	monthnumber,
			monthname,
			total_sales,
			LAG(total_sales) OVER (ORDER BY monthnumber) AS prev_month_sales
  FROM 		monthly_sales
)
SELECT monthnumber,
		monthname,
       total_sales,
       prev_month_sales,
       ROUND((total_sales - prev_month_sales) / prev_month_sales * 100, 2) AS sales_growth_percent
FROM monthly_sales_diff;


-- revenue by category
select 	category,
		round(sum(price * quantity),2) as revenue
from 	pizza_types
join 	pizzas
using 	(pizza_type_id) 
join 	order_details
using 	(pizza_id)
group by category;



/* sales analysis */

-- TOTAL orders placed 
SELECT 		sum(quantity)AS Total_orders_placed
FROM 		order_details;

-- Total quantities ordered
SELECT 		count(order_id) AS Total_Quantities_ordered
FROM 		orders;


-- no. of orders per day
WITH no_of_orders_per_day AS
(
	SELECT 		o.date,
				COUNT(o.order_id) AS orders_per_day
	FROM 		orders o
	GROUP BY 	1
)
-- taking the avg of no. of orders per day to get the value on a daily basis 
SELECT  ROUND(AVG(orders_per_day)) AS Average_orders
FROM 	no_of_orders_per_day;


-- peak hours
SELECT 		EXTRACT(HOUR FROM o.time) AS hour,
			COUNT(o.order_id) AS no_of_orders
FROM 		orders o
GROUP BY 	1
ORDER BY 	1;

-- order placed each day of week 
select 	dayname(date) as day, 
		count(order_id) as No_of_orders
from 	orders
group by 1
order by 1;

-- pizza orders by size
select 	size,
		sum(quantity) as pizza_order_by_size
from 	pizzas
join 	order_details
using 	(pizza_id)
group by size;


-- pizza orders by category
select 	category,
		sum(quantity) as pizza_order_by_category
from 	pizza_types
join 	pizzas
using 	(pizza_type_id) 
join 	order_details
using 	(pizza_id)
group by category;

-- best selling pizza
SELECT 		pt.name as Name, 
			p.size as Size, 
			SUM(od.quantity) AS Total_pizzas
FROM 		pizza_types pt
INNER JOIN 	pizzas p
USING 		(pizza_type_id)
INNER JOIN 	order_details od
USING 		(pizza_id)
GROUP BY 	1,2
ORDER BY 	3 DESC
LIMIT 		5;

-- worst selling pizza 
SELECT 		pt.name as Name, 
			p.size as Size, 
			SUM(od.quantity) AS Total_pizzas
FROM 		pizza_types pt
INNER JOIN 	pizzas p
USING 		(pizza_type_id)
INNER JOIN 	order_details od
USING 		(pizza_id)
GROUP BY 	1,2
ORDER BY 	3
LIMIT 		5;

-- seasonal sales
select 
	case 
		when month(date) between 3 and 5 then 'spring'
        when month(date) between 6 and 8 then 'summer'
        when month(date) between 9 and 11 then 'autumn'
        else 'winter'
	end as seasons,
    sum(quantity) as Total_sales,
    sum(price * quantity) as total_revenue
from orders
join order_details
using(order_id)
join pizzas
using (pizza_id)
group by seasons;

