/* Bank Overview - total interest paid last year and this year */

-- Total interest paid last year --
SELECT
    SUM(
        COALESCE(interest_paid_last_year, 0)
    ) AS total_interest_paid_last_year,

-- Total interest paid this year --
    SUM(
        COALESCE(interest_paid_this_year, 0)
    ) AS total_interest_paid_this_year

FROM dda;
