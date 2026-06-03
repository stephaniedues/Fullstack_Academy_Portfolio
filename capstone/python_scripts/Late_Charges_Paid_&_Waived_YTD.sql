/* 
 * Bank Overview - total late fees waived and refunded year to date
*/

-- Total late fees waived --
SELECT
	SUM(
		COALESCE(late_charges_waived_ytd,0)
) AS total_late_charges_waived_ytd,

-- Total late fees collected --
	SUM(
		COALESCE(late_charges_paid_ytd,0)
) AS total_late_charges_paid_ytd

FROM lns;