USE pizzeria;

-- 1. Number of products in the ‘Drinks’ category sold in Girona
SELECT SUM(qp.quantity) AS total_drinks
FROM quantity_product qp
         JOIN `order` o ON qp.id_order = o.id_order
         JOIN customer c ON o.id_customer = c.id_customer
         JOIN locality l ON c.id_locality = l.id_locality
         JOIN product p ON qp.id_product = p.id_product
         JOIN product_category pc ON p.id_product_category = pc.id_product_category
WHERE pc.name = 'Drinks'
  AND l.name = 'Girona';


-- 2. Number of orders placed by a particular employee
SELECT COUNT(*) AS total_orders
FROM `order`
WHERE id_delivery = 2;