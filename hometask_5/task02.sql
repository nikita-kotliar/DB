USE publishing;

-- Задача 2. Зв'язки між таблицями (JOIN)
SELECT a.Name AS Author, b.Title AS Book
FROM authors a
JOIN authorbook ab ON a.AuthorID = ab.AuthorID
JOIN books b ON b.BookID = ab.BookID;
