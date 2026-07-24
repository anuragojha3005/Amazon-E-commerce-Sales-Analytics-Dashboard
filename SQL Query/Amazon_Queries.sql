create database AmazonAnalystic
go

use AmazonAnalystic
go

SELECT TOP 10 *
FROM amazon_sales;

select count(*) as totalorders
from amazon_sales

EXEC sp_help amazon_sales;

select sum(final_price) as  TotalRevenue
from amazon_sales

select count(*) as TotalOrders
from amazon_sales

select count(distinct USER_ID) as Customers
from amazon_sales

select count(distinct product_id) as Products
from amazon_sales

select avg(final_price) as AvgOrderValue
from amazon_sales


/* Revenue By Category*/

select category, sum(final_price) as Revenue
from amazon_sales
group by category
order by revenue desc


/* Order By Category*/

select category, count(*) as Orders
from amazon_sales
group by category
order by Orders desc

/* Average Price*/

select category, avg(price) as AvgPrice
from amazon_sales
group by category
order by AvgPrice desc

/* Average Discount */

select category, avg(discount) as AvgDiscount
from amazon_sales
group by category
order by AvgDiscount desc

/* Average Rating*/
select category, avg(rating) as AvgRating
from amazon_sales
group by category
order by AvgRating desc

/*Top 10 Brand */
select top 10 brand,sum(final_price) as Revenue
from amazon_sales
group by brand
order by Revenue desc

/*Most Reviewed Brands*/
select brand, sum(review_count) as Review
from amazon_sales
group by brand
order by Review desc

/*Highest Rated Brands*/
select brand, AVG(rating) as Rating
from amazon_sales
group by brand
order by Rating desc

/* Top Seller*/
select top 10 seller_id, sum(final_price) as Revenue
from amazon_sales
group by seller_id
order by Revenue desc

/*Lowest Rated Sellers*/
SELECT TOP 10
seller_id,
AVG(seller_rating) AS Rating
FROM amazon_sales
GROUP BY seller_id
ORDER BY Rating;

/*Revenue by City*/
SELECT
location,
SUM(final_price) Revenue
FROM amazon_sales
GROUP BY location
ORDER BY Revenue DESC;

/*Orders by Device*/
SELECT device,
COUNT(*) Orders
FROM amazon_sales
GROUP BY device;

/*Orders by Payment Method*/
SELECT payment_method,
COUNT(*) Orders
FROM amazon_sales
GROUP BY payment_method;

/*Overall Return Rate*/
SELECT
AVG(CAST(is_returned AS FLOAT))*100 AS ReturnRate
FROM amazon_sales;

/*Returns by Category*/
SELECT category,
AVG(CAST(is_returned AS FLOAT))*100 AS ReturnRate
FROM amazon_sales
GROUP BY category
ORDER BY ReturnRate DESC;

/*Returns by Shipping Speed*/
SELECT
shipping_speed,
AVG(CAST(is_returned AS FLOAT))*100 AS ReturnRate
FROM amazon_sales
GROUP BY shipping_speed;

/*Returns by Rating Category*/
SELECT
rating_category,
AVG(CAST(is_returned AS FLOAT))*100 ReturnRate
FROM amazon_sales
GROUP BY rating_category;

/*Monthly Sales*/
select Year, Month, sum(final_price) Revenue
from amazon_sales
group by Year,Month
order by Year,Month

/* Top Seller Ranking */
SELECT
seller_id,
SUM(final_price) Revenue,
RANK() OVER(
ORDER BY SUM(final_price) DESC
) SellerRank
FROM amazon_sales
GROUP BY seller_id;

/* Top Brand Ranking */
SELECT
brand,
SUM(final_price) Revenue,
DENSE_RANK() OVER(
ORDER BY SUM(final_price) DESC
) RankNo
FROM amazon_sales
GROUP BY brand;

/*Order Value Classification*/
SELECT
product_id,
final_price,
CASE
WHEN final_price <1000 THEN 'Budget'
WHEN final_price<5000 THEN 'Mid Range'
ELSE 'Premium'
END AS PriceSegment
FROM amazon_sales;

/*Top Categories (CTEs)*/
WITH CategoryRevenue AS
(
SELECT
category,
SUM(final_price) Revenue
FROM amazon_sales
GROUP BY category
)
SELECT *
FROM CategoryRevenue
ORDER BY Revenue DESC;

/*Executive Dashboard View*/
CREATE VIEW vw_ExecutiveDashboard AS
SELECT
COUNT(*) TotalOrders,
SUM(final_price) TotalRevenue,
AVG(final_price) AvgOrderValue,
AVG(rating) AvgRating,
AVG(CAST(is_returned AS FLOAT))*100 ReturnRate
FROM amazon_sales;

SELECT *
FROM vw_ExecutiveDashboard;