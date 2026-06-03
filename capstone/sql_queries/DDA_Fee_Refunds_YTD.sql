/* Bank Overview - total fees refunded, total nsf items, total overdraft days, total fees paid. Current statement */

-- Total fees refunded to customer --
SELECT
	SUM(
		COALESCE(nsf_fees_refunded_year_to_date,0)) AS total_nsf_fees_refunded_ytd,
	SUM(
		COALESCE(other_fees_refunded_year_to_date,0)) AS total_other_fees_refunded_ytd,
	SUM(
		COALESCE(sc_fees_refunded_year_to_date,0)) AS total_service_charge_fees_refunded_ytd,

-- Total NSF items paid --
	SUM(
		COALESCE(nsf_items_paid_current_std,0)) AS total_nsf_items_paid_current_stmt,

-- Total NSF items returned --
	SUM(
		COALESCE(nsf_items_returned_current_statement,0)
) AS total_nsf_items_returned_current_stmt,

-- Total days overdraft --
	SUM(COALESCE(number_days_od_current_statement,0)) AS total_od_days_current_stmt
FROM dda;