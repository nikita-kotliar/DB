USE publishing;

-- Задача 6. Вкладені запити (IN)
SELECT b.Title
FROM books b
WHERE b.BookID IN (
    SELECT BookID
    FROM orderitem
);
