-- ============================================================
-- ПРАКТИЧНА РОБОТА: ТЕМА 6 — Складні SQL вирази / Тригери
-- База даних: publishing
-- ============================================================

USE publishing;

-- ====== ЗАДАЧА 1 + 2. Створення тригерів ======

DELIMITER $$

DROP TRIGGER IF EXISTS trg_contracts_bi$$
CREATE TRIGGER trg_contracts_bi
BEFORE INSERT ON Contracts
FOR EACH ROW
BEGIN
  -- 1. Рівно один власник
  IF (NEW.AuthorID IS NULL AND NEW.EmployeeID IS NULL)
     OR (NEW.AuthorID IS NOT NULL AND NEW.EmployeeID IS NOT NULL) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Exactly one of AuthorID or EmployeeID must be set';
  END IF;

  -- 2. ContractType відповідає власнику
  IF (NEW.AuthorID IS NOT NULL AND NEW.ContractType <> 'Author')
     OR (NEW.EmployeeID IS NOT NULL AND NEW.ContractType <> 'Employee') THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'ContractType must match owner (Author/Employee)';
  END IF;

  -- 3. Перевірка дат
  IF NEW.EndDate IS NOT NULL AND NEW.EndDate < NEW.StartDate THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'EndDate must be >= StartDate';
  END IF;
END$$

DROP TRIGGER IF EXISTS trg_contracts_bu$$
CREATE TRIGGER trg_contracts_bu
BEFORE UPDATE ON Contracts
FOR EACH ROW
BEGIN
  IF (NEW.AuthorID IS NULL AND NEW.EmployeeID IS NULL)
     OR (NEW.AuthorID IS NOT NULL AND NEW.EmployeeID IS NOT NULL) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Exactly one of AuthorID or EmployeeID must be set';
  END IF;

  IF (NEW.AuthorID IS NOT NULL AND NEW.ContractType <> 'Author')
     OR (NEW.EmployeeID IS NOT NULL AND NEW.ContractType <> 'Employee') THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'ContractType must match owner (Author/Employee)';
  END IF;

  IF NEW.EndDate IS NOT NULL AND NEW.EndDate < NEW.StartDate THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'EndDate must be >= StartDate';
  END IF;
END$$

DELIMITER ;

-- ====== ЗАДАЧА 3. Перевірка тригерів ======

-- ✅ Коректна вставка (має спрацювати успішно)
INSERT INTO Contracts (AuthorID, EmployeeID, ContractType, StartDate, EndDate)
VALUES (1, NULL, 'Author', '2025-06-01', '2025-12-31');

-- ❌ Помилка 1: два власники одночасно
INSERT INTO Contracts (AuthorID, EmployeeID, ContractType, StartDate)
VALUES (1, 1, 'Author', '2025-06-01');

-- ❌ Помилка 2: неправильний тип контракту (AuthorID є, але тип 'Employee')
INSERT INTO Contracts (AuthorID, EmployeeID, ContractType, StartDate)
VALUES (1, NULL, 'Employee', '2025-06-01');

-- ❌ Помилка 3: EndDate раніше StartDate
INSERT INTO Contracts (AuthorID, EmployeeID, ContractType, StartDate, EndDate)
VALUES (1, NULL, 'Author', '2025-12-01', '2025-01-01');

-- ====== ЗАДАЧА 4. Аналітична перевірка ======
SELECT ContractID, ContractType, StartDate, EndDate
FROM Contracts
ORDER BY StartDate DESC;
