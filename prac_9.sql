-- практика 9

SELECT category, COUNT(*) AS product_count
FROM Products
GROUP BY category;

SELECT SUM(quantity * price_per_unit) AS total_revenue
FROM Order_Items;

SELECT c.full_name, COUNT(o.order_id) AS orders_count
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY c.full_name;

SELECT AVG(order_total) AS average_check
FROM (
    SELECT oi.order_id, SUM(oi.quantity * oi.price_per_unit) AS order_total
    FROM Order_Items oi
    GROUP BY oi.order_id
) t;

SELECT status, COUNT(*) AS orders_count
FROM Orders
GROUP BY status;

SELECT category, COUNT(*) AS product_count
FROM Products
GROUP BY category
HAVING COUNT(*) > 1;

SELECT c.full_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) > 1
ORDER BY c.full_name;

SELECT p.product_name
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY SUM(oi.quantity) DESC
LIMIT 1;
