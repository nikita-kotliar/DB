USE publishing;

-- Задача 14. Агрегації та рейтинги

-- Топ-автори за кількістю книжок
SELECT a.AuthorID, a.Name, COUNT(*) AS BooksCount
FROM authorbook ab
JOIN authors a ON a.AuthorID = ab.AuthorID
GROUP BY a.AuthorID, a.Name
ORDER BY BooksCount DESC, a.Name;

-- Продажі за книжками
SELECT b.BookID, b.Title,
       SUM(oi.Quantity)                        AS QtySold,
       SUM(oi.Quantity * oi.UnitPrice)         AS Revenue
FROM orderitem oi
JOIN books b ON b.BookID = oi.BookID
GROUP BY b.BookID, b.Title
ORDER BY Revenue DESC;
