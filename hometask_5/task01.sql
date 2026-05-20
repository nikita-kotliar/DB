USE publishing;

-- Задача 1. Прості вибірки
SELECT * FROM authors;
SELECT Name, Country FROM authors WHERE Country = 'Ukraine';
SELECT Title, Genre, PublishYear FROM books ORDER BY PublishYear DESC;
