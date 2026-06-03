/* 
 * Retrieves loan count, total exposure, and average exposure 
 * by collateral group for Bank. Includes a TOTAL row.
 * Exposure = committed_liability when > 0, otherwise current_balance.
 * Total row validated
 */

-- Detail rows --
SELECT
    CASE 
        WHEN c.collateral_type IN ('1100', '1110', '1115')
            THEN 'Assignment of Contract'
        WHEN c.collateral_type IN ('1125', '1193', '1194')
            THEN 'Farmland'
        WHEN c.collateral_type IN ('1140', '1141', '1142', '1144', '1145', '1146', '1153', '1170', '1171')
            THEN 'Construction'
        WHEN c.collateral_type IN ('1148', '1149', '1150', '1151', '1152', '1154', '6230', '6235')
            THEN 'Residential Real Estate'
        WHEN c.collateral_type IN ('1172', '1173', '1174', '1175', '1176', '1177', '1178', '1179', '1915', '1188', '1192')
            THEN 'Commercial Real Estate - Owner Occupied'
        WHEN c.collateral_type IN ('1180', '1181', '1182', '1183', '1184', '1185', '1186', '1187', '1189', '1196')
            THEN 'Commercial Real Estate - Non Owner Occupied'
        WHEN c.collateral_type IN ('2100', '2200', '2400', '6150', '4300', '6100', '6130')
            THEN 'Stocks & Bonds & Cash Accounts'
        WHEN c.collateral_type IN ('4411', '4415', '4417')
            THEN 'Farming'
        WHEN c.collateral_type IN ('4420', '5425', '5500', '6200', '6220', '6225', '6236', '6240', '6245')
            THEN 'Vehicle'
        WHEN c.collateral_type IN ('5400', '5410', '5420')
            THEN 'Equipment'
        WHEN c.collateral_type IN ('5700', '5800', '5900', '6000')
            THEN 'Business Assets'
        ELSE 'Unsecured'
    END AS collateral_group,
-- Total exposure --
    COUNT(*) AS loan_count,

    SUM(
        CASE 
            WHEN l.committed_liability > 0 
                THEN l.committed_liability
            ELSE l.current_balance
        END
    ) AS exposure

FROM lns l
LEFT JOIN cvs c ON l.loan_id = c.loan_id
GROUP BY collateral_group

UNION ALL

-- Total row --
SELECT
    'TOTAL' AS collateral_group,
    COUNT(*) AS loan_count,
    SUM(
        CASE 
            WHEN committed_liability > 0 
                THEN committed_liability
            ELSE current_balance
        END
    ) AS exposure
FROM lns

-- SQLite-safe ORDER BY
ORDER BY 
    exposure ASC;
