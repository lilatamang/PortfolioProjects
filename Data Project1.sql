SELECT * FROM data_analyst.`superstoreus-2015`;
-- High prority orders result in higher customer satisfaction--
SELECT `CUSTOMER_ID`, COUNT(`Order_ID`) AS `Repeat_Orders`
FROM `data_analyst`.`superstoreus-2015`
WHERE `ORDER_PRIORITY` = 'High'
GROUP BY `CUSTOMER_ID`
ORDER BY `Repeat_Orders` DESC;
-- shipping costs vary significantly across different regions
SELECT `REGION`, AVG(`SHIPPING_COST`) AS `Average_Shipping_Cost`
FROM `data_analyst`.`superstoreus-2015`
GROUP BY `REGION`
ORDER BY `Average_Shipping_Cost` DESC;
--discounts lead to an increase in total sales volume--
SELECT DISCOUNT, 
SUM(SALES) AS Total_Sales_Volume, 
COUNT(ORDER_ID) AS Number_of_Orders
FROM `data_analyst`.`superstoreus-2015`
GROUP BY DISCOUNT
ORDER BY DISCOUNT;
--certain product categories yield higher profits--
SELECT Product_Category, 
SUM(Profit) AS Total_Profit
FROM `data_analyst`.`superstoreus-2015`
GROUP BY Product_Category
ORDER BY Total_Profit DESC;

ALTER TABLE `data_analyst`.`superstoreus-2015` ADD `Total_Sales` DOUBLE;
UPDATE `data_analyst`.`superstoreus-2015`
SET `Total_Sales` = (`UNIT_PRICE` * `QUANTITY_ORDER`) - `DISCOUNT`;

SELECT `Customer_ID`
FROM `data_analyst`.`superstoreus-2015`
LIMIT 10;
SELECT *
FROM `data_analyst`.`superstoreus-2015`
LIMIT 10;

--The top product in each category based on total sales--
SELECT `Product_Category`, `Product_Name`, `Total_Sales`
FROM (
SELECT `Product_Category`, `Product_Name`, SUM(`Sales`) AS `Total_Sales`,
ROW_NUMBER() OVER (PARTITION BY `Product_Category` ORDER BY SUM(`Sales`) DESC) AS `rank`
FROM `data_analyst`.`superstoreus-2015`
GROUP BY `Product_Category`, `Product_Name`
) ranked_products
WHERE `rank` = 1;
--Identifying products with the highest profit margins--
SELECT `PRODUCT_NAME`, SUM(`PROFIT`) AS `Total_Profit`
FROM `data_analyst`.`superstoreus-2015`
GROUP BY `PRODUCT_NAME`
ORDER BY `Total_Profit` DESC
LIMIT 10;


USE `data_analyst`;

SELECT COUNT(DISTINCT CITY)
FROM `superstoreus-2015`
WHERE COUNTRY = 'USA';

SHOW COLUMNS FROM `superstoreus-2015`;

SELECT DISTINCT COUNTRY 
FROM `superstoreus-2015`;

SELECT CITY, COUNTRY 
FROM `superstoreus-2015` 
LIMIT 10;

SELECT COUNT(*)
FROM `superstoreus-2015`
WHERE COUNTRY = 'USA';

SELECT CITY
FROM `superstoreus-2015`
WHERE COUNTRY = 'USA'
LIMIT 3;

SELECT DISCOUNT, 
SUM(SALES) AS Total_Sales, 
SUM(QUANTITY_ORDERED_NEW) AS Total_Quantity
FROM `data_analyst`.`superstoreus-2015`
GROUP BY DISCOUNT
ORDER BY DISCOUNT;

-- Top 5 Customers by sales--
SELECT `CUSTOMER_NAME`, 
SUM(`UNIT_PRICE` * `Quantity_ordered_new` - `DISCOUNT`) AS `Total_Sales`
FROM `data_analyst`.`superstoreus-2015`
GROUP BY `CUSTOMER_NAME`
ORDER BY `Total_Sales` DESC
LIMIT 5;

ALTER TABLE `data_analyst`.`customers`
ADD PRIMARY KEY (`CUSTOMER_ID`);

--join orders with customers--
SELECT o.ORDER_ID, o.ORDER_DATE, o.SALES, c.CUSTOMER_NAME
FROM `data_analyst`.`orders` AS o
LEFT JOIN `data_analyst`.`customers` AS c
ON o.CUSTOMER_ID = c.CUSTOMER_ID;

--join orders with customers--
SELECT o.ORDER_ID, o.ORDER_DATE, o.SALES, c.CUSTOMER_NAME
FROM `data_analyst`.`orders` AS o
LEFT JOIN `data_analyst`.`customers` AS c
ON o.CUSTOMER_ID = c.CUSTOMER_ID
LIMIT 1000;
--join orders with region and group by regions--
SELECT r.REGION, 
COUNT(o.ORDER_ID) AS Number_of_Orders, 
SUM(o.SALES) AS Total_Sales
FROM `data_analyst`.`orders` AS o
LEFT JOIN `data_analyst`.`superstoreus-2015` AS r
ON o.State_or_Province = r.State_or_Province
GROUP BY r.REGION
LIMIT 1000;













