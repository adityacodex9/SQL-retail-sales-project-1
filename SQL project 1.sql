--sql_retail sales analysis p1

CREATE TABLE retail_sales
(
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,	
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,	
    total_sale FLOAT
);

-- data cleaning 

select * from retail_sales
where transaction_id is null
      or 
	  sale_date is null
	  or 
	  sale_time is null
	  or 
	  customer_id is null
	  or 
	  gender is null
	  or 
	  age is null
	  or 
	  category is null
	  or 
	  quantity is null
	  or 
	  price_per_unit is null
	  or 
	  cogs is null
	  or 
	  total_sale is null


delete from retail_sales
where transaction_id is null
      or 
	  sale_date is null
	  or 
	  sale_time is null
	  or 
	  customer_id is null
	  or 
	  gender is null
	  or 
	  age is null
	  or 
	  category is null
	  or 
	  quantity is null
	  or 
	  price_per_unit is null
	  or 
	  cogs is null
	  or 
	  total_sale is null

-- DATA EXPLORATION

-- How many sales we have ?

SELECT count (*) as total_sale from retail_sales 

--How many unique customers we have?

select count (distinct customer_id)as total_sale from retail_sales

-- DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS 

--1:Write a SQL query to retrieve all columns for sales made on '2023-09-05'?

select * from retail_sales
where sale_date= '2023-09-05';

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is 3 more than 3 in the month of Nov-2022 ? 

select * from retail_sales
where 
category= 'Clothing'
AND
to_char(sale_date, 'YYYY-MM')= '2022-11'
AND
quantity >=3

-- Write a SQL query to calculate the total sales (total_sale) for each category?

select category,
SUM(total_sale)as net_sale,
count(*)as total_orders
from retail_sales
group by 1

--Write a SQL query to find the average age of customers who purchased items from the 'Clothing' category ?

select 
ROUND(AVG(age),2)as avg_age
from retail_sales
where category like 'Clothing'

--Write a SQL query to find all transactions where the total_sale is between 900 to 1200 ?

select 
* 
from retail_sales
where total_sale between 900 and 1200

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category?

select 
category,
gender,
count(*)as total_transactions
from retail_sales
GROUP BY 
category,
gender
order by 1

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year ?

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

--Write a SQL query to find the top 5 customers based on the highest total sales?

select
customer_id,
sum(total_sale)as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5

--Write a SQL query to find the number of unique customers who purchased items from each category?

select
category,
count(distinct customer_id)as unique_customer
from retail_sales
group by category

--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)?

with hourly_sale
AS
(
select *,
     case
	    when extract(hour from sale_time)<12 then 'morning'
		when extract(hour from sale_time) between 12 and 17 then 'afternoon'
		when extract(hour from sale_time)> 17 then 'evening'
	 end as shift
from retail_sales		
)
select 
     shift,
	 count(*)as total_orders
from hourly_sale
group by shift
