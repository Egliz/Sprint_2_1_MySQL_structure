USE glasses_store;

-- 1. A customer’s total sales over a period
SELECT COUNT(*) AS total_sales
FROM sale
WHERE id_customer = 1
AND sale_date BETWEEN '2025-01-01' AND '2025-12-31';


-- 2. Different models of glasses sold by an employee over the course of a year
SELECT DISTINCT
g.id_glasses,
b.name AS brand,
g.frame_type,
g.frame_color
FROM sale s
JOIN glasses g ON s.id_glasses = g.id_glasses
JOIN brand b ON g.id_brand = b.id_brand
WHERE s.id_employee = 1
AND s.sale_date BETWEEN '2025-01-01' AND '2025-12-31';


-- 3. Various suppliers who have supplied the glasses sold
SELECT DISTINCT
s.id_supplier,
s.name AS supplier
FROM sale sa
JOIN glasses g ON sa.id_glasses = g.id_glasses
JOIN brand b ON g.id_brand = b.id_brand
JOIN supplier s ON b.id_supplier = s.id_supplier;