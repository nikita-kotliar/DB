USE publishing;

-- Задача 10. Фільтрація й сортування
SELECT Title, Genre, PublishYear
FROM books
WHERE Genre = 'Technology'
ORDER BY PublishYear DESC;

SELECT Name, Email
FROM authors
WHERE Country = 'Ukraine'
ORDER BY Name;
