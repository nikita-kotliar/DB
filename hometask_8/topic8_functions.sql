-- ============================================================
-- ПРАКТИЧНА РОБОТА: ТЕМА 8 — Вбудовані SQL функції
-- ============================================================

USE publishing;

-- ====== ЗАДАЧА 1. Текстові функції ======

-- Ім'я автора у верхньому регістрі
SELECT UPPER(Name) AS AuthorNameUpper FROM Authors;

-- Підпис співробітника: "Ім'я <email>"
SELECT CONCAT(Name, ' <', Email, '>') AS Signature FROM Employees;

-- Пошук співробітників з доменом pub.ch
SELECT Name, Email FROM Employees WHERE Email LIKE '%pub.ch%';

-- Довжина назви книги
SELECT Title, LENGTH(Title) AS TitleLength FROM Books;

-- ====== ЗАДАЧА 2. Числові функції ======

-- Загальний дохід по кожному замовленню
SELECT OrderID, ROUND(SUM(Quantity * UnitPrice), 2) AS TotalRevenue
FROM OrderItem
GROUP BY OrderID;

-- Середня ціна книги
SELECT ROUND(AVG(UnitPrice), 2) AS AvgBookPrice FROM OrderItem;

-- Непарна кількість
SELECT OrderItemID, Quantity, MOD(Quantity, 2) AS IsOdd FROM OrderItem;

-- ====== ЗАДАЧА 3. Часові функції ======

-- Поточна дата
SELECT CURDATE() AS Today;

-- Замовлення зроблені більш ніж 100 днів тому
SELECT OrderID, OrderDate, DATEDIFF(CURDATE(), OrderDate) AS DaysAgo
FROM Orders
WHERE DATEDIFF(CURDATE(), OrderDate) > 100;

-- Рік і місяць контракту
SELECT ContractID,
       YEAR(StartDate)  AS YearStart,
       MONTH(StartDate) AS MonthStart
FROM Contracts;

-- ====== ЗАДАЧА 4. Логічні та умовні функції ======

-- Статус контракту
SELECT ContractID,
       IF(EndDate IS NULL, 'Active', 'Closed') AS ContractStatus
FROM Contracts;

-- Категорія книги за роком
SELECT Title, PublishYear,
       CASE
         WHEN PublishYear >= 2025 THEN 'Нові видання'
         WHEN PublishYear BETWEEN 2020 AND 2024 THEN 'Сучасні'
         ELSE 'Архів'
       END AS Category
FROM Books;

-- ====== ЗАДАЧА 5. Службові функції ======

-- Заміна NULL телефону
SELECT Name, IFNULL(Phone, '— не вказано —') AS PhoneDisplay
FROM Authors;

-- Валідація email
SELECT Name, Email,
       IF(Email LIKE '%@%', 'Valid email', 'Invalid email') AS CheckEmail
FROM Employees;
