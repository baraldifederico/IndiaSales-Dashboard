select * from sales.customers;
select * from sales.products;
select * from sales.markets;
select * from sales.date;
select * from sales.transactions;

select count(*) from sales.transactions;
select count(*) from sales.customers;
select count(*) from sales.transactions 
where market_code like "Mark001";

select * from sales.customers;
select * from sales.customers
where customer_code is null or custmer_name is null or customer_type is null;
select customer_type, count(*) from sales.customers
group by customer_type;
ALTER TABLE sales.customers
RENAME COLUMN custmer_name TO customer_name;
select customer_name, count(*) from sales.customers
group by customer_name
order by customer_name DESC;

select * from sales.products;
select * from sales.products
where product_code is null or product_type is null;
select product_type, count(*) from sales.products
group by product_type
order by product_type DESC;

select * from sales.markets;
select * from sales.markets
where zone like "South";
UPDATE sales.markets
SET zone = "India - South"
WHERE zone like "South";
UPDATE sales.markets
SET zone = "India - Central"
WHERE zone like "Central";
UPDATE sales.markets
SET zone = "India - North"
WHERE zone like "North";
UPDATE sales.markets
SET zone = "USA"
WHERE markets_name like "New York";
UPDATE sales.markets
SET zone = "France"
WHERE markets_name like "Paris";
select * from sales.markets as a
inner join sales.markets as b
on a.markets_name=b.markets_name
where a.markets_code <> b.markets_code;
select * from sales.markets as a
inner join sales.markets as b
on a.markets_name=b.markets_name
where a.zone <> b.zone;

select * from sales.date;
select * from sales.date
where date is null or cy_date is null or year is null or month_name is null or date_yy_mmm is null;
select * from sales.date
where year(sales.date.date) <> sales.date.year;
select * from sales.date
where monthname(sales.date.date) <> sales.date.month_name;

select * from sales.transactions;
select * from sales.transactions
where product_code is null or customer_code is null or market_code is null
 or order_date is null or sales_qty is null or sales_amount is null or currency is null;
select count(*) from sales.transactions
where sales_amount <=0;
UPDATE sales.transactions
SET sales_amount = sales_amount*(-1)
WHERE sales_amount <0;
select count(*) from sales.transactions
where currency like "INR";
select *, round((sales_amount*0.013),2) from sales.transactions
where currency like "INR";
UPDATE sales.transactions
SET sales_amount = round((sales_amount*0.013),2)
WHERE currency like "INR";
UPDATE sales.transactions
SET currency = "USD"
WHERE currency like "INR";
select * from sales.transactions
where currency like "INR%";
UPDATE sales.transactions
SET sales_amount = round((sales_amount*0.013),2)
WHERE currency like "INR%";
UPDATE sales.transactions
SET currency = "USD"
WHERE currency like "INR%";
select count(*) from sales.transactions
group by currency;
UPDATE sales.transactions
SET currency = "USD";
select *, count(*) from sales.transactions
where sales_amount <=1
group by sales_amount;
select *, count(*) from sales.transactions
where sales_amount <=0.01
group by sales_amount;
delete from sales.transactions
where sales_amount <=0.01;
select *, format(sales_amount, 2) from sales.transactions;
ALTER TABLE sales.transactions 
MODIFY COLUMN sales_amount DECIMAL(8,2);
select * from sales.transactions;

select * from sales.date;
select * from sales.transactions;

select order_date from sales.transactions
left outer join sales.date
on sales.transactions.order_date=sales.date.date;
insert into sales.date (date)
select order_date from sales.transactions
left outer join sales.date
on sales.transactions.order_date=sales.date.date;
UPDATE sales.date
SET sales.date.year = year(sales.date.date)
WHERE sales.date.year is null;
UPDATE sales.date
SET sales.date.month_name = monthname(sales.date.date)
WHERE sales.date.month_name is null;
UPDATE sales.date
SET sales.date.cy_date = (sales.date.date-day(sales.date.date)+1)
WHERE sales.date.cy_date is null;
select *, substring(concat(year(sales.date.date),"-", monthname(sales.date.date)),3,6) from sales.date;
UPDATE sales.date
SET sales.date.date_yy_mmm = (substring(concat(year(sales.date.date),"-", monthname(sales.date.date)),3,6))
WHERE sales.date.date_yy_mmm is null;

CREATE TABLE distinct_date SELECT DISTINCT * FROM sales.date order by sales.date.date;
select * from sales.distinct_date;
 
select count(*), sum(sales.transactions.sales_amount) from sales.transactions
inner join sales.distinct_date
on sales.transactions.order_date=sales.distinct_date.date
where sales.distinct_date.year=2017;

select count(*), sum(sales.transactions.sales_amount) from sales.transactions;

select year(sales.transactions.order_date), count(*), sum(sales.transactions.sales_amount) from sales.transactions
group by year(sales.transactions.order_date);

select * from sales.transactions
where sales_amount > 1000;


select *, format(sales_amount, 2) from sales.transactions;