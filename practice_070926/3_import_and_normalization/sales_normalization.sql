--create extra temp table to edit raw data
CREATE TABLE temp_sales (
    sale_id INTEGER,
    partner_id INTEGER,
    product_name TEXT,
    sale_date TEXT,
    quantity INTEGER,
    total_amount DECIMAL(10,2)
);
-- normalize imported data: remove wrong partner, normalize data format
DELETE FROM temp_sales
WHERE partner_id NOT IN (SELECT id FROM partners);

UPDATE temp_sales
SET sale_date = TO_CHAR(TO_DATE(sale_date, 'DD.MM.YYYY'), 'YYYY-MM-DD')
WHERE sale_date LIKE '%.%';