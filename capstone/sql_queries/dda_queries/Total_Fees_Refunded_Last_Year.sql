/* Bank Overview - total fees refunded, total nsf items, total overdraft days, total fees paid. Current statement */

-- Total fees refunded to customer --
SELECT
	SUM(
		COALESCE(nsf_fees_refunded_last_year,0) +
		COALESCE(other_fees_returned_last_year,0) +
		COALESCE(sc_fees_refunded_last_year,0)
) AS total_fees_refunded_last_year
FROM dda;