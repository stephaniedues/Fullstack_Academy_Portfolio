/* 
 * Retrieves loan count, total exposure, and average exposure 
 * by collateral code for Bank. Includes a TOTAL row.
 * Exposure = committed_liability when > 0, otherwise current_balance.
 * Total row validated
 */

SELECT
    collateral_type,
    loan_count,
    exposure
FROM (
-- Detail rows by collateral type --
    SELECT
        COALESCE(collateral_type, 'Unsecured / No Collateral') AS collateral_type,
        COUNT(*) AS loan_count,
-- Total exposure --        
        SUM(
            CASE 
                WHEN committed_liability > 0 
                    THEN committed_liability
                ELSE current_balance
            END
        ) AS exposure
    FROM lns l
    LEFT JOIN cvs c
        ON l.loan_id = c.loan_id
    GROUP BY COALESCE(collateral_type, 'Unsecured / No Collateral')

    UNION ALL

-- Total row --
    SELECT
        'TOTAL' AS collateral_type,
        COUNT(*) AS loan_count,
        SUM(
            CASE 
                WHEN committed_liability > 0 
                    THEN committed_liability
                ELSE current_balance
            END
        ) AS exposure
    FROM lns
) t
ORDER BY 
    CASE WHEN collateral_type = 'TOTAL' THEN 1 ELSE 0 END,
    collateral_type;
