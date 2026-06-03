/* 
 * Retrieves loan count, total exposure, and exposure average loan size by purpose group for Bank. Includes a total row.
 * Exposure = committed liability when > 0, otherwise current balamce
 * Total row validated
*/

SELECT
    purpose_group,
    loan_count,
    exposure
FROM (

    -- Detail rows by purpose group

    SELECT
        purpose_group,
        COUNT(*) AS loan_count,
        SUM(
            CASE 
                WHEN committed_liability > 0 
                    THEN committed_liability
                ELSE current_balance
            END
        ) AS exposure
    FROM (
        SELECT
            purpose_code,

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
            current_balance
        FROM lns
    ) x
    GROUP BY purpose_group

    UNION ALL

    -- Total row

    SELECT
        'TOTAL' AS purpose_group,
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
    CASE WHEN purpose_group = 'TOTAL' THEN 1 ELSE 0 END,
    purpose_group;
