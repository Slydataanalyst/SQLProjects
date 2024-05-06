--Check for duplicates
SELECT Customer_ID, COUNT(Customer_ID)
FROM [Maven Analysis].[dbo].[telecom_customer_churn]
GROUP BY Customer_ID
HAVING count(Customer_ID) > 1;

--Find total number of customers
SELECT COUNT(DISTINCT Customer_ID) AS customer_count
FROM [Maven Analysis].[dbo].[telecom_customer_churn]


--How much revenue did Maven loose to churned customers?
SELECT Customer_Status,
COUNT(Customer_ID) AS customer_count,
ROUND((SUM(Total_Revenue) * 100.0) / SUM(SUM(Total_Revenue)) OVER(),1) AS Revenue_Percentage
FROM [Maven Analysis].[dbo].[telecom_customer_churn]
GROUP BY Customer_Status;


-- Typical tenure for churners
SELECT
    CASE 
        WHEN Tenure_in_Months <= 6 THEN '6 months'
        WHEN Tenure_in_Months <= 12 THEN '1 Year'
        WHEN Tenure_in_Months <= 24 THEN '2 Years'
        ELSE '> 2 Years'
    END AS Tenure,
    ROUND(COUNT(Customer_ID) * 100.0 / SUM(COUNT(Customer_ID)) OVER(),1) AS Churn_Percentage
FROM
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE
Customer_Status = 'Churned'
GROUP BY
    CASE 
        WHEN Tenure_in_Months <= 6 THEN '6 months'
        WHEN Tenure_in_Months <= 12 THEN '1 Year'
        WHEN Tenure_in_Months <= 24 THEN '2 Years'
        ELSE '> 2 Years'
    END
ORDER BY
Churn_Percentage DESC;


-- Which cities have the highest churn rates?
SELECT
    TOP 4 City,
    COUNT(Customer_ID) AS Churned,
    CEILING(COUNT(CASE WHEN Customer_Status = 'Churned' THEN Customer_ID ELSE NULL END) * 100.0 / COUNT(Customer_ID)) AS Churn_Rate
FROM
    [Maven Analysis].[dbo].[telecom_customer_churn]
GROUP BY
    City
HAVING
    COUNT(Customer_ID)  > 30
AND
    COUNT(CASE WHEN Customer_Status = 'Churned' THEN Customer_ID ELSE NULL END) > 0
ORDER BY
    Churn_Rate DESC;


-- why did churners leave and how much did it cost?
SELECT 
  Churn_Category,  
  ROUND(SUM(Total_Revenue),0)AS Churned_Rev,
  CEILING((COUNT(Customer_ID) * 100.0) / SUM(COUNT(Customer_ID)) OVER()) AS Churn_Percentage
FROM 
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE 
    Customer_Status = 'Churned'
GROUP BY 
  Churn_Category
ORDER BY 
  Churn_Percentage DESC;


-- What service did they use?
SELECT 
    Internet_Type,
    COUNT(Customer_ID) AS Churned,
    ROUND((COUNT(Customer_ID) * 100.0) / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churn_Percentage
FROM 
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE 
    Churn_Category = 'Competitor' 
AND 
    Customer_Status = 'Churned'
GROUP BY 
    Internet_Type
ORDER BY 
    Churned DESC;

-- What contract were churners on?
SELECT 
    Contract,
    COUNT(Customer_ID) AS Churned,
    ROUND(COUNT(Customer_ID) * 100.0 / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churn_Percentage
FROM 
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE
    Customer_Status = 'Churned'
GROUP BY
    Contract
ORDER BY 
    Churned DESC;

-- Did churners have premium tech support?
SELECT 
    Premium_Tech_Support,
    COUNT(Customer_ID) AS Churned,
    ROUND(COUNT(Customer_ID) *100.0 / SUM(COUNT(Customer_ID)) OVER(),1) AS Churn_Percentage
FROM
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE 
    Customer_Status = 'Churned'
GROUP BY Premium_Tech_Support
ORDER BY Churned DESC;


-- What Internet service were churners on?
SELECT
    Internet_Type,
    COUNT(Customer_ID) AS Churned,
    ROUND(COUNT(Customer_ID) * 100.0 / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churn_Percentage
FROM
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE 
    Customer_Status = 'Churned'
GROUP BY
Internet_Type
ORDER BY 
Churned DESC;


-- Typical tenure for churners
SELECT
    CASE 
        WHEN Tenure_in_Months <= 6 THEN '6 months'
        WHEN Tenure_in_Months <= 12 THEN '1 Year'
        WHEN Tenure_in_Months <= 24 THEN '2 Years'
        ELSE '> 2 Years'
    END AS Tenure,
    COUNT(Customer_ID) AS Churned,
    CEILING(COUNT(Customer_ID) * 100.0 / SUM(COUNT(Customer_ID)) OVER()) AS Churn_Percentage
FROM
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE
Customer_Status = 'Churned'
GROUP BY
    CASE 
        WHEN Tenure_in_Months <= 6 THEN '6 months'
        WHEN Tenure_in_Months <= 12 THEN '1 Year'
        WHEN Tenure_in_Months <= 24 THEN '2 Years'
        ELSE '> 2 Years'
    END
ORDER BY
Churned DESC;


-- why did customer's churn exactly?
SELECT TOP 10
    Churn_Reason,
    Churn_Category,
    ROUND(COUNT(Customer_ID) *100 / SUM(COUNT(Customer_ID)) OVER(), 1) AS churn_perc
FROM
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE
    Customer_Status = 'Churned'
GROUP BY 
Churn_Reason,
Churn_Category
ORDER BY churn_perc DESC;


-- What offers were churners on?
SELECT  
    Offer,
    ROUND(COUNT(Customer_ID) * 100.0 / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churn_Percentage
FROM
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE
    Customer_Status = 'Churned'
GROUP BY
Offer
ORDER BY 
churn_percentage DESC;


-- HOW old were churners?
SELECT  
    CASE
        WHEN Age <= 30 THEN '19 - 30 yrs'
        WHEN Age <= 40 THEN '31 - 40 yrs'
        WHEN Age <= 50 THEN '41 - 50 yrs'
        WHEN Age <= 60 THEN '51 - 60 yrs'
        ELSE  '> 60 yrs'
    END AS Age,
    ROUND(COUNT(Customer_ID) * 100 / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churn_Percentage
FROM 
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE
    Customer_Status = 'Churned'
GROUP BY
    CASE
        WHEN Age <= 30 THEN '19 - 30 yrs'
        WHEN Age <= 40 THEN '31 - 40 yrs'
        WHEN Age <= 50 THEN '41 - 50 yrs'
        WHEN Age <= 60 THEN '51 - 60 yrs'
        ELSE  '> 60 yrs'
    END
ORDER BY
Churn_Percentage DESC;

-- What gender were churners?
SELECT
    Gender,
    ROUND(COUNT(Customer_ID) *100.0 / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churn_Percentage
FROM
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE
    Customer_Status = 'Churned'
GROUP BY
    Gender
ORDER BY
Churn_Percentage DESC;

-- Did churners have dependents
SELECT
    CASE
        WHEN Number_of_Dependents > 0 THEN 'Has Dependents'
        ELSE 'No Dependents'
    END AS Dependents,
    ROUND(COUNT(Customer_ID) *100 / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churn_Percentage
FROM
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE
    Customer_Status = 'Churned'
GROUP BY 
CASE
        WHEN Number_of_Dependents > 0 THEN 'Has Dependents'
        ELSE 'No Dependents'
    END
ORDER BY Churn_Percentage DESC;

-- Were churners married
SELECT
    Married,
    ROUND(COUNT(Customer_ID) *100.0 / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churn_Percentage
FROM
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE
    Customer_Status = 'Churned'
GROUP BY
    Married
ORDER BY
Churn_Percentage DESC;


-- Do churners have phone lines
SELECT
    Phone_Service,
    ROUND(COUNT(Customer_ID) * 100.0 / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churned
FROM
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE
    Customer_Status = 'Churned'
GROUP BY 
    Phone_Service


-- Do churners have internet service
SELECT
    Internet_Service,
    ROUND(COUNT(Customer_ID) * 100.0 / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churned
FROM
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE
    Customer_Status = 'Churned'
GROUP BY 
    Internet_Service


-- Did they give referrals
SELECT
    CASE
        WHEN Number_of_Referrals > 0 THEN 'Yes'
        ELSE 'No'
    END AS Referrals,
    ROUND(COUNT(Customer_ID) * 100.0 / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churned
FROM
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE
    Customer_Status = 'Churned'
GROUP BY 
    CASE
        WHEN Number_of_Referrals > 0 THEN 'Yes'
        ELSE 'No'
    END;


-- What Internet Type did 'Competitor' churners have?
SELECT
    Internet_Type,
    Churn_Category,
    ROUND(COUNT(Customer_ID) * 100.0 / SUM(COUNT(Customer_ID)) OVER(), 1) AS Churn_Percentage
FROM
[Maven Analysis].[dbo].[telecom_customer_churn]
WHERE 
    Customer_Status = 'Churned'
    AND Churn_Category = 'Competitor'
GROUP BY
Internet_Type,
Churn_Category
ORDER BY Churn_Percentage DESC;