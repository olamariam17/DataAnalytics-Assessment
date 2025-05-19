# DataAnalytics-Assessment

## Introduction
This repository contains my submission to Cowrywise assessment tes. The assessment test my approach to solving business problems and also my ability to write complex SQL queries to solve real world business problem.

## Questions and Solutions
### Question 1: High value custmers with multiple approach.
- **Problem:** The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).
- **Approach:**
  1. I used Join to connect the Users_customuser, savings_savingsaccount and plans_plan table.
  2. Since the savings_savingsaccount table did not have an explicit is_regular_savings column, i used the confirmed_amount column to filter for funded savings account.
  3. i filtered for for investment plans using the is_a_fund column in the plans_plan table.
  4.  i identified and resolved an issue with incorrect counting of savings plans. Initially, each savings transaction was counted as a separate savings plan, leading to inflated values. I resolved this by counting unique plan_id values for savings instead of counting each transaction.
  5.  I calculated the total deposit using sum(confirmed amount) and converted it to naira by dividing the total by 100
- **Challenge:**
  1. The name column was filled with null, this was resolved by using the CONCAT function to combine the first_name and last_name without modifying the original table.
  2. The savings_savingsaccount table lacked an is_regular_savings column, which made it difficult to directly identify savings plans. I used the presence of a positive confirmed_amount value to filter for valid savings plans.
  3. he initial query counted each transaction as a separate savings plan, leading to highly inflated values (e.g., a customer having 8,964 savings plans). I corrected this by counting unique plan_id values, accurately representing the number of savings and investment plans.


### Question 2: Transaction Frequency Analysis
- **Problem:** The objective is to classify customers based on their transaction frequency into 3 categories - high, low and medium frequency.
- **Approach:**
  1. I counted the total number of transactions per customer using the savings_savingsaccount table
  2. I determined the average transactions per month for each customer by dividing the total transactions by the count of unique months derived from the transaction_date column.
  3. i used case statement to categorize customers into3 frquency level
      - **High frequency:**  10 or more transactions per month.
      - **Medium frequency:**  between 3 and 9 transaction per month.
      - **Low frequency:** Low frequency: less than 3 transactions per month.
  4. Grouped customers based on their frequency categories and calculated the total number of customers in each category.
     
- **Challenges:** 
1. The inital approach miscalculated the average by not correctly accounting for unique months, which inflated the transaction values. This was resolved using the DATE_FORMAT function to extract and count unique months.
2. Some customers with no transactions were not accurately categorized, i resolved this by ensuring the query counted only valid transactions.
3. The query i used innitialy had a complex structure, which i later simplified using a subquery to first calculate average transactions per month before classification


### Question 3: Account Inactivity Alert
- **Problem:** The goal was to identify savings and investment plans that had been inactive for over a year
-  **Approach:**
-  **Challenges:**
  
