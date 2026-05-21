USE publishing;

-- Задача 2. Вкладений запит — книги з доходом вище середнього
SELECT b.Title,
       SUM(oi.Quantity * oi.UnitPrice) AS Revenue
FROM orderitem oi
JOIN books b ON b.BookID = oi.BookID
GROUP BY b.Title
HAVING Revenue > (
  SELECT AVG(Quantity * UnitPrice)
  FROM orderitem
)
ORDER BY Revenue DESC;
