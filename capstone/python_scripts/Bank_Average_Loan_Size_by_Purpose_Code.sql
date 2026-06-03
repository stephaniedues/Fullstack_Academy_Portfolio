/* 
 * Retrieves loan count, total exposure, and average exposure 
 * by purpose code for Bank. Includes a TOTAL row.
 * Exposure = committed_liability when > 0, otherwise current_balance.
 * Total row validated
 */

WITH base AS (
    SELECT
        purpose_code,
-- Total exposure --
        CASE 
            WHEN committed_liability > 0 THEN committed_liability
            ELSE current_balance
        END AS exposure_amount
    FROM lns
)

SELECT
    purpose_code,
    loan_count,
    total_exposure,
    average_exposure
FROM (
-- Calculated rows by purpose code --
    SELECT
        purpose_code,
        COUNT(*) AS loan_count,
        SUM(exposure_amount) AS total_exposure,
        AVG(exposure_amount) AS average_exposure
    FROM base
    GROUP BY purpose_code

    UNION ALL

-- Total row --
    SELECT
        'TOTAL' AS purpose_code,
        COUNT(*) AS loan_count,
        SUM(exposure_amount) AS total_exposure,
        AVG(exposure_amount) AS average_exposure
    FROM base
) t
ORDER BY 
    CASE WHEN purpose_code = 'TOTAL' THEN 1 ELSE 0 END,
    purpose_code;
