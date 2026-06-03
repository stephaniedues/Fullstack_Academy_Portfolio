/* 
 * Retrieves loan count, total exposure, interest MTD/QTD/LTD and yield MTD/QTD/LTD by purpose group.
 * Exposure = committed liability when > 0, otherwise current balance
 * Total row validated
*/

SELECT
    purpose_group,
    loan_count,
    total_exposure,
    interest_mtd,
    interest_qtd,
    interest_ltd,

-- Yields (%) --
    CASE WHEN total_exposure = 0 THEN 0
         ELSE (interest_mtd * 1.0 / total_exposure) * 100
    END AS yield_mtd_pct,

    CASE WHEN total_exposure = 0 THEN 0
         ELSE (interest_qtd * 1.0 / total_exposure) * 100
    END AS yield_qtd_pct,

    CASE WHEN total_exposure = 0 THEN 0
         ELSE (interest_ltd * 1.0 / total_exposure) * 100
    END AS yield_ltd_pct

FROM (
-- Purpose Details --
    SELECT
        purpose_group,
        COUNT(*) AS loan_count,

-- Exposure  --
        SUM(
            CASE 
                WHEN committed_liability > 0 THEN committed_liability
                ELSE current_balance
            END
        ) AS total_exposure,

        /* Interest income */
        SUM(interest_paid_mtd) AS interest_mtd,
        SUM(interest_paid_qtd) AS interest_qtd,
        SUM(interest_paid_ltd) AS interest_ltd

    FROM (
        SELECT
-- Purpose Group --
            CASE 
                WHEN purpose_code IN ('100','110','120','130','140','150','160','170','180','190')
                    THEN 'Real Estate Loans'
                WHEN purpose_code IN ('210','220','230','240','250')
                    THEN 'Loans to Financial Institutions'
                WHEN purpose_code IN ('310','320')
                    THEN 'Stock Loans'
                WHEN purpose_code IN ('410','420','430','440')
                    THEN 'Agriculture Loans'
                WHEN purpose_code IN ('510','520','530')
                    THEN 'Commercial and Industrial Loans'
                WHEN purpose_code IN ('610','620','630','640','650','660','670','680')
                    THEN 'Loans to Individuals'
                WHEN purpose_code = '710'
                    THEN 'Other Loans'
                ELSE 'Other'
            END AS purpose_group,

            committed_liability,
            current_balance,
            interest_paid_mtd,
            interest_paid_qtd,
            interest_paid_ltd

        FROM lns
    ) raw
    GROUP BY purpose_group

    UNION ALL
-- Total Row --
    SELECT
        'TOTAL' AS purpose_group,
        COUNT(*) AS loan_count,

        SUM(
            CASE 
                WHEN committed_liability > 0 THEN committed_liability
                ELSE current_balance
            END
        ) AS total_exposure,

        SUM(interest_paid_mtd) AS interest_mtd,
        SUM(interest_paid_qtd) AS interest_qtd,
        SUM(interest_paid_ltd) AS interest_ltd

    FROM lns
) t
ORDER BY 
    CASE WHEN purpose_group = 'TOTAL' THEN 1 ELSE 0 END,
    purpose_group;
