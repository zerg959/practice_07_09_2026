SELECT
(SELECT count(*) FROM sales) AS total_sales,
(SELECT count(*) FROM partners) AS total_partners;