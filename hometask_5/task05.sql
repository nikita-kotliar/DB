USE publishing;

-- Задача 5. HAVING (фільтр по агрегату)
SELECT b.Title, SUM(oi.Quantity * oi.UnitPrice) AS Revenue
FROM orderitem oi
JOIN books b ON b.BookID = oi.BookID
GROUP BY b.Title
HAVING Revenue > 100
ORDER BY Revenue DESC;
