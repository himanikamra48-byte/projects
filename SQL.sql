-- Q1 Write a query to display customer full name with their title (Mr/Ms), 
-- both first name and last name are in upper case, customer email id, 
-- customer creation date and display customer’s category after applying below 
-- categorization rules: 
-- 1) IF customer creation date Year <2005 Then Category A 
-- 2) IF customer creation date Year >=2005 and <2011 Then Category B 
-- 3) IF customer creation date Year>= 2011 Then Category C

SELECT * FROM online_customer;
SELECT 
CONCAT((CASE WHEN CUSTOMER_GENDER='F' THEN 'Ms.' ELSE 'Mr.' END),'', UPPER(CUSTOMER_FNAME), '',UPPER(CUSTOMER_LNAME)) AS CUSTOMER_FULL_NAME, CUSTOMER_EMAIL, CUSTOMER_CREATION_DATE,
CASE
WHEN  YEAR(CUSTOMER_CREATION_DATE) < 2005 THEN 'CATEGORY A'
WHEN YEAR(CUSTOMER_CREATION_DATE) >= 2005 AND YEAR(CUSTOMER_CREATION_DATE) < 2011 THEN 'CATEGORY B'
ELSE 'CATEGORY C'
END AS CATEGORY
FROM online_customer;

-- Q2 Write a query to display the following information for the products, which have not been sold: 
-- product_id, product_desc, product_quantity_avail, product_price, inventory values 
-- (product_quantity_avail*product_price), New_Price after applying discount as per below criteria. 
-- Sort the output with respect to decreasing value of Inventory_Value. 
-- 1) IF Product Price > 200,000 then apply 20% discount 
-- 2) IF Product Price > 100,000 then apply 15% discount 
-- 3) IF Product Price =< 100,000 then apply 10% discount

SELECT * FROM order_items;
SELECT * FROM product;
ALTER TABLE product ADD INVENTORY_VALUES INT;
SELECT PRODUCT_ID, PRODUCT_DESC, PRODUCT_QUANTITY_AVAIL, PRODUCT_PRICE, (PRODUCT_QUANTITY_AVAIL*PRODUCT_PRICE) AS INVENTORY_VALUES,
CASE
WHEN PRODUCT_PRICE > 20000 THEN PRODUCT_QUANTITY_AVAIL*PRODUCT_PRICE*0.80
WHEN PRODUCT_PRICE > 10000 THEN PRODUCT_QUANTITY_AVAIL*PRODUCT_PRICE*0.85
WHEN PRODUCT_PRICE <= 10000 THEN PRODUCT_QUANTITY_AVAIL*PRODUCT_PRICE*0.90
ELSE 'NULL'
END AS NEW_PRICE
FROM product
WHERE product.PRODUCT_ID NOT IN (
SELECT order_items.PRODUCT_ID 
FROM order_items)
ORDER BY INVENTORY_VALUES DESC;

-- Q3. Write a query to display Product_class_code, Product_class_description, Count of Product type in 
-- each product 
-- class, Inventory Value (p.product_quantity_avail*p.product_price). Information should be 
-- displayed for only those product_class_code which have more than 1,00,000 
-- Inventory Value. Sort the output with respect to decreasing value of Inventory_Value

SELECT * FROM product_class;
SELECT COUNT(PRODUCT_CLASS_DESC) FROM product_class;

SELECT product_class.PRODUCT_CLASS_CODE, product_class.PRODUCT_CLASS_DESC, COUNT(product_class.PRODUCT_CLASS_DESC) AS NUMBER_OF_PRODUCT, (product.PRODUCT_QUANTITY_AVAIL*product.PRODUCT_PRICE) AS INVENTORY_VALUE
FROM product
JOIN product_class 
ON product.PRODUCT_CLASS_CODE = product_class.PRODUCT_CLASS_CODE
GROUP BY PRODUCT_CLASS_CODE
HAVING INVENTORY_VALUE > 100000
ORDER BY INVENTORY_VALUE DESC;

-- Q4. Write a query to display customer_id, full name, customer_email, customer_phone and country of 
-- customers who 
-- have cancelled all the orders placed by them

SELECT * FROM ORDER_HEADER;
SELECT online_customer.CUSTOMER_ID, CONCAT(UPPER(CUSTOMER_FNAME), '',UPPER(CUSTOMER_LNAME)) AS FULL_NAME, online_customer.CUSTOMER_EMAIL, online_customer.CUSTOMER_PHONE,
(SELECT COUNTRY FROM ADDRESS WHERE address.ADDRESS_ID = online_customer.ADDRESS_ID) AS COUNTRY
FROM 
ONLINE_CUSTOMER
WHERE online_customer.CUSTOMER_ID IN (
SELECT order_header.CUSTOMER_ID
FROM order_header
WHERE ORDER_STATUS = 'Cancelled'); 

-- Q5. Write a query to display Shipper name, City to which it is catering, num of customer catered by the 
-- shipper in the city and number of consignments delivered to that city for Shipper DHL 

SELECT * FROM shipper;
SELECT shipper.SHIPPER_NAME, address.CITY, COUNT(DISTINCT online_customer.CUSTOMER_ID) AS NO_OF_CUSTOMERS_CATERED, COUNT(order_header.ORDER_STATUS) AS NUMBER_OF_CONSIGNMENTS_DELIVERED
FROM online_customer
JOIN order_header ON order_header.CUSTOMER_ID = online_customer.CUSTOMER_ID
JOIN shipper ON shipper.SHIPPER_ID = order_header.SHIPPER_ID
JOIN address ON address.ADDRESS_ID = online_customer.ADDRESS_ID
WHERE order_header.ORDER_STATUS = 'Shipped' 
GROUP BY address.CITY
HAVING shipper.SHIPPER_NAME = 'DHL'; 

-- Q7. Write a query to display order_id and volume of the biggest order (in terms of volume) that can fit in carton id 10 
SELECT order_items.ORDER_ID, carton.CARTON_ID, (product.LEN*product.WIDTH*product.HEIGHT) AS VOLUME
FROM order_items
JOIN product ON order_items.PRODUCT_ID = product.PRODUCT_ID
JOIN carton
WHERE carton.CARTON_ID = 10
ORDER BY  VOLUME DESC;

-- Q8. Write a query to display customer id, customer full name, total quantity and total value (quantity*price) shipped 
-- where mode of payment is Cash and customer last name starts with 'G'

SELECT ONLINE_CUSTOMER.CUSTOMER_ID, CONCAT((CUSTOMER_FNAME), ' ',(CUSTOMER_LNAME)) AS FULL_NAME, SUM(ORDER_ITEMS.PRODUCT_QUANTITY) AS TOTAL_QUANTITY, (PRODUCT.PRODUCT_PRICE*order_items.PRODUCT_QUANTITY) AS TOTAL_VALUE
FROM ONLINE_CUSTOMER
JOIN ORDER_HEADER ON ORDER_HEADER.CUSTOMER_ID = online_customer.CUSTOMER_ID
JOIN ORDER_ITEMS
JOIN product
WHERE order_header.PAYMENT_MODE = 'CASH' AND SUBSTR(online_customer.CUSTOMER_LNAME,1,1) IN ('G') AND order_header.ORDER_STATUS = 'Shipped';

-- Q9.  Write a query to display product_id, product_desc and total quantity of products 
-- which are sold together with product id 201 and are not shipped to city Bangalore and New Delhi. 
-- Display the output in descending order with respect to tot_qty. 

SELECT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_DESC, SUM(order_items.PRODUCT_QUANTITY) AS TOTAL_QUANTITY, ADDRESS.CITY, order_header.ORDER_STATUS
FROM order_items
JOIN ORDER_HEADER ON ORDER_HEADER.ORDER_ID = ORDER_ITEMS.ORDER_ID
JOIN online_customer ON online_customer.CUSTOMER_ID = order_header.CUSTOMER_ID
JOIN PRODUCT ON product.PRODUCT_ID = order_items.PRODUCT_ID
JOIN product_class ON product_class.PRODUCT_CLASS_CODE = PRODUCT.PRODUCT_CLASS_CODE
JOIN ADDRESS ON address.ADDRESS_ID = online_customer.ADDRESS_ID
WHERE order_items.ORDER_ID IN (
SELECT ORDER_ID FROM ORDER_ITEMS 
WHERE PRODUCT.PRODUCT_ID = 201 AND ADDRESS.CITY NOT IN ('BANGALORE', 'NEW DELHI') AND order_header.ORDER_STATUS = 'Shipped')
GROUP BY PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_DESC
ORDER BY TOTAL_QUANTITY DESC;

-- Q10. Write a query to display the order_id,customer_id and customer fullname 
 -- as total quantity of products shipped for order ids which are even 
 -- and shipped to address where pincode is not starting with "5"
 
 SELECT online_customer.CUSTOMER_ID, CONCAT((CUSTOMER_FNAME), ' ',(CUSTOMER_LNAME)) AS FULL_NAME, ORDER_ITEMS.PRODUCT_QUANTITY AS TOTAL_QUANTITY, order_items.ORDER_ID, ADDRESS.PINCODE, ORDER_HEADER.ORDER_STATUS
 FROM online_customer
 JOIN order_header ON online_customer.CUSTOMER_ID = order_header.CUSTOMER_ID
 JOIN order_items ON order_header.ORDER_ID = ORDER_ITEMS.ORDER_ID
 JOIN address ON address.ADDRESS_ID = online_customer.ADDRESS_ID
 WHERE MOD(ORDER_ITEMS.ORDER_ID,2) = 0 AND ADDRESS.PINCODE NOT LIKE '5%' AND order_header.ORDER_STATUS = 'Shipped';
 
