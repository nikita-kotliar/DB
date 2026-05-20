USE publishing;

-- Задача 16. NOT EXISTS — автори без замовлень
SELECT a.AuthorID, a.Name
FROM authors a
WHERE NOT EXISTS (
  SELECT 1
  FROM authorbook ab
  JOIN orderitem oi ON oi.BookID = ab.BookID
  WHERE ab.AuthorID = a.AuthorID
);
