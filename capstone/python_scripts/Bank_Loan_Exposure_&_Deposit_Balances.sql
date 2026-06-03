/* 
 * Retrieves loan count, total exposure, and exposure average loan size by purpose group for Bank. Includes a total row.
 * Exposure = committed liability when > 0, otherwise current balamce
 * Total row validated
*/


-- LNS Totals & Exposure -- 
SELECT
    'LOANS' AS product_type,
    COUNT(*) AS account_count,
-- LNS Exposure --    
    SUM(
        CASE 
            WHEN committed_liability > 0 THEN committed_liability
            ELSE current_balance
        END
    ) AS exposure
FROM lns
UNION ALL
-- DDA Accounts & Deposits --
SELECT
    'DDAS' AS product_type,
    COUNT(*) AS account_count,
    SUM(current_balance) AS exposure
FROM dda
UNION ALL
-- Total Row-
SELECT
    'TOTAL' AS product_type,
    SUM(account_count),
    SUM(exposure)
FROM (
-- Loan Totals --
    SELECT
        COUNT(*) AS account_count,
        SUM(
            CASE 
                WHEN committed_liability > 0 THEN committed_liability
                ELSE current_balance
            END
        ) AS exposure
    FROM lns
    UNION ALL
-- DDA Totals --
    SELECT
        COUNT(*) AS account_count,
        SUM(current_balance) AS exposure
    FROM dda
) t;