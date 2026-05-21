USE publishing;

-- Задача 3. CTE + RANK — рейтинг книг у межах жанру
WITH sales AS (
  SELECT b.Title, b.Genre,
         SUM(oi.Quantity * oi.UnitPrice) AS Revenue
  FROM books b
  JOIN orderitem oi ON oi.BookID = b.BookID
  GROUP BY b.Title, b.Genre
)
SELECT Title, Genre, Revenue,
       RANK() OVER (PARTITION BY Genre ORDER BY Revenue DESC) AS GenreRank
FROM sales
ORDER BY Genre, GenreRank;
