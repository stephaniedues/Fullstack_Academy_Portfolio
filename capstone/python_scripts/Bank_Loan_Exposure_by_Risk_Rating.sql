/* 
 * Retrieves loan count, total exposure, and percent of exposure by risk rating.
 * Exposure = committed liability when > 0, otherwise current balance
 * Total row validated
*/

SELECT
    current_risk_code,
    loan_count,
    exposure,
    ROUND(
        exposure * 1.0 
        / SUM(CASE WHEN current_risk_code <> 'TOTAL' THEN exposure END) 
          OVER () * 100,
        1
    ) AS pct_of_total_exposure
FROM (
-- Detail rows
    SELECT
        current_risk_code,
        COUNT(*) AS loan_count,
        SUM(
            CASE 
                WHEN committed_liability > 0 THEN committed_liability
                ELSE current_balance
            END
        ) AS exposure
    FROM lns
    GROUP BY current_risk_code
    UNION ALL
-- Total row
    SELECT
        'TOTAL' AS current_risk_code,
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
    CASE WHEN current_risk_code = 'TOTAL' THEN 1 ELSE 0 END,
    current_risk_code;