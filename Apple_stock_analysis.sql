SELECT
  sub.year,
  sub.fmt_month,
  AVG(close) AS average_closing_price,
  CASE
    WHEN TRIM(sub.fmt_month) IN ('january', 'february', 'march') THEN 'Quarter 1'
    WHEN TRIM(sub.fmt_month) IN ('april', 'may', 'june') THEN 'Quarter 2'
    WHEN TRIM(sub.fmt_month) IN ('july', 'august', 'september') THEN 'Quarter 3'
    ELSE 'Quater 4'
  END AS Quarters
FROM
  (
    SELECT
      year,
      TO_CHAR(DATE_TRUNC('Month', date :: Date), 'month') AS fmt_month
    FROM
      tutorial.aapl_historical_stock_price
  ) sub
  JOIN tutorial.aapl_historical_stock_price t ON EXTRACT(YEAR FROM t.date:: DATE) = sub.year AND 
  TO_CHAR(DATE_TRUNC('Month', date :: Date), 'month') = sub.fmt_month
GROUP BY
  1,
  2
ORDER BY 1 ASC
