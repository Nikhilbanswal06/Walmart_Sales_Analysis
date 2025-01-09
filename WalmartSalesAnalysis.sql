-- CREATE TABLE AND DATABASE

CREATE DATABASE IF NOT EXISTS walmart_sales;

CREATE TABLE IF NOT EXISTS sales(
		invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
        branch VARCHAR(10) NOT NULL,
        city VARCHAR(30) NOT NULL,
        customer_type VARCHAR(30) NOT NULL,
        gender VARCHAR(10) NOT NULL,
        product_line VARCHAR(100) NOT NUll,
        unit_price DECIMAL(10,2) NOT NULL,
        quantity INT NOT NULL,
        vat FLOAT(6,4) NOT NULL,
        total DECIMAL(12,4) NOT NULL,
        date DATETIME NOT NULL,
        time TIME NOT NULL,
        payment_method VARCHAR(20) NOT NULL,
        COGS DECIMAL(10,2) NOT NULL,
        gross_margin_percentage FLOAT(11,9),
        gross_income DECIMAL(10,2),
        rating FLOAT(2,1));
        
-- IMPORT DATA INTO TABLE FROM EXTERNAL SOURCE        
        

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------QUESTIONS--------------------------------------------------------------------------

-- Q1) HOW MANY UNIQUE CITIES DOES DATA HAVE?

SELECT COUNT(DISTINCT city)
FROM sales;


-- Q2) HOW MANY UNIQUE PRODUCT LINES DOES THE DATA HAVE?

SELECT COUNT(DISTINCT product_line)
FROM sales;


-- Q3) WHAT IS THE MOST COMMON PAYING METHOD?

SELECT payment_method,COUNT(payment_method) AS number_of_transaction
FROM sales
GROUP BY payment_method
ORDER BY COUNT(payment_method) DESC
LIMIT 1;


-- Q4)WHAT IS THE MOST SELLING PRODUCT LINE?

SELECT product_line,COUNT(product_line)	AS items_sold
FROM sales
GROUP BY product_line
ORDER BY COUNT(product_line) DESC
LIMIT 1;


-- Q5) WHAT IS THE TOTAL REVENUE BY MONTH?

SELECT month, SUM(total) AS total_revenue
FROM sales
GROUP BY month
ORDER BY total_revenue;


-- Q6) NUMBER OF BRANCHES IN EACH CITY?

SELECT city, COUNT(branch) AS branches
FROM sales
GROUP BY city;


-- Q7) WHICH MONTH HAD THE LARGEST COGS?

SELECT month, SUM(cogs) AS cogs
FROM sales
GROUP BY month 
ORDER BY cogs DESC;


-- Q8) WHICH PRODUCT LINE HAD THE LARGEST REVENUE?

SELECT product_line, SUM(total) AS revenue
FROM sales
GROUP BY product_line
ORDER BY revenue DESC;


-- Q9) WHICH CITY HAD THE LARGEST REVENUE?

SELECT city, SUM(total) AS revenue
FROM sales
GROUP BY city
ORDER BY revenue DESC;


-- Q10) WHAT PRODUCT LINE HAD THE LARGEST VAT?

SELECT product_line, SUM(vat) AS vat
FROM sales
GROUP BY product_line
ORDER BY vat DESC;


-- Q11) WHICH BRANCH SOLD MORE PRODUCTS THAN THE AVERAGE PRODUCT SOLD?

SELECT branch, sum(quantity) AS quantity
FROM sales
GROUP BY branch
HAVING quantity > (SELECT AVG(quantity) FROM sales);


-- Q12) WHAT IS THE MOST COMMON PRODUCT LINE BY GENDER

SELECT gender,product_line,count(gender) AS item_sold
FROM sales
GROUP BY product_line,gender
ORDER BY item_sold DESC;


-- Q13) WHAT IS THE AVERAGE RATING OF EACH PRODUCT LINE?

SELECT product_line, ROUND(AVG(rating),2) AS average_rating
FROM sales
GROUP BY product_line
ORDER BY average_rating;


-- Q14) WHAT IS THE SALE ON MONDAY IN EACH TIME OF THE DAY?

SELECT time_of_day, COUNT(time_of_day) AS sale
FROM sales 
WHERE day = 'monday'
GROUP BY  time_of_day
ORDER BY sale;


-- Q15) WHICH CONSUMER TYPE BRINGS THE MOST REVENUE?

SELECT customer_type, ROUND(SUM(total), 2) AS revenue
FROM sales
GROUP BY customer_type
ORDER BY revenue;


-- Q16) WHICH CITY HAS THE LARGEST TAX PERCENTAGE?

SELECT city, AVG(vat) AS vat
FROM sales
GROUP BY city
ORDER BY vat DESC;


-- Q17) WHICH CUSTOMER TYPE PAYS THE MOST TAX?

SELECT customer_type, SUM(vat) AS vat 
FROM sales
GROUP BY customer_type
ORDER BY vat DESC;


-- Q18) HOW MANY UNIQUE CUSTOMERS DOES THE DATA HAVE?

SELECT DISTINCT(customer_type) AS customer_type
FROM sales;


-- Q19) HOW MANY UNIQUE PAYMENT METHODS DOES THE DATA HAVE?

SELECT DISTINCT payment_method
FROM sales;


-- Q20) WHAT IS THE MOST COMMON CUSTOMER TYPE ?

SELECT customer_type, COUNT(customer_type) 
FROM sales
GROUP BY customer_type
ORDER BY COUNT(customer_type) DESC;


-- Q21) WHICH CUSTOMER TYPE BUYS THE MOST ITEMS?

SELECT customer_type, SUM(quantity) AS items_purchased
FROM sales
GROUP BY customer_type
ORDER BY items_purchased DESC;


-- Q21) WHAT IS THE GENDER DISTRIBUTION PER BRANCH?

SELECT branch,gender,count(gender) AS customers
FROM sales
GROUP BY branch, gender
ORDER BY branch;


-- Q22) WHICH TIME OF THE DAY RECIEVES MOST RATING ?

SELECT time_of_day, ROUND(AVG(rating),2) AS rating
FROM sales
GROUP BY time_of_day
ORDER BY rating DESC;


-- Q23) WHICH DAY OF THE WEEK HAS THE BEST AVERAGE RATING?

SELECT day, AVG(rating) AS avg_rating
FROM sales
GROUP BY day
ORDER BY AVG(rating) DESC;


-- Q24) WHICH DAY OF THE WEEK HAS THE BEST AVERAGE RATINGS PER BRANCH?

SELECT branch,day,AVG(rating)
FROM sales 
GROUP BY branch, day
ORDER BY branch, AVG(rating) DESC
