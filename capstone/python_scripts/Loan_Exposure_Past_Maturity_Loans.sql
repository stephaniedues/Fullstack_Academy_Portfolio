/* 
 * Retrieves loan count and total exposure of loans past maturity by risk rating.
 * Exposure = committed liability when > 0, otherwise current balance
 * Total row validated
*/
 
-- Normalize Dates --
WITH cleaned AS (
    SELECT
        loan_id,
        officer_id,
        current_risk_code,

        /* Convert m/dd/yyyy → YYYY-MM-DD */
        CASE 
            WHEN maturity_date LIKE '%/%/%' THEN
                substr(maturity_date, length(maturity_date) - 3, 4) || '-' ||
                printf('%02d', substr(maturity_date, 1, instr(maturity_date, '/') - 1)) || '-' ||
                printf('%02d', substr(
                    maturity_date,
                    instr(maturity_date, '/') + 1,
                    instr(substr(maturity_date, instr(maturity_date, '/') + 1), '/') - 1
                ))
            ELSE maturity_date
        END AS maturity_date_iso,

        committed_liability,
        current_balance
    FROM lns
),

-- Loans Past Maturity --
past_due_maturity AS (
    SELECT
        loan_id,
        officer_id,
        current_risk_code,
        maturity_date_iso,

        CASE 
            WHEN committed_liability > 0 THEN committed_liability
            ELSE COALESCE(current_balance, 0)
        END AS exposure
    FROM cleaned
    WHERE maturity_date_iso IS NOT NULL
      AND DATE(maturity_date_iso) < DATE('now')
),

-- Risk Code Assessment --
portfolio_summary AS (
    SELECT
        current_risk_code AS portfolio_risk_code,
        COUNT(*) AS loan_count_past_maturity,
        SUM(exposure) AS total_exposure_past_maturity
    FROM past_due_maturity
    GROUP BY current_risk_code
)

-- Total Row --
SELECT *
FROM (
    SELECT
        portfolio_risk_code,
        loan_count_past_maturity,
        total_exposure_past_maturity
    FROM portfolio_summary

    UNION ALL

    SELECT
        'TOTAL' AS portfolio_risk_code,
        SUM(loan_count_past_maturity),
        SUM(total_exposure_past_maturity)
    FROM portfolio_summary
)
ORDER BY 
    CASE WHEN portfolio_risk_code = 'TOTAL' THEN 1 ELSE 0 END,
    total_exposure_past_maturity DESC;
