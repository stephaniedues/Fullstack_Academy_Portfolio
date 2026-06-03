/* 
 * Retrieves total interest accrued ytd in LNS portfolio
*/

SELECT
    SUM(
        COALESCE(interest_accrued_ytd, 0)
    ) AS total_interest_accrued_ytd
FROM lns;
