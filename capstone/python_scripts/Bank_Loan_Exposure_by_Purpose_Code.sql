/* 
 * Retrieves loan count, total exposure, and exposure average loan size by purpose group for Bank. Includes a total row.
 * Exposure = committed liability when > 0, otherwise current balance
 * Total row validated
*/

SELECT
    purpose_code,
    loan_count,
    exposure
FROM (
-- Detail rows by purpose code
    SELECT
        purpose_code,
        COUNT(*) AS loan_count,
        SUM(
            CASE 
                WHEN committed_liability > 0 
                	THEN committed_liability
                ELSE current_balance
            END
        ) AS exposure
    FROM lns
    GROUP BY purpose_code
    UNION ALL
    -- Total row
    SELECT
        'TOTAL' AS purpose_code,
        COUNT(*) AS loan_count,
        SUM(
            CASE 
                WHEN committed_liability > 0 THEN committed_liability
                ELSE current_balance
            END
        ) AS exposure
    FROM lns
) t
ORDER BY 
    CASE WHEN purpose_code = 'TOTAL' THEN 1 ELSE 0 END,
    purpose_code;
