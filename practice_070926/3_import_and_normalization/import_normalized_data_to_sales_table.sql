-- insert normalized sales data into sales table
INSERT INTO sales (sale_code, partner_id, sale_date, status, created_at)
SELECT 
    'SALE-' || sale_id AS sale_code,
    partner_id,
    TO_DATE(sale_date, 'YYYY-MM-DD') AS sale_date,
    'completed' as status,
    TO_DATE(sale_date, 'YYYY-MM-DD') AS created_at
FROM temp_sales;