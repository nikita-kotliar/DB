USE publishing;

-- Задача 4. Створення VIEW для підрахунку продажів
CREATE OR REPLACE VIEW v_book_sales AS
SELECT b.BookID,
       b.Title,
       b.Genre,
       COALESCE(SUM(oi.Quantity), 0) AS TotalQty,
       COALESCE(SUM(oi.Quantity * oi.UnitPrice), 0) AS Revenue
FROM books b
LEFT JOIN orderitem oi ON oi.BookID = b.BookID
GROUP BY b.BookID, b.Title, b.Genre;

-- Використання VIEW у подальших запитах:

-- Всі книги з продажами
SELECT * FROM v_book_sales ORDER BY Revenue DESC;

-- Тільки книги з ненульовим продажем
SELECT * FROM v_book_sales WHERE Revenue > 0 ORDER BY Revenue DESC;

-- Топ жанр за виручкою через VIEW
SELECT Genre, SUM(Revenue) AS GenreRevenue
FROM v_book_sales
GROUP BY Genre
ORDER BY GenreRevenue DESC;
