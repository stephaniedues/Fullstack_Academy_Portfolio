/*
 * Retrieves average minimum balance for Bank
*/

SELECT
	AVG(minimum_balance_this_statement) AS avg_min_balance
FROM dda;