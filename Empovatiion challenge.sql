--- Write a query to count the Total Number of Orders Per Customer order in desc.
SELECT 
	c.Customer_Key,
	c.Name AS Customer_Name,
	COUNT(DISTINCT s.Order_Number) AS Total_Orders
FROM customers c
JOIN sales s ON c.Customer_Key = s.Customer_Key
GROUP BY c.Customer_Key, c.Name
ORDER BY Total_Orders DESC;


--- Write a SQL query to List of Products Sold in 2020
SELECT 
	DISTINCT p.Product_Key, 
	p.Product_Name
FROM sales s
JOIN products p ON s.Product_Key = p.Product_Key
WHERE EXTRACT (YEAR FROM s.Order_Date )= 2020;


--- Write a query to find all Customer Details from California (CA)
SELECT *
FROM customers
WHERE state = 'California' and State_code = 'CA';


--- Write a query to calculate the Total Sales Quantity for product 2115
SELECT 
	Product_key,
	SUM(Quantity) AS Total_Sales_Quantity
FROM sales s
WHERE Product_Key = 2115
GROUP BY Product_key


--- Write a query to retrieve the Top 5 Stores with the Most Sales Transactions
SELECT 
	s.Store_Key,
	COUNT(s.Order_Number) AS Total_Sales_Transactions, 
	st.Country, 
	st.State
FROM sales s
JOIN stores st ON s.Store_Key = st.Store_Key
GROUP BY s.Store_Key, st.Country, st.State
ORDER BY Total_Sales_Transactions DESC
LIMIT 5;


--- Write a query to find the average unit price of products in each category
SELECT 
    p.Category_Key,
    c.Category,
    ROUND (AVG(p.Unit_Price_USD),2) AS Average_Unit_Price
FROM 
    products p
JOIN 
    categories c ON p.Category_Key = c.Category_Key
GROUP BY 
    p.Category_Key, c.Category
ORDER BY 
    Average_Unit_Price DESC;
	
--- Write a query to count the number of orders placed by each gender.
SELECT 
	c.Gender, 
	COUNT( DISTINCT s.Order_Number) AS Num_Of_Orders
FROM customers c
JOIN sales s ON c.Customer_Key = s.Customer_Key
GROUP BY c.Gender;

--- Write a query to list all products that have never been sold.
SELECT 
	p.Product_Key, 
	p.Product_Name, 
	p.Brand, 
	p.Color
FROM products p
LEFT JOIN sales s ON p.Product_Key = s.Product_Key
WHERE s.Product_Key IS NULL;

--- Write a query to show the total amount in USD, 
--- round to 2 decimal point for orders made in other currencies, 
--- using the Exchange Rates table to convert the prices.
SELECT
    s.Order_Number,
    SUM(p.Unit_Price_USD * s.Quantity) AS Total_Amount_USD
FROM
    sales s
JOIN
    exchange_rate e ON s.Currency_Codes = e.Currency_codes AND s.Order_Date = e.Date
JOIN
	products p ON s.product_key = p.product_key
WHERE
    s.Currency_Codes <> 'USD'
GROUP BY
    s.Order_Number
	
--- Write a query to analyze whether larger stores (in terms of square meters) 
--- have higher sales volumes.

SELECT
    st.Store_Key,
    Country,
    State,
    st.Square_meter,
    SUM(Quantity) AS Total_Sales_Volume,
	ROUND (AVG(quantity),0) AS average_sales_per_transaction
FROM
    sales s
JOIN
    stores st ON s.Store_Key = st.Store_Key
GROUP BY
    st.Store_Key, Country, State, St.square_meter
ORDER BY
    Square_meter DESC;

--- Write a query to segment customers into groups based on their purchase behaviors 
--- and demographics.

SELECT
    c.Customer_Key,
    c.Name AS Customer_Name,
    c.Gender,
    c.State,
    COUNT(DISTINCT s.Order_Number) AS Num_Orders,
    SUM(p.Unit_Price_USD * s.Quantity) AS Total_Spend_USD,
    CASE
        WHEN SUM(p.Unit_Price_USD * s.Quantity) >= 10000 THEN 'High Spender'
        WHEN SUM(p.Unit_Price_USD * s.Quantity) >= 5000 
		AND  SUM(p.Unit_Price_USD * s.Quantity) < 5000 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS Spend_Category,
    CASE
        WHEN COUNT(DISTINCT s.Order_Number) >= 5 THEN 'Frequent Buyer'
        WHEN COUNT(DISTINCT s.Order_Number) >= 2 THEN 'Regular Buyer'
        ELSE 'Occasional Buyer'
    END AS Purchase_Category
FROM
    customers c
LEFT JOIN
    sales s ON c.Customer_Key = s.Customer_Key
JOIN
	Products p ON s.product_key = p. product_key
GROUP BY
    c.Customer_Key, c.Name, c.Gender, c.State
ORDER BY
    Total_Spend_USD DESC;

--- Write a query to calculate the total sales volume for each store, 
--- then rank stores based on their sales volume.
WITH StoreSales AS (
    SELECT
        s.Store_Key,
        SUM(s.Quantity) AS Total_Sales_Volume,
        RANK() OVER (ORDER BY SUM(s.Quantity) DESC) AS Sales_Rank
    FROM
        sales s
    GROUP BY
        s.Store_Key
)
SELECT
    Store_Key,
    Total_Sales_Volume,
    Sales_Rank
FROM
    StoreSales
ORDER BY
    Total_Sales_Volume DESC;


--- Write a query to retrieve daily sales volumes, 
-- then calculate a running total of sales over time, ordered by date.

WITH DailySales AS (
    SELECT
        Order_Date,
        SUM(Quantity) AS Daily_Sales_Volume,
        SUM(SUM(Quantity)) OVER (ORDER BY Order_Date) AS Running_Total_Sales
    FROM
        sales
    GROUP BY
        Order_Date
)
SELECT
    Order_Date,
    Daily_Sales_Volume,
    Running_Total_Sales
FROM
    DailySales
ORDER BY
    Order_Date;

--- Write a query to calculate the lifetime value of each customer based on their country

WITH CountryLTV AS (
    SELECT
        c.Country,
        c.Customer_Key,
        SUM(p.Unit_Price_USD * s.Quantity) AS Lifetime_Value_USD
    FROM
        customers c
    JOIN
        sales s ON c.Customer_Key = s.Customer_Key
	JOIN
	products p ON s.product_key = p.product_key
	
    GROUP BY
        c.Country, c.Customer_Key
),
AvgLTVCountry AS (
    SELECT
        Country,
        AVG(Lifetime_Value_USD) AS Avg_LTV
    FROM
        CountryLTV
    GROUP BY
        Country
)
SELECT
    Country,
    Avg_LTV,
    RANK() OVER (ORDER BY Avg_LTV DESC) AS Country_Rank
FROM
    AvgLTVCountry
ORDER BY
    Avg_LTV DESC;

--- Write a query to calculate the lifetime value of each customer based on the total amount they’ve spent.
SELECT
    c.Customer_Key,
    c.Name AS Customer_Name,
    c.Country,
    SUM(p.Unit_Price_USD * s.Quantity) AS Lifetime_Value_USD
FROM
    customers c
JOIN
    sales s ON c.Customer_Key = s.Customer_Key
JOIN
	products p ON s.product_key = p.product_key
GROUP BY
    c.Customer_Key, c.Name, c.Country
ORDER BY
    Lifetime_Value_USD DESC;

--- Write a query to calculate the total annual sales per product category for the current year 
-- and the previous year, and then use window functions to calculate the year-over-year growth percentage.

WITH YearlySales AS (
    SELECT
         EXTRACT (YEAR FROM Order_Date) AS Sales_Year,
        Category,
        SUM(p.Unit_Price_USD * s.Quantity) AS Total_Sales
    FROM
        sales s
JOIN
	products p ON s.product_key = p.product_key

GROUP BY
        Sales_Year, Category
),

YearlySalesWithRank AS (
    SELECT
        Sales_Year,
        Category,
        Total_Sales,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Sales_Year DESC) AS RowNum
    FROM
        YearlySales
)

SELECT
    ys1.Sales_Year AS Current_Year,
    ys1.Category,
    ys1.Total_Sales AS Current_Year_Sales,
    ys2.Sales_Year AS Previous_Year,
    ys2.Total_Sales AS Previous_Year_Sales,
    ROUND(((ys1.Total_Sales - ys2.Total_Sales) / ys2.Total_Sales) * 100, 2) AS Year_Over_Year_Growth_Percentage
FROM
    YearlySalesWithRank ys1
LEFT JOIN
    YearlySalesWithRank ys2 ON ys1.Category = ys2.Category AND ys1.RowNum = 1 AND ys2.RowNum = 2
WHERE
    ys1.RowNum = 1;


--- Write a SQL query to find each customer’s purchase rank within the store they bought from, 
-- based on the total price of the order (quantity * unit price).

WITH CustomerPurchaseRank AS (
    SELECT
        s.Customer_Key,
        s.Store_Key,
        s.Order_Number,
        SUM(s.Quantity * P.Unit_Price_USD) AS Total_Order_Price,
        RANK() OVER(PARTITION BY s.Store_Key ORDER BY SUM(s.Quantity * P.Unit_Price_USD) DESC) AS Purchase_Rank
    FROM
        sales s
	JOIN
		products p ON s.product_key = p.product_key
    GROUP BY
        s.Customer_Key, s.Store_Key, s.Order_Number
)
SELECT
    s.Customer_Key,
    s.Store_Key,
    s.Total_Order_Price,
    s.Purchase_Rank
FROM
    CustomerPurchaseRank s
ORDER BY
    s.Store_Key, s.Purchase_Rank;



--Perform a customer retention analysis to determine the percentage of customers who made repeat purchases within three months of their initial purchase. 
-- Calculate the percentage of retained customers by gender, age group, and location.


WITH Initialpurchase AS (
	SELECT
		C.Customer_key,
		c.Gender,
		DATE_PART ('year',AGE(C.BIRTHDAY)) AS Age,
		c.country,
		c.state,
		MIN(s.Order_Date) AS first_Purchase_Date
	FROM
		Customers c
	JOIN
sales s ON c.customer_key = s.customer_key
	GROUP BY
		C.Customer_key,c.Gender,C. Birthday, c.country, c.state
),
RepeatPurchase AS (
	SELECT
		ip.Customer_key
	FROM 
		Initialpurchase ip
	JOIN
		Sales s ON ip.Customer_key = s.Customer_key
	WHERE
		s.Order_Date > ip.First_purchase_Date
		AND s.Order_Date <= ip.First_purchase_Date + INTERVAL '3 months'
	GROUP BY
		ip.customer_key
	),
CustomerDemographics AS (
	SELECT
		C.Customer_key,
		c.Gender,
		CASE
			WHEN DATE_PART ('year',AGE(C.BIRTHDAY)) BETWEEN 18 AND 25 THEN '18-25'
			WHEN DATE_PART ('year',AGE(C.BIRTHDAY)) BETWEEN 36 AND 35 THEN '26-35'
			WHEN DATE_PART ('year',AGE(C.BIRTHDAY)) BETWEEN 38 AND 45 THEN '36-45'
			WHEN DATE_PART ('year',AGE(C.BIRTHDAY)) BETWEEN 46 AND 60 THEN '46-60'
			ELSE '60+'
			END AS Age_Group,
			c.country,
			c.state
		FROM
			Customers c
)
	SELECT
		cd.Gender,
		cd.Age_Group,
		cd.country,
		cd.state,
		COUNT(DISTINCT cd.customer_key) AS Total_customers,
		COUNT(DISTINCT rp.customer_key) AS Retained_customers, 
		CASE
			WHEN COUNT(DISTINCT cd.customer_key) > 0 THEN
		COUNT(DISTINCT rp.customer_key) * 100/ COUNT(DISTINCT cd.customer_key)
			ELSE
				0
		END AS Retention_Rate
	FROM
		CustomerDemographics cd
	LEFT JOIN 
		Repeatpurchase rp ON Cd.customer_key = rp.customer_key
	GROUP BY
		cd.Gender,
		cd.Age_Group,
		cd.country,
		cd.state;
		
		
--- Analyze historical sales data to identify the top-selling products in each product category for each store.  
-- Determine the optimal product assortment for each store based on sales performance, 
-- product popularity, and profit margins.

WITH RankedProducts AS (
    SELECT
        s.Store_Key,
        p.Category,
        p.Product_Key,
        p.Product_Name,
        SUM(s.Quantity) AS TotalQuantitySold,
        ROW_NUMBER() OVER (PARTITION BY s.Store_Key, p.Category ORDER BY SUM(s.Quantity) DESC) AS SalesRank
    FROM
        sales s
    INNER JOIN
        products p ON s.Product_Key = p.Product_Key
    GROUP BY
        s.Store_Key, p.Category, p.Product_Key, p.Product_Name
)
SELECT
    rp.Store_Key,
    rp.Category,
    STRING_AGG(p.Product_Name, ', ') AS ProductAssortment,
    SUM(rp.TotalQuantitySold) AS TotalQuantitySold
FROM
    RankedProducts rp
JOIN
    products p ON rp.Product_Key = p.Product_Key
WHERE
    rp.SalesRank = 1  
GROUP BY
    rp.Store_Key, rp.Category
ORDER BY
    rp.Store_Key, rp.Category;
