-- Question 1
-- High-value customers with multiple product
-- Task: Find customers who have at least one funded savings account AND one funded investment plan,
-- sorted by their total deposits.


select u.id,
concat(u.first_name, " ", u.last_name) as name, -- concatenate first_name and last_name
count(distinct s.plan_id) as savings_count,
count(distinct p.id) as investment_count,
sum(ifnull(s.confirmed_amount, 0)) / 100 as total_deposits -- converts total deposit to naira
from users_customuser u
inner join savings_savingsaccount s 
on u.id = s.owner_id and s.confirmed_amount > 0
inner join plans_plan p
on u.id = p.owner_id and p.is_a_fund = 1
group by u.id, concat(u.first_name, " ", u.last_name)
order by total_deposits; -- sort total_deposits in ascending order

















































