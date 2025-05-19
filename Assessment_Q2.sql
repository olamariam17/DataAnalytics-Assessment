-- Q2
-- Transaction Frequency Analysis
-- Task: Analyze the average number of transactions per customer per month and categorize them into high frequency
-- medium frequency and low frequency

-- Categorize users by average monthly transaction frequency and summarize counts and averages per category.
select
  case 
    when average_transactions_per_month >= 10 then "High Frequency"
	when average_transactions_per_month between 3 and 9 then "Medium Frequency" 
	else "Low Frequency"
  end as frequency_category,
  count(distinct owner_id) as customer_count, -- Number of unique users in each frequency category
  round(avg(average_transactions_per_month), 2) as Avg_transactions_per_month -- Average transactions per month in each category
from (
     -- Calculate average transactions per month for each user
       select u.id as owner_id,
             count(s.id) / count(distinct date_format(s.transaction_date, '%Y-%m')) as average_transactions_per_month
        from users_customuser u
        join savings_savingsaccount s 
        on u.id = s.owner_id
		group by u.id) as a
group by frequency_category; -- grouping categories









