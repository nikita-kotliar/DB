USE publishing;

-- Задача 18. Контракти з авторами та співробітниками (LEFT JOIN)
SELECT
    c.ContractID,
    a.Name      AS Author,
    e.Name      AS Employee,
    c.ContractType,
    c.StartDate,
    c.EndDate
FROM contracts c
LEFT JOIN authors   a ON a.AuthorID   = c.AuthorID
LEFT JOIN employees e ON e.EmployeeID = c.EmployeeID
ORDER BY c.StartDate DESC, c.ContractID;
