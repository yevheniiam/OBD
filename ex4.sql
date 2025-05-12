BEGIN TRAN;

-- Точка збереження, до якої можна повернутись при необхідності
SAVE TRANSACTION point1;

-- Оновлення даних у таблиці Agent
UPDATE Agent
SET Experience = 15
WHERE AgentID = 1;

-- Оновлення даних у таблиці Client
UPDATE Client
SET PhoneNumber = '987-654-3210'
WHERE ClientID = 1;

-- Якщо виникає проблема, виконуємо ROLLBACK до точки збереження
IF (SELECT COUNT(*) FROM Client WHERE PhoneNumber = '999-999-9999') = 0
BEGIN
    PRINT 'No client found with the specified phone number. Rolling back to savepoint.';
    ROLLBACK TRANSACTION point1;
    -- Подальші зміни будуть скасовані, але транзакція продовжиться
END

-- Якщо все добре, підтверджуємо транзакцію
COMMIT;

PRINT 'Transaction completed successfully!';
