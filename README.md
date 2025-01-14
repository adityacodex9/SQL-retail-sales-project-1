#  SQL PROJECT_1 Retail Sales Analysis

## 📌 Overview
This project is dedicated to analyzing retail sales data to derive meaningful insights into customer behavior, sales trends, and product performance. The goal is to provide actionable intelligence that can inform business decisions and optimize retail operations.

The repository includes:
- A structured dataset (`SQL - Retail Sales Analysis_utf.csv`) containing transactional sales data.
- SQL scripts (`SQL project 1.sql`) for performing database queries and analyses.

## 🚀 Objectives
1. **Set up a Retail Sales Database**: Create and populate a database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values to ensure data accuracy.
3. **Sales Trends Analysis**: Discover patterns in sales across different times, days, and demographics.
4. **Customer Insights**: Segment customers based on age, gender, and purchasing behavior.
5. **Category Analysis**: Identify the best- and worst-performing product categories.

## Project Structure

## 1.Database Setup
- **Database Creation**: The project starts by creating a database named 'p_retail_db*.
- **Table Creation**: A table named 'retail_sales' is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```
## 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) AS total_records FROM retail_sales;

select count (distinct customer_id)as total_sale from retail_sales:

select distitnct category from retail_sales;

select from retail_sales
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
```
### 3. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

1 **Write a SQL query to retrieve all columns for sales made on '2023-09-05'?**
```sql
select * from retail_sales
where sale_date= '2023-09-05';
```

2 **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is 3 more than 3 in the month of Nov-2022?**
```sql
select * from retail_sales
where 
category= 'Clothing'
AND
to_char(sale_date, 'YYYY-MM')= '2022-11'
AND
quantity >=3
```

3 **Write a SQL query to calculate the total sales (total_sale) for each category?**
```sql
select category,
SUM(total_sale)as net_sale,
count(*)as total_orders
from retail_sales
group by 1
```

4 **Write a SQL query to find the average age of customers who purchased items from the 'Clothing' category?**
``` sql
select 
ROUND(AVG(age),2)as avg_age
from retail_sales
where category like 'Clothing'
```

5 **Write a SQL query to find all transactions where the total_sale is between 900 to 1200?**
```sql
select 
* 
from retail_sales
where total_sale between 900 and 1200
```

6 **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category?**
``` sql
select 
    category,
    gender,
count(*)as total_transactions
from retail_sales
GROUP BY 
       category,
       gender
order by 1
```

7 **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year?**
```sql
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
```

8 **Write a SQL query to find the top 5 customers based on the highest total sales?**
``` sql
select
   customer_id,
   sum(total_sale)as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5
```

9 **Write a SQL query to find the number of unique customers who purchased items from each category?**
```sql
select
   category,
   count(distinct customer_id)as unique_customer
from retail_sales
group by category;
```

10 **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)?**
``` sql
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
```

## 🔍 Findings and Conclusion

### 📊 Findings
1. **Sales Trends**:
   - The **highest sales** were observed during specific months, indicating potential seasonal demand.
   - Weekends and certain times of the day contributed significantly to revenue, highlighting peak shopping periods.

2. **Customer Insights**:
   - **Gender-based analysis** revealed distinct spending patterns, with certain genders contributing more to specific product categories.
   - The average age of frequent shoppers was identified, assisting in targeted marketing strategies.
   - High-value customers were segmented based on repeat purchases and total spending, enabling focused retention efforts.

3. **Category Performance**:
   - The analysis highlighted **top-performing product categories**, which contributed the most to overall revenue.
   - Several low-performing categories were identified, signaling the need for improvement in marketing, pricing, or inventory management.

4. **Data Cleaning**:
   - Null or missing records were removed, enhancing the dataset's reliability and ensuring more accurate insights.

---

### 📈 Conclusion
This project provided valuable insights into retail sales trends, customer behavior, and product performance. Key conclusions include:
- **Seasonal and temporal trends**: Businesses can optimize promotional efforts during peak times to maximize revenue.
- **Customer segmentation**: Targeted marketing campaigns can improve engagement and drive sales for specific demographic groups.
- **Category optimization**: Underperforming categories present opportunities for strategic improvements to enhance profitability.

By leveraging the findings from this analysis, retail operations can be optimized to improve customer satisfaction, increase revenue, and achieve better overall performance.















