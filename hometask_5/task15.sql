USE publishing;

-- Задача 15. HAVING — книги з виручкою понад 300
SELECT b.Title,
       SUM(oi.Quantity * oi.UnitPrice) AS Revenue
FROM orderitem oi
JOIN books b ON b.BookID = oi.BookID
GROUP BY b.Title
HAVING Revenue > 300
ORDER BY Revenue DESC;
