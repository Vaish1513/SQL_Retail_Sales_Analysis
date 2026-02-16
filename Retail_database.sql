
CREATE TABLE  retail_sales(
				transactions_id	INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,	
				customer_id	INT,
				gender 	VARCHAR(10),
				age	INT,
				category VARCHAR(15),	
				quantiy INT,
				price_per_unit FLOAT,	
				cogs FLOAT,
				total_sale FLOAT

);
---Display
SELECT * FROM retail_sales;

--Display not null values
SELECT * FROM retail_sales 
			WHERE
				transactions_id  IS NULL
			OR
				sale_date IS NULL
			OR
				quantiy IS NULL
			OR
				age IS NULL
			OR
				gender IS NULL
			OR
				sale_time IS NULL
			OR
				category IS NULL
			OR
				cogs IS NULL LIMIT 5;

--delete 
			DELETE FROM retail_Sales 
			WHERE

					transactions_id  IS NULL
			OR
				sale_date IS NULL
			OR
				quantiy IS NULL
			OR
				age IS NULL
			OR
				gender IS NULL
			OR
				sale_time IS NULL
			OR
				category IS NULL
			OR
				cogs IS NULL ;

		---Display the no of row present
			SELECT COUNT(*)FROM retail_sales;

		---Display only Hightest price records
			SELECT * FROM retail_sales ORDER BY price_per_unit DESC LIMIT 1;

		--Second highest record
			SELECT * FROM retail_sales ORDER BY price_per_unit DESC LIMIT 1 OFFSET 1;

---Data Exploration

---1) How many Sales we have?
	SELECT COUNT(*) AS total_sales FROM retail_sales;
	
---2)how many unique Customers we have?
	SELECT COUNT( DISTINCT customer_id) as total_sales FROM retail_sales; --Unique customers 
	
---3)How many Unique Category we have?
	SELECT COUNT( DISTINCT category) as total_sales FROM retail_sales; 
	
---4)Display Category Names
	SELECT DISTINCT category FROM retail_sales;


SELECT *FROM retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the Quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT* FROM retail_sales 
Where 
sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the Quantity sold is more than 10 in the month of Nov-2022
SELECT *FROM retail_sales
WHERE
category ='Clothing' AND quantiy >3
AND
TO_CHAR(sale_date,'YYYY-MM')='2022-11';


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT sum(total_sale) AS ts ,category 
FROM retail_sales
GROUP BY category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT AVG(age) as age 
FROM retail_sales 
 where category='Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT total_sale
FROM retail_sales 
WHERE total_sale > 1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT COUNT(*)as total_transactions,category,gender 
FROM retail_sales 
GROUP BY category,gender;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
	EXTRACT(YEAR FROM sale_date) AS year,
	EXTRACT(MONTH FROM sale_date) AS month,
	avg(total_sale) AS AVG_sale,
FROM retail_Sales 
GROUP BY 1,2 --Group using year and then
ORDER BY  1,3 DESC --this is for highest avg


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
	customer_id,
	sum(total_sale) as total_sales 
FROM retail_sales 
GROUP BY 1
ORDER BY total_sales DESC LIMIT 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT  
	COUNT(DISTINCT customer_id) as no_of_Customers,category 
FROM retail_sales  
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT*,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
		WHEN  EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
	FROM retail_sales;


