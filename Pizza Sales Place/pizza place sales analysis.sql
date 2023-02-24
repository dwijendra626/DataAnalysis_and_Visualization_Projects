------------------------------------------------------------------------------------

/* customers we have each day */

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

-----------------------------------------------------------------------------------

/* Are there any peak hours? */

SELECT 		EXTRACT(HOUR FROM o.time) AS hour,
			COUNT(o.order_id) AS no_of_orders
FROM 		orders o
GROUP BY 	1
ORDER BY 	1;

----------------------------------------------------------------------------------

/* how many pizzas are typically in an order ? */

-- no. of pizzas ordered per customer
WITH cte AS
(
	SELECT 		od.order_id,
				SUM(od.quantity) AS quantity_per_order
	FROM		order_details od
    GROUP BY 	1
)

-- no.of customers ordered per quantity
SELECT		quantity_per_order,
			COUNT(od.order_id) AS no_of_orders
FROM		cte
GROUP BY 	1
ORDER BY 	2 DESC;

----------------------------------------------------------------------------------

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

---------------------------------------------------------------------------------

/* how much money did we make this year? */
SELECT 		concat(round(sum(price*quantity)/1000), 'k') AS Total_revenue
FROM 		pizzas p
INNER JOIN 	order_details od
USING 		(pizza_id);

---------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------

/* Are there any pizzas we should take of the menu */
SELECT 		pt.name, 
			p.size, 
			SUM(od.quantity) AS Total_pizzas
FROM 		pizza_types pt
INNER JOIN 	pizzas p
USING 		(pizza_type_id)
INNER JOIN 	order_details od
USING 		(pizza_id)
GROUP BY 	1,2
ORDER BY 	3
LIMIT 		5;

---------------------------------------------------------------------------------