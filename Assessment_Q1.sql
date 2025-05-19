-- Question 1
-- High-value customers with multiple product
-- Task: Find customers who have at least one funded savings account AND one funded investment plan,
-- sorted by their total deposits.


select u.id,
   concat(u.first_name, " ", u.last_name) as name, -- concatenate first_name and last_name
   -- count distinct savings plan for customers
   count(distinct s.plan_id) as savings_count,
   -- count distinct investment plans for customers
   count(distinct p.id) as investment_count,
   -- sum total deposits in kobo and converts to naira
   sum(ifnull(s.confirmed_amount, 0)) / 100 as total_deposits
from users_customuser u
inner join savings_savingsaccount s 
on u.id = s.owner_id and s.confirmed_amount > 0 -- ensures only positive deposits are considered
inner join plans_plan p
on u.id = p.owner_id and p.is_a_fund = 1 -- ensures only investment plans are counted
group by u.id -- group by user id
order by total_deposits; -- sort total_deposits in ascending order

















































