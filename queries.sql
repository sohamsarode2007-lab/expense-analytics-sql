
-- 1. Insert a user
INSERT INTO users (id, name)
VALUES (1, 'Alex');

-- 2. Insert expenses
INSERT INTO expenses
    (id, user_id, category, amount, spent_on)
VALUES
    (1, 1, 'Food', 250, '2026-10-01'),
    (2, 1, 'Travel', 500, '2026-10-02'),
    (3, 1, 'Food', 150, '2026-10-03');

-- 3. Update an expense
UPDATE expenses
SET amount = 275
WHERE id = 1;

-- 4. Filter and sort expenses
SELECT category, amount, spent_on
FROM expenses
WHERE amount > 200
ORDER BY spent_on DESC;

-- 5. Aggregate spending by category
SELECT category, SUM(amount) AS total_spent
FROM expenses
GROUP BY category
ORDER BY total_spent DESC;

-- 6. Join expenses with users
SELECT u.name, e.category, e.amount
FROM users u
JOIN expenses e ON u.id = e.user_id;

-- 7. Find expenses above the average
SELECT *
FROM expenses
WHERE amount > (
    SELECT AVG(amount)
    FROM expenses
);

-- 8. Use a CTE for category totals
WITH category_totals AS (
    SELECT category, SUM(amount) AS total
    FROM expenses
    GROUP BY category
)
SELECT category, total
FROM category_totals
WHERE total > 200;

-- 9. Rank expenses by amount
SELECT
    category,
    amount,
    RANK() OVER (ORDER BY amount DESC) AS expense_rank
FROM expenses;

-- 10. Compare spending against budgets
SELECT
    e.category,
    SUM(e.amount) AS total_spent,
    b.monthly_limit
FROM expenses e
JOIN budgets b
    ON e.user_id = b.user_id
   AND e.category = b.category
GROUP BY e.category, b.monthly_limit;

-- 11. Delete an expense
DELETE FROM expenses
WHERE id = 3;

-- 12. Demonstrate a transaction
BEGIN;
UPDATE budgets
SET monthly_limit = 3000
WHERE user_id = 1 AND category = 'Food';
COMMIT;
