SELECT * FROM walmart_sales ;

-- ---------------------------------------------
-- Business Problems :: Basic Level
-- ---------------------------------------------
--Q.1 Find the total sales amount for each branch
--Q.2 Calculate the average customer rating for each city.
-- Q.3 Count the number of sales transactions for each customer type.
-- Q.4 Find the total quantity of products sold for each product line.
-- Q.4 v1 Calculate the total VAT collected for each payment method.



-- ---------------------------------------------
-- Business Problems :: Medium Level
-- ---------------------------------------------
-- Q.5 Find the total sales amount and average customer rating for each branch.
-- Q.6 Calculate the total sales amount for each city and gender combination.
-- Q.7 Find the average quantity of products sold for each product line to female customers.
-- Q.8 Count the number of sales transactions for members in each branch.
-- Q.9 Find the total sales amount for each day. (Return day name and their total sales order DESC by amt)




-- ---------------------------------------------
-- Business Problems :: Advanced Level
-- ---------------------------------------------
-- Q.10 Calculate the total sales amount for each hour of the day
-- Q.11 Find the total sales amount for each month. (return month name and their sales)
-- Q.12 Calculate the total sales amount for each branch where the average customer rating is greater than 7.
-- Q.13 Find the total VAT collected for each product line where the total sales amount is more than 500.
-- Q.14 Calculate the average sales amount for each gender in each branch.
-- Q.15 Count the number of sales transactions for each day of the week.
-- Q.16 Find the total sales amount for each city and customer type combination where the number of sales transactions is greater than 50.
-- Q.17 Calculate the average unit price for each product line and payment method combination.
-- Q.18 Find the total sales amount for each branch and hour of the day combination.
-- Q.19 Calculate the total sales amount and average customer rating for each product line where the total sales amount is greater than 1000.
-- Q.20 Calculate the total sales amount for morning (6 AM to 12 PM), afternoon (12 PM to 6 PM), and evening (6 PM to 12 AM) periods using the time condition.


-- Business Problems :: Basic Level
----------------------------------------
--Q.1 Find the total sales amount for each branch.
SELECT 
	branch,
	SUM(total) AS total_sales
FROM walmart_sales
GROUP BY branch ;

--Q.2 Calculate the average customer rating for each city.
SELECT 
	city,
	AVG(rating) AS avg_rating
FROM walmart_sales
GROUP BY city ;

-- Q.3 Count the number of  sales transactions for each customer type.
SELECT 
	customer_type,
	COUNT(invoice_id) AS total_trans 
FROM walmart_sales 
GROUP BY customer_type;

-- Q.4 Find the total quantity of products sold for each product line.
SELECT 
	product_line,
	SUM(quantity)
FROM walmart_sales
GROUP BY product_line ;

-- Q.4 v1 Calculate the total VAT collected for each payment method.
SELECT 
	payment_method,
	SUM(vat)
FROM walmart_sales
GROUP BY payment_method ;


-- Business Problems :: Medium Level
-- ---------------------------------------------
-- Q.5 Find the total sales amount and average customer rating for each branch.
SELECT 
	branch,
	SUM(total) AS total_sales ,
	AVG(rating) AS avg_rating
FROM walmart_sales
GROUP BY branch ;

-- Q.6 Calculate the total sales amount for each city and gender combination.
SELECT 
	city,
	gender,
	SUM(total) AS total_sales
FROM walmart_sales
GROUP BY city , gender
ORDER BY city ;

-- Q.7 Find the average quantity of products sold for each product line to female customers.
SELECT 
	product_line ,
	AVG(quantity) AS avg_qty
FROM walmart_sales
WHERE gender = 'Female'
GROUP BY product_line ;

-- Q.8 Count the number of sales transactions for members in each branch.
SELECT 
	branch,
	COUNT(invoice_id) AS total_mbr
FROM walmart_sales
GROUP BY branch ;

-- Q.9 Find the total sales amount for each day. (Return day name and their total sales order DESC by amt)
SELECT 
	TO_CHAR(date , 'Day') AS day_name,
	SUM(total) AS total_sales
FROM walmart_sales
GROUP BY day_name
ORDER BY total_sales DESC ;


-- Business Problems :: Advanced Level
-- ---------------------------------------------
-- Q.10 Calculate the total sales amount for each hour of the day.
SELECT 
	EXTRACT(HOUR FROM time) AS hour_time ,
	SUM(total) AS total_sales
FROM walmart_sales
GROUP BY hour_time ;

-- Q.11 Find the total sales amount for each month. (return month name and their sales)
SELECT 
	TO_CHAR(date,'Month') AS month_name,
	SUM(total) AS total_sales
FROM walmart_sales
GROUP BY month_name ;

-- Q.12 Calculate the total sales amount for each branch where the average customer rating is greater than 7.
SELECT 
	branch,
	SUM(total) AS total_sales,
	AVG(rating) AS avg_rating
FROM walmart_sales
GROUP BY branch
HAVING AVG(rating) > 7 ;

-- Q.13 Find the total VAT collected for each product line where the total sales amount is more than 500.
SELECT 
	product_line,
	SUM(vat) AS total_vat
FROM walmart_sales
WHERE total > 500
GROUP BY product_line ;

-- Q.14 Calculate the average sales amount for each gender in each branch.
SELECT 
	branch,
	gender,
	AVG(total) AS avg_sales
FROM walmart_sales
GROUP BY branch , gender
ORDER BY branch ;

-- Q.15 Count the number of sales transactions for each day of the week.
SELECT 
	 EXTRACT(WEEK FROM date ) AS week,
	 COUNT(invoice_id) AS total_trans
FROM walmart_sales
GROUP BY week
ORDER BY total_trans ;

-- Q.16 Find the total sales amount for each city and 
--customer type combination where the number of sales transactions is greater than 50.
SELECT 
	city,
	customer_type ,
	SUM(total) AS total_sales,
	COUNT(invoice_id) AS total_trans
FROM walmart_sales
GROUP BY city , customer_type
HAVING COUNT(invoice_id) > 50
ORDER BY city ;

-- Q.17 Calculate the average unit price for each product line and payment method combination.
SELECT 
	product_line,
	payment_method,
	AVG(unit_price) AS avg_unit_price
FROM walmart_sales
GROUP BY product_line , payment_method
ORDER BY product_line ;

-- Q.18 Find the total sales amount for each branch and hour of the day combination.
SELECT 
	branch ,
	EXTRACT(HOUR FROM time) AS hour_of_the_day,
	SUM(total) AS total_sales
FROM walmart_sales 
GROUP BY branch , hour_of_the_day
ORDER BY branch ;

-- Q.19 Calculate the total sales amount and average customer rating for each product line
--where the total sales amount is greater than 1000.
SELECT 
	product_line,
	SUM(total) AS total_sales,
	AVG(rating) AS avg_rating
FROM walmart_sales
WHERE total > 1000
GROUP BY product_line


-- Q.20 Calculate the total sales amount for morning (6 AM to 12 PM), afternoon (12 PM to 6 PM)
--and evening (6 PM to 12 AM) periods using the time condition.

WITH new_sales
AS
(
SELECT * ,
	CASE 
	     WHEN EXTRACT(HOUR FROM time) BETWEEN 6 AND 12 THEN 'Morning'
		 WHEN EXTRACT(HOUR FROM time) > 12 and EXTRACT(HOUR FROM time)<= 18 THEN 'Afternoon'
		 ELSE 'Evening'
		 END AS shift 
FROM walmart_sales
)
SELECT 
	shift,
	SUM(total) AS total_sales
	FROM new_sales
	GROUP BY shift ;
	




