create database sql_project1;
use sql_project1;

/* database setup */
drop table if exists retail_sales;
Create table retail_sales(
transactions_id	int primary key, 
sale_date date, 
sale_time time,	
customer_id	int,
gender varchar(15),
age	int,
category varchar(15), 	
quantiy int,
price_per_unit float, 
cogs float,
total_sale float 
);

/* data cleaning */
select* from retail_sales;
select count(*) from retail_sales;

alter table retail_sales 
change column quantiy quantity int;


delete from retail_sales where
transactions_id is null
or
sale_date is null
or
sale_time is null
or	
customer_id	is null
or
gender is null
or
age is null
or 
category is null
or	
quantiy is null
or
price_per_unit is null
or 
cogs is null
or
total_sale is null;

/* data exploration and findings */

/* how many sales do we have? */
select count(*) as total_sales from retail_sales;

/* how many unique customers do we have?*/
select count(distinct(customer_id)) as total_customers from retail_sales;

/* how many categories do we have? */
select count(distinct(category)) as total_customers from retail_sales;

/*data analysis and business key problems 

1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
3. Write a SQL query to calculate the total sales (total_sale) for each category.:
4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
9. Write a SQL query to find the number of unique customers who purchased items from each category.:
10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17): */

/*1. Write a SQL query to retrieve all columns for sales made on '2022-11-05: */
select * from retail_sales where sale_date = '2022-11-05';

/*2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:*/
select * from retail_sales where 
category = "Clothing" and 
quantity >=4 and 
TO_CHAR(sale_date, 'YYYY-MM')= "2022-11";

/*3. Write a SQL query to calculate the total sales (total_sale) for each category.:*/
select sum(total_sale) as net_sales, category from retail_sales 
group by (category);

/*4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:*/
select round(avg(age),2) as avg_age from retail_sales 
where 
category ="Beauty";

/*5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:*/
select*from retail_sales where 
total_sale >1000;

/*6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:*/
select count(*), category, gender from retail_sales 
group by category, gender;

/*7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:*/
select Y,M, avg from 
(
select year(sale_date)as Y, month(sale_date)as M, avg(total_sale) as avg, 
RANK() over (partition by year(sale_date) order by avg(total_sale) desc) as r1 FROM retail_sales
group by Y, M
) as t1
where r1 = 1;

/*8. **Write a SQL query to find the top 5 customers based on the highest total sales **:*/

select customer_id, sum(total_sale) as total
from retail_sales 
group by customer_id
order by total desc
limit 5;

/*9. Write a SQL query to find the number of unique customers who purchased items from each category.:*/
select count(distinct customer_id), category from retail_sales 
group by category;

/*10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17): */
with hourly_sale 
as
(select *, 
case 
when hour(sale_time)<12 then 'morning'
when hour(sale_time) Between 12 and 17 then 'afternoon'
when hour(sale_time) >17 then 'evening'
end as shift
from retail_sales 
)
select count(*) as total_orders, shift
from hourly_sale
group by shift;

/*End of Project*/

 
  




