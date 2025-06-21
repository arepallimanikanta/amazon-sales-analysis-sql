create database amozon;     -- step1
use amozon;
create table sales_table (                 -- step2
invoice_id VARCHAR(20) PRIMARY KEY,
branch VARCHAR(5),
city VARCHAR(30),
customer_type VARCHAR(30),
gender VARCHAR(10),
product_line VARCHAR(100),
unit_price DECIMAL(10, 2),
quantity INT,
tax float,
total decimal(10,2),
date DATE,
time TIME,
payment_method varchar(50),
cogs float,
gross_margin_percentage float,
gross_income float,
rating float
);

SELECT *   -- step 3
FROM sales_table
WHERE
    invoice_id IS NULL OR
    branch IS NULL OR
    city IS NULL OR
    customer_type IS NULL OR
    gender IS NULL OR
    product_line IS NULL OR
    unit_price IS NULL OR
    quantity IS NULL OR
    tax IS NULL OR
    total IS NULL OR
    date IS NULL OR
    time IS NULL OR
    payment_method IS NULL OR
    cogs IS NULL OR
    gross_margin_percentage IS NULL OR
    gross_income IS NULL OR
    rating IS NULL;



alter table sales_table
add column timeofday varchar(10);
update sales_table
set timeofday = case
when time>= '05:00:00' and time<= '12:00:00' then 'morning'
when time>= '12:00:00' and time<= '17:00:00' then 'Afternoon'
when time>= '17:00:00' and time<= '21:00:00' then 'evening'
else 'night'
end;

alter table sales_table
add column dayname varchar(10);
update sales_table
set dayname=date_format(date,'%a');

alter table sales_table add column monthname varchar(10);
update sales_table
set monthname=date_format(date,'%b');

 select * from sales_table;

#  Business Questions To Answer:

-- 1.What is the count of distinct cities in the dataset?
select count(distinct city) as distinct_city_count from sales_table;

-- 2.For each branch, get its corresponding city
select distinct branch,city from sales_table;

-- 3.Count of distinct product lines
select count(distinct product_line) as distinct_product_lines from sales_table;

-- 4.Most frequently used payment method
select payment_method ,count(*) as method_count from sales_table
group by payment_method
order by method_count desc 
limit 1;

-- 5.Which product line has the highest sales?
select product_line,count(*) as highest_count from sales_table
group by product_line
order by highest_count desc
limit 1;

-- 6.How much revenue is generated each month?
select 
date_format(date, '%y-%m')  as month,
sum(total) as monthly from sales_table
group by date_format(date, '%y-%m')
order by month;

-- 7.In which month did the cost of goods sold reach its peak?                                              
select date_format(date,'%y-%m') as month,                                                                   
sum(cogs) as peak from sales_table
 group by date_format(date,'%y-%m') 
 order by peak
 limit 1;
 
-- 8.Which product line generated the highest revenue?
select product_line,sum(total) as total_revenue from sales_table
group by product_line
order by total_revenue desc
limit 1;

-- 9.In which city was the highest revenue recorded?
select city,sum(total) as h_revenue
from sales_table
group by city 
order by h_revenue desc
limit 1;

-- 10.Which product line incurred the highest Value Added Tax?
select product_line,sum(tax) as total_VDT from sales_table
group by product_line
order by total_VDT desc
limit 1;

-- 12.Identify the branch that exceeded the average number of products sold.
select branch,sum(quantity) as t_p_s from sales_table
group by branch
having sum(quantity)> (select avg(quantity) from sales_table);

-- 14.Calculate the average rating for each product line.
select product_line,avg(rating) as ave_rating from sales_table
group by product_line;

-- 16.Identify the customer type contributing the highest revenue.
select customer_type, sum(total) as highest_rev
from sales_table
group by customer_type
order by highest_rev desc
limit 1;

-- 17.Determine the city with the highest VAT percentage.
select city ,avg(tax) as asv_vat 
from sales_table
group by CITY
order by ASV_VAT desc
limit 1;


-- 18.Identify the customer type with the highest VAT payments.
select customer_type,sum(tax) as highest_pay 
from sales_table
group by customer_type
order by highest_pay desc
limit 1;

-- 19.What is the count of distinct customer types in the dataset?
select count(distinct customer_type) as dis_typ from sales_table;

-- 20.What is the count of distinct payment methods in the dataset?
select count(distinct payment_method) as dis_pay from sales_table;






