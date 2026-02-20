with item_counts as (
select category ,
item_purchased,
COUNT (customer_id) as total_orders,
ROW_NUMBER() over(partition by category order by count (customer_id) desc) as item_rank
from customer 
group by category ,item_purchased 


select item_rank,category,item_purchased ,total_orders
from item_counts
where item_rank <= 3;


select item_purchased,
ROUND(100.0*
	count(*) FILTER (WHERE discount_applied ='Yes')/count(*)
,2) as discount_rate
from customer
group by item_purchased
order by discount_rate desc 
limit 5;



select subscription_status,
count(customer_id) as total_customer,
ROUND(AVG(purchase_amount),2) as avg_spend,
ROUND(SUM(Purchase_amount),2) as total_spend
from customer
group by subscription_status
order by total_spend, avg_spend desc


select shipping_type,Round(Avg(purchase_amount),2)
from customer 
where shipping_type in ( 'Express',  'Free Shipping',   'Next Day Air',       'Standard',
 '2-Day Shipping')
group by shipping_type