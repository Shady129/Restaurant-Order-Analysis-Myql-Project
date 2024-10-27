use projects;


-- View the menue items table
SELECT * FROM menu;

-- Find The Number Of Items On The Menu

SELECT COUNT(product_name) AS  NumberOfItems
FROM menu;


-- What Are The Least & Most Expensive Item On Menu

-- Cheapest item 

SELECT MIN(price) AS CheapestItem
FROM  menu;

SELECT  product_name, MIN(price) AS CheapestItem
FROM  menu
GROUP BY product_name
ORDER BY CheapestItem
limit 1;


-- Most Expensive Product

SELECT product_name, MAX(price) AS 'Most Expensive Product'
FROM menu
GROUP BY product_name
ORDER BY  MostExpensive DESC
limit 1;



-- How Many Italian Dishes Are On The Menu?

SELECT * FROM menu_items;

SELECT COUNT(category) AS 'How Many Italian Dishes'
FROM menu_items;


-- How Many Dishes Are In Each Category?

SELECT category, COUNT(item_name) AS 'Dishes'
FROM menu_items
GROUP BY  category;
 

-- What Is The Average Dish Price With Each Category? 
SELECT category, ROUND(AVG(price)) AS 'Average Dish Price' 
FROM menu_items
GROUP BY category;


-- What Are The Most Expensive Italian Dishes On Menu

SELECT item_name, category ,MAX(price) AS 'Most Expensive Product'
FROM menu_items
GROUP BY item_name, category
HAVING category = "Italian"
ORDER BY MAX(price) DESC;




-- What Are The Least Italian Dishes On Menu
SELECT item_name, category ,MAX(price) AS 'Most Expensive Product'
FROM menu_items
GROUP BY item_name, category
HAVING category = "Italian"
ORDER BY MAX(price);



-- View order_details Table:

SELECT * FROM  order_details;


-- What is The Date Range Of The Table?

SELECT 
    MIN(order_date) AS 'Beginning Date' , MAX(order_date) AS 'Ending Date'
FROM
    order_details;
    
    
-- How Many Orders Were Made Within This Date Range?

    SELECT * FROM  order_details;

SELECT 
    COUNT(order_id)
FROM
    order_details;
    


-- How Many Items Were Made Within This Date Range?

SELECT 
    COUNT(item_id)
FROM
    order_details;
    



-- Which Order UPDATE `projects`.`order_details`


SELECT * FROM menu;
SELECT * FROM menu_items;
SELECT * FROM order_details;



-- Rename Column In menu_items:

ALTER TABLE menu_items 
CHANGE ï»؟menu_item_id  menu_item_id INT;


-- Rename Column In menu_items 

ALTER TABLE order_details
CHANGE ï»؟order_details_id order_details_id INT;



-- Combine Menu Items And Order Details:


SELECT * 
FROM menu_items mi
JOIN order_details od
ON mi.menu_item_id  = od.item_id;




-- What Were The Most Ordered item? What categories Were They in? 


SELECT item_name, COUNT(od.order_id) num_purchases, category   -- Item Name = Hamburger,  Category = American
FROM menu_items mi
JOIN order_details od
ON mi.menu_item_id  = od.item_id
GROUP BY item_name, category
ORDER BY COUNT(od.order_id) DESC
LIMIT 1;



-- What Were The Least And Most Ordered item? What categories Were They in? 


SELECT item_name, COUNT(od.order_id) AS num_purchases, category  -- Item Name = Chicken Tacos -  Category =  Mexican.
FROM menu_items mi
JOIN order_details od
ON mi.menu_item_id  = od.item_id
GROUP BY item_name, category
ORDER BY COUNT(od.order_id)
LIMIT 1;



-- What Were The Top 5 Orders That Spent The Most Money?

 SELECT od.order_id, ROUND(SUM(mi.price)) AS total_spent
FROM menu_items mi
JOIN order_details od
ON mi.menu_item_id  = od.item_id
GROUP BY od.order_id
ORDER BY ROUND(SUM(mi.price)) DESC
limit 5;


-- What Were The least 5 Orders That Spent The Most Money?

 SELECT od.order_id, ROUND(SUM(mi.price)) AS total_spent
FROM menu_items mi
JOIN order_details od
ON mi.menu_item_id  = od.item_id
GROUP BY od.order_id
ORDER BY ROUND(SUM(mi.price)) 
limit 5;



-- How Many Orders For Each Item

SELECT mi.item_name ,COUNT(DISTINCT od.order_id) no_of_orders
FROM 
menu_items AS mi 
JOIN  order_details AS od
ON mi.menu_item_id  = od.item_id
GROUP BY mi.item_name
ORDER BY no_of_orders DESC;



-- Show Items For Each Order

WITH Cte AS(
SELECT od.order_id, COUNT(mi.item_name) AS no_of_orders, mi.item_name
FROM 
menu_items AS mi 
JOIN  order_details AS od
ON mi.menu_item_id  = od.item_id
GROUP BY od.order_id, mi.item_name)
SELECT * , 
ROW_NUMBER() OVER(PARTITION BY  order_id ORDER BY  order_id) rn
FROM Cte;



-- View the details of the highest spend order 

-- Step One: Top Orders That Spent The Most Money?

 SELECT od.order_id, ROUND(SUM(mi.price)) AS total_spent
FROM menu_items mi
JOIN order_details od
ON mi.menu_item_id  = od.item_id
GROUP BY od.order_id
ORDER BY ROUND(SUM(mi.price)) DESC
limit 5;


-- Step Two: The top orders that spent the most money were in Italian cuisine. 

SELECT od.order_id,mi.category, COUNT(od.item_id) AS num_orders
FROM menu_items mi
JOIN order_details od
ON mi.menu_item_id  = od.item_id
WHERE od.order_id = 440
GROUP BY mi.category
ORDER BY COUNT(od.item_id) DESC;


-- The top 5 orders that spent the most money were in [Italian , American, Asian, Mexican] cuisine.
 

SELECT mi.category, COUNT(od.item_id) AS num_orders
FROM menu_items mi
JOIN order_details od
ON mi.menu_item_id  = od.item_id
WHERE od.order_id IN(440, 2075, 1957, 330, 2675)
GROUP BY mi.category;









SELECT * 
FROM menu_items mi
JOIN order_details od
ON mi.menu_item_id  = od.item_id;




