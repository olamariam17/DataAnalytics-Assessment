# DataAnalytics-Assessment

## Introduction
This repository contains my submission to Cowrywise assessment test. The assessment tests my approach to solving business problems and also my ability to write complex SQL queries to solve real world business problem.

## Questions and Solutions
### Question 1: High value custmers with multiple approach.
- **Problem:** The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).
  
- **Approach:**
  1. I used Join to connect the Users_customuser, savings_savingsaccount and plans_plan table.
  2. Since the savings_savingsaccount table did not have an explicit is_regular_savings column, i used the confirmed_amount column to filter for funded savings account.
  3. I filtered for for investment plans using the is_a_fund column in the plans_plan table.
  4.  I identified and resolved an issue with incorrect counting of savings plans. Initially, each savings transaction was counted as a separate savings plan, leading to inflated values. I resolved this by counting unique plan_id values for savings instead of counting each transaction.
  5.  I calculated the total deposit using sum(confirmed amount) and converted it to naira by dividing the total by 100.
     
- **Challenge:**
  1. The name column was filled with null, this was resolved by using the CONCAT function to combine the first_name and last_name without modifying the original table.
  2. The savings_savingsaccount table lacked an is_regular_savings column, which made it difficult to directly identify savings plans. I used the presence of a positive confirmed_amount value to filter for valid savings plans.
  3. The initial query counted each transaction as a separate savings plan, leading to highly inflated values (e.g., a customer having 8,964 savings plans). I corrected this by counting unique plan_id values, accurately representing the number of savings and investment plans.


### Question 2: Transaction Frequency Analysis
- **Problem:** The objective is to classify customers based on their transaction frequency into 3 categories - high, low and medium frequency.
  
- **Approach:**
  1. I counted the total number of transactions per customer using the savings_savingsaccount table.
  2. I determined the average transactions per month for each customer by dividing the total transactions by the count of unique months derived from the transaction_date column.
  3. I used case statement to categorize customers into3 frquency level
      - **High frequency:**  10 or more transactions per month.
      - **Medium frequency:**  between 3 and 9 transaction per month.
      - **Low frequency:** Low frequency: less than 3 transactions per month.
  4. I grouped customers based on their frequency categories and calculated the total number of customers in each category.
     
- **Challenges:** 
1. The inital approach miscalculated the average by not correctly accounting for unique months, which inflated the transaction values. This was resolved using the DATE_FORMAT function to extract and count unique months.
2. Some customers with no transactions were not accurately categorized, i resolved this by ensuring the query counted only valid transactions.
3. The query i used innitialy had a complex structure, which i later simplified using a subquery to first calculate average transactions per month before classification.


### Question 3: Account Inactivity Alert
- **Problem:** The goal was to identify savings and investment plans that had been inactive for over a year.
  
-  **Approach:**
  1. I classified each plan as either investment or savings using a CASE statement, determined by the value of is_a_fund column in the plans_plan table.
  2. I calculated the most recent transaction date for each plan using the MAX function on the transaction_date column in the savings_savingsaccount table.
  3. I computed the number of days since the last transaction using the DATEIFF function.
  4. Lastly, i filtered the results to include only plans with more that 365 days of inactivity.
     
-  **Challenges:**
  1. Initially, the query i wrote failed to capture the most recent transaction for each plan, leading to incorrect inactivity calculatons. I corrected this using a subquery to identify the maximum transaction date for each plan.
  2. It took more time for me to understand the correct condition for distinguishing between savings and investment plans.
  3. The query was optimised using a JOIN with the subquery.


### Question 4: Customer Lifetime Value (CLV) Estimation
- **Problem:** The objective was to estimate the Customer Lifetime Value (CLV) for each customer based on their transaction history.
  
-  **Approach:**
  1. I listed each customer using the users_customuser table, combining their first_name and last_name for clear identification.
  2. I calculated the customer's tenure in months using the DATEDIFF function, divided by 30 (approximate month length).
  3. I counted the total number of transactions for each customer from the savings_savingsaccount table.
  4. I calculated estimated CLV using the formular below
      **Estimated CLV = (Total transactions / Customer tenure (in months)) × 12 × (Average transaction value × 0.001)**

- **Total transactions:** The total number of transactions made by the customer.
- **Customer tenure:** The number of months since the customer joined.
- **Average transaction value:** The average value of a single transaction in Kobo (converted to Naira by multiplying by 0.001).
This provided an annualized CLV, adjusted for transaction value in kobo.
 5. I arranged the results in descending order of estimated clv for easy identification of high value customers.
  
-  **Challenges:**
1. The initial approach used an inaccurate method for calculating tenure, which lead to incorrect clv values. this was corrected by dividing the total days by 30 for an approximate monthly value.
2. CLV was initially calculated in kobo, leading to extremly high values, i resolved this by converting the transaction value to naira by dividing the value by 100.
3. The first query i used was too complex, so i streamlined it for clarity still maintaining accuracy.
  
