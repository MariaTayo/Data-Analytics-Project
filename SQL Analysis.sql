# Part 1: Data Exploration. Looking into the demographics of the customers and how churn (attrition) looks across the different demographics.

-- Retrieve all data from table 
SELECT * FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`;

-- Check for null values in Attrition_Flag to ensure that that there is no missing data in this column that may impact the accuracy of our analysis going forward.
SELECT * FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers` 
WHERE Attrition_Flag IS NULL;

-- Retrieve total COUNT for Gender
SELECT Gender, COUNT(Gender) AS Gender_Count
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`
GROUP BY Gender;

-- Retrieve Existing Customers and Attrited Customers broken down by Gender. It is clear that more females have left the company's credit card services than males.
-- There are also more females who are existing customers than there are males. 
SELECT Gender, Attrition_Flag, COUNT(Gender) AS Gender_Count
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`
GROUP BY Gender, Attrition_Flag
ORDER BY Attrition_Flag;

-- I wanted to find out a little bit more about the credit card customers based on their marital status. 
-- The output showed that the majority of the customers are married, but a large amount are also single.
SELECT Marital_Status, COUNT(Marital_Status)
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`
GROUP BY Marital_Status;

-- A review of the marital status count of the Attrited Customers again shows that the majority of Attrited customers are married. A high proportion are also single. 
SELECT Marital_Status, Attrition_Flag, COUNT(Marital_Status) AS Marital_Status_Count_Attrited_Customers
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`
WHERE Attrition_Flag = 'Attrited Customer'
GROUP BY Marital_Status, Attrition_Flag;

-- Review a Count of the Card types for both Existing and Attrited Customers. 
--The blue card type is by far the most popular! 
--It is not surprising that the majority of customers who attrited had a blue card type. 
SELECT Card_Category, Attrition_Flag, COUNT(Card_Category) AS Count_of_Card_Category
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`
GROUP BY Card_Category, Attrition_Flag;

-- Retrieving Attrition Count by Income Category
SELECT Income_Category, COUNT(Income_Category) AS Count_Of_Income_Category
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`
WHERE Attrition_Flag = 'Attrited Customer'
GROUP BY Income_Category
ORDER BY Count_Of_Income_Category desc;

-- Retrieving Attrition Count by Education Level
SELECT Education_Level, COUNT(Education_Level) AS Count_Of_Education_Level
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`
WHERE Attrition_Flag = 'Attrited Customer'
GROUP BY Education_Level
ORDER BY Count_Of_Education_Level desc;

-- Retrieve the average customers age. 
-- The output builds upon previous analysis (from Microsoft Excel) showing that the majority of attrited customers are middle aged. 
-- We can now see that the average age of customers who have attrited is age 47.
SELECT ROUND(AVG(Customer_Age),0) AS Average_Customer_Age
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`
WHERE Attrition_Flag = 'Attrited Customer';

-- Retrieve the average dependent count for customers who have attrited. 
-- This came to an average of 2 dependents.
SELECT ROUND(AVG(Dependent_Count),0) AS Average_Dependent_Count
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`
WHERE Attrition_Flag = 'Attrited Customer';

-- Retrieve Dependent Count for Attrited Customers broken down from 0 to 5 dependents for a better understanding of dependent count
SELECT Attrition_Flag,Dependent_Count, COUNT(Dependent_Count) AS Count_of_Dependents_Attrited_Customer
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`
WHERE Attrition_Flag = 'Attrited Customer'
GROUP BY Attrition_Flag, Dependent_Count
ORDER BY Dependent_Count;

-- Looking at Gender Count based on females who have 2 and 3 dependents.
SELECT Gender, Dependent_Count, COUNT(Gender) AS Count_By_Gender
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers` 
WHERE Dependent_Count IN (2, 3) AND Gender = 'Female' 
GROUP BY Gender, Dependent_Count
ORDER BY 2 asc;

-- The output shows some very interesting results. As the dependents increase, so does the amount of attrited customers up until 3 dependents. 
-- After this, the customers who churn decreases significantly as the dependent count increases to 4 and 5 dependents. 
-- It may be necessary to get a list of those customers. 


# Part 2: Find out the Average utilization and analyse across a few demographics.

-- Retrieve the average utilization ratio 
SELECT ROUND(AVG(Avg_Utilization_Ratio),2) AS Avg_Utilization_Ratio
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`;

-- Reviewing the average utilization ratio by Gender. On average, females tend to have a higher utilization ratio.  
SELECT Gender, ROUND(AVG(Avg_Utilization_Ratio),2) AS Avg_Utilization_by_Gender
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`
GROUP BY Gender;

-- Reviewing the average utilization by each card type
SELECT Card_Category, ROUND(AVG(Avg_Utilization_Ratio),2) AS Avg_Utilization_by_Gender
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`
GROUP BY Card_Category;

-- Reviewing Utilisation levels for female customers to easily identify those with high and low utilisation ratios.
SELECT CLIENTNUM, Gender, Avg_Utilization_Ratio,
CASE
WHEN Avg_Utilization_Ratio <= 0.30 THEN 'Low Utilisation Ratio'
WHEN Avg_Utilization_Ratio > 0.30 THEN 'High Utilisation Ratio'
END AS Utilization_Ratio_Levels
FROM `data-analytics-project-380020.Data_Analytics_Project.Credit Card Customers`
WHERE Gender = 'Female'
GROUP BY CLIENTNUM, Gender, Avg_Utilization_Ratio
ORDER BY Avg_Utilization_Ratio;


# Part 3: Insights and Predictions

-- From the analysis of customer demographics, we see the following:
-- Females have the highest attrition counthowever, there are also more female customers than males;
-- The majority of customers who have attrited are married, followed by single customers;
-- The blue card type has the highest amount of customers (both existing and attrited);
-- The average age of attrited customers is 47; 
-- The average amount of dependents for attrited customers is 2 (2 and 3 dependents being the highest);
-- Those earning less than $40K have the highest attrition rate but also have the highest amount for all customers;
-- The majority of the banks customers are graduates. The highest amount of attrited customers are also graduates.



