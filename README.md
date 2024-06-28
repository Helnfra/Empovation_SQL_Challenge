# Empovation query writers challenge   ![image](https://github.com/Helnfra/Empovation_SQL_Challenge/assets/138709761/dad7cd63-7a55-4e9f-8607-8a24fef60105)

Business Questions, solutions and insight

## Table of content
- [Project overview](Project-overview)
- [Project Objectives](Project-Objectives)
- [Data Sources](Data-Sources)
- [Tools](Tools)
- [Data cleaning](Data-cleaning)
- [Exploxatory data analysis](Exploxatory-data-analysis)
- [Analysis](Analysis)
- [Results](Results)
- [Recommendation](Recommendation)


## Project overview
This project aims to significantly determine and enhance the sales performance of a business, by providing insight by analyzing various aspects of sales data. 
By these analyses we seek to identify trends, make data driven recommendation and gain better understanding of company’s performance using some indicators. 


### Project Objectives
- Increase Revenue: Implement strategies to boost overall sales revenue.
- Optimize Product Mix: Analyze sales data to identify top-performing products and adjust inventory and promotions accordingly to maximize profitability.
- Expand Market Reach: Develop and execute marketing initiatives to attract new customers and retain existing ones, leveraging digital channels effectively.
- Utilize Analytics for Decision Making: Utilize data analytics tools to track key performance indicators (KPIs), analyze trends, and make informed decisions for continuous improvement.


### Data Sources
The data used for this analyses were provided, there are "categories.csv", "Customers.csv" , "Products.csv", "Sales.csv", "Stores.csv" file, containing information on sales made by the company


### Tools
- MS EXCEL for data cleaning and visualisation
-   - [download here]()
- SQL (POSTGRESQL) for analysing data
  

### Data cleaning
- loading and inspection of data.
- Checked for missing values in each column and decide how to handle them.
- Identified and removed duplicate records to avoid counting the same data multiple times.
- Ensured consistency in data formats (eg.dates) across all records.
- Convert data into a consistent format.


### Exploxatory data analysis
EDA involves all the questions that was was answered using the data. questions such as 
#### Batch A – Week 1
-	- Count the Total number of Orders Per Customer order in desc.
- - List of Products sold in 2020
- - Find Customers detail of Customers from California (CA)
- - Calculate Total Sales Quantity for product 2115
- - Store Information: retrieve the Top 5 Stores with the Most Sales Transactions.
#### BATCH B – WEEK 2
- - Average Price of Products in a Category
- - Customer Purchases by Gender
- - List of Products Not Sold
- - Show the total amount in USD, round to 2 decimal point for orders made in other currencies, using the Exchange Rates table to convert the prices.
#### BATCH C – WEEK 3
- - Impact of Store Size on Sales Volume
- - Show Customer Segmentation by purchase behaviors (e.g., total spend, number of orders) and demographics (e.g., state, gender).
- - calculate the total sales volume for each store, then rank stores based on their sales volume.
- - Write a query to retrieve daily sales volumes, then calculate a running total of sales over time, ordered by date.
- - Write a query to calculate the lifetime value of each customer based on their country
- - Write a query to calculate the lifetime value of each customer based on the total amount they’ve spent.
#### BATCH D – WEEK 4
-  - Show Year-over-Year Growth in Sales per Category.
-  - Find each customer’s purchase rank within the store they bought from, based on the total price of the order (quantity * unit price).
- - Perform a customer retention analysis to determine the percentage of customers who made repeat purchases within three months of their initial purchase. Calculate the percentage of retained customers by gender, age group, and location.
- - Analyze historical sales data to identify the top-selling products in each product category for each store.  Determine the optimal product assortment for each store based on sales performance, product popularity, and profit margins.



  ### Analysis
  ```sql
  select from sales
  where


### Results!
[question 1](https://github.com/Helnfra/Empovation_SQL_Challenge/assets/138709761/759b9a73-9f49-438c-a119-5323d03e0987)
![question 2](https://github.com/Helnfra/Empovation_SQL_Challenge/assets/138709761/1b1368e0-e1e9-4ce4-ac3d-c9b8625d97e6)
![question 3](https://github.com/Helnfra/Empovation_SQL_Challenge/assets/138709761/8e6b0da0-13a1-4866-88b7-bcb1f51962c6)
![question 4](https://github.com/Helnfra/Empovation_SQL_Challenge/assets/138709761/792e0bd0-741e-478f-a830-001eda56e116)
![question 5](https://github.com/Helnfra/Empovation_SQL_Challenge/assets/138709761/ccd25c41-1221-48a0-be7d-ab7c845c7f78)





The sales was better the previous year



### Recommendation
Base on the results from the analysis, i recommend the following
- Invest in marketing and promotion especially during the peak seasons to maximize sale.
- implement a customer segmentation strategy to target high LTV customers.
- Focus on promoting products in category A.


### Reference
SQL for business by Werty
[stack overflow]()

  
