-- Question 4
-- Customer Lifetime Value (CLV) Estimation
-- Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
-- Account tenure (months since signup)
-- Total transactions
-- Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
-- Order by estimated CLV from highest to lowest


select u.id as customer_id, 
    concat(u.first_name, ' ', u.last_name) as name, -- full customer name
    round(datediff(curdate(), u.date_joined) / 30, 0) as tenure_months, -- approximate tenure in month
    count(s.id) as total_transactions, -- total number of transactions for users 
    round(
          (count(s.id) / (datediff(curdate(), u.date_joined) / 30)) -- avg transactions per month
          * 12 -- annualize
          * (avg(s.confirmed_amount) * 0.001), 2) as estimated_clv -- round avg transaction amount converted from kobo to naira
from users_customuser u 
join savings_savingsaccount s
on u.id = s.owner_id
group by u.id -- group users by user_id
order by estimated_clv desc; -- sort by estimated value in descending order.


