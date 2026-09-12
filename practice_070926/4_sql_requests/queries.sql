--partners and sales list
SELECT 
    p.company_name, 
    COUNT(s.id) AS sales_count
FROM partners p
LEFT JOIN sales s ON p.id = s.partner_id
GROUP BY p.id, p.company_name
ORDER BY p.company_name ASC;

--insert new partner in db
BEGIN;
INSERT INTO partners (inn, email, company_name, phone) 
VALUES ('1111111111', 'marge@simpsons.com', 'MargeSimpson LLC', '+79991231212')
RETURNING id;

-- insert new sale
INSERT INTO sales (sale_code, partner_id, sale_date, status) 
VALUES ('TEST-100', currval('partners_id_seq'), CURRENT_DATE, 'new');

COMMIT;

--sales history
SELECT 
    s.sale_code,
    p.company_name AS partner,
    pr.product_name,
    si.quantity,
    si.total
FROM sales s
JOIN partners p ON s.partner_id = p.id
JOIN sales_items si ON s.id = si.sale_id
JOIN products pr ON si.product_id = pr.id
WHERE s.sale_code LIKE 'MIG-%'
ORDER BY s.sale_code;