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
-## Database Creation:The project starts by creating a database named 'p1_retail_db'.
-## Table Creation: A table named 'retail_sales' is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

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

 -##Record Count: Determine the total number of records in the dataset.
 -##Customer Count: Find out how many unique customers are in the dataset.
 -##Category Count: Identify all unique product categories in the dataset.
 -##Null Value Check: Check for any null values in the dataset and delete records with missing data.


```sql
SELECT COUNT(*) AS total_records FROM retail_sales;


