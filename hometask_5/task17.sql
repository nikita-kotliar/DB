USE publishing;

-- Задача 17. Фільтри за датами і статусами
SELECT OrderID, OrderDate, ClientName, Status
FROM orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31'
  AND Status IN ('New', 'Completed')
ORDER BY OrderDate DESC;
