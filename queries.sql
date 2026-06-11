-- 1. Витрина для кампании 
CREATE TABLE campaign_target AS
SELECT 
    c.client_id,
    c.full_name,
    c.age,
    c.balance,
    a.account_type,
    a.balance AS account_balance
FROM clients c
JOIN accounts a ON c.client_id = a.client_id
WHERE a.account_type = 'current'
  AND a.balance > 50000
  AND c.age BETWEEN 25 AND 55
  AND c.is_active = 1;

-- 2. Ранжирование клиентов по балансу 
SELECT 
    client_id,
    full_name,
    age,
    balance,
    ROW_NUMBER() OVER (ORDER BY balance DESC) AS rank_by_balance
FROM campaign_target;

-- 3. Клиенты, у которых суммарный баланс по всем счетам > 100 000
WITH client_total_balance AS (
    SELECT client_id, SUM(balance) AS total_balance
    FROM accounts
    GROUP BY client_id
)
SELECT c.client_id, c.full_name, c.age, ctb.total_balance
FROM clients c
JOIN client_total_balance ctb ON c.client_id = ctb.client_id
WHERE ctb.total_balance > 100000
ORDER BY ctb.total_balance DESC;