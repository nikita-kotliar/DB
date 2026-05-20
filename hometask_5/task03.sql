USE publishing;

-- Задача 3. Фільтрація і сортування
SELECT Title, Genre, PublishYear
FROM books
WHERE Genre = 'Technology'
ORDER BY PublishYear DESC;
