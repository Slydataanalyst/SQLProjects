
--TOTAL REVENUE
SELECT ROUND (SUM(total_price),0) AS Total_Revenue
FROM [Pizza sales].[dbo].[pizza_sales]

--AVERAGE ORDER VALUE
SELECT ROUND (SUM(total_price),0) AS Total_Revenue, COUNT (DISTINCT(order_id)) AS Total_orders,
  ROUND(ROUND(SUM(total_price),0)/COUNT(DISTINCT(order_id)),0) AS average_order_value
  FROM [Pizza sales].[dbo].[pizza_sales]

  --TOTAL PIZZA SOLD
  SELECT SUM(quantity) as total_pizza_sold
  FROM [Pizza sales].[dbo].[pizza_sales]

  --TOTAL ORDERS
  SELECT COUNT(DISTINCT(order_id)) as total_orders
  FROM [Pizza sales].[dbo].[pizza_sales]

  --DAILY TREND FOR TOTAL ORDERS
  SELECT DATENAME(weekday,order_date) as Order_day,
  COUNT (DISTINCT(order_id)) as Total_order
  FROM [Pizza sales].[dbo].[pizza_sales]
  GROUP BY DATENAME(weekday,order_date)

  --MONTHLY TREND FOR TOTAL ORDERS
  SELECT DATENAME(Month,order_date) as Month_name,
  COUNT (DISTINCT(order_id)) as Total_order
  FROM [Pizza sales].[dbo].[pizza_sales]
  GROUP BY DATENAME(Month,order_date)
  ORDER BY total_order DESC

  --TOP 5 PIZZA BY QUANTITY
  SELECT TOP 5 [pizza_name_id], ROUND(SUM(quantity),0) as total_quantity
  FROM [Pizza sales].[dbo].[pizza_sales]
  GROUP BY [pizza_name_id]
  ORDER BY total_quantity desc

  --BOTTOM 5 PIZZA BY QUANTITY
    SELECT TOP 5 [pizza_name_id], ROUND(SUM(quantity),0) as total_quantity
	FROM [Pizza sales].[dbo].[pizza_sales]
	GROUP BY [pizza_name_id]
    ORDER BY total_quantity Asc

  --TOP 5 PIZZA BY REVENUE
    SELECT TOP 5 [pizza_name_id], ROUND(SUM(quantity),0) as total_revenue
	FROM [Pizza sales].[dbo].[pizza_sales]
	GROUP BY [pizza_name_id]
	ORDER BY total_revenue desc

  --BOTTOM 5 PIZZA BY REVENUE
    SELECT TOP 5 [pizza_name_id], ROUND(SUM(quantity),0) as total_revenue
    FROM [Pizza sales].[dbo].[pizza_sales]
	GROUP BY [pizza_name_id]
	ORDER BY total_revenue Asc





















