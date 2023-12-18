
-- ********* github repo *********
-- https://github.com/farxodovferuz33/WINDOW_FRAMES_Feruz_Farxodov.git




-- this query calculates the cumulative sum and centered 3-day average for the specified weeks (49, 50, 51) in 1999. 
-- It utilizes window functions to perform these calculations efficiently and produces a result set with the requested columns.


WITH SalesData AS (
    SELECT
        calendar_week_number,
        time_id,
        day_name,
        sales,
        SUM(sales) OVER (ORDER BY calendar_week_number, time_id) AS cum_sum,
        AVG(sales) OVER (
            PARTITION BY day_name
            ORDER BY calendar_week_number, time_id
            ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
        ) AS cen_3d_avg
    FROM
        your_sales_table
    WHERE
        calendar_week_number IN (49, 50, 51)
)
SELECT
    calendar_week_number,
    time_id,
    day_name,
    sales,
    cum_sum,
    ROUND(cen_3d_avg, 2) AS cen_3d_avg
FROM
    SalesData
ORDER BY
    calendar_week_number, time_id;

-- Common Table Expression (CTE): SalesData

-- This CTE is named SalesData and acts as a temporary result set.
-- It selects columns such as calendar_week_number, time_id, day_name, and sales from your sales table.
-- The SUM(sales) OVER (ORDER BY calendar_week_number, time_id) calculates the cumulative sum (cum_sum) of sales. It sums the sales values from the beginning up to the current row.
-- The AVG(sales) OVER (PARTITION BY day_name ORDER BY calendar_week_number, time_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) calculates the centered 3-day average (cen_3d_avg). It considers the average of sales for the current day and the two surrounding days, based on the day_name.
-- Final SELECT Statement

-- This SELECT statement retrieves columns from the SalesData CTE.
-- It includes calendar_week_number, time_id, day_name, sales, cum_sum, and the rounded cen_3d_avg.
-- The ROUND(cen_3d_avg, 2) ensures that the centered 3-day average is rounded to two decimal places.
-- FROM Clause

-- The FROM clause specifies that the source of the data is the SalesData CTE.
-- ORDER BY Clause

-- The ORDER BY clause orders the final result set by calendar_week_number and time_id.