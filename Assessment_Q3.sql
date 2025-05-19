-- Question 3
-- Account Inactivity Alert
-- Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days)


select p.id as plan_id, p.owner_id,
  case 
     when p.is_a_fund =1 then 'Investment'
     else 'Savings'
  end as type,
  date(t.last_transaction_date) as last_transaction_date, -- -- most recent transaction date
  datediff(curdate(), t.last_transaction_date) as inactivity_days -- days since last transaction
from plans_plan p 
join (
     -- -- Get the last transaction date per plan
   select plan_id, 
     max(transaction_date) as last_transaction_date 
   from savings_savingsaccount s 
   group by plan_id) t 
on p.id = t.plan_id
having inactivity_days > 365; -- only plans with more than 1 year of no transaction






















