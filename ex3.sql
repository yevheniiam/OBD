BEGIN TRAN;

-- Оновлення даних у таблиці Agent
UPDATE Agent
SET Experience = 10
WHERE AgentID = 1;

-- Перевірка на помилку після першого запиту
IF @@ERROR <> 0
BEGIN
    PRINT 'Error occurred during the first update. Rolling back transaction.';
    ROLLBACK TRAN;
    RETURN;
END

-- Оновлення даних у таблиці Client
UPDATE Client
SET PhoneNumber = '123-456-7890'
WHERE ClientID = 1;

-- Перевірка на помилку після другого запиту
IF @@ERROR <> 0
BEGIN
    PRINT 'Error occurred during the second update. Rolling back transaction.';
    ROLLBACK TRAN;
    RETURN;
END

-- Якщо помилок не було, підтверджуємо транзакцію
COMMIT TRAN;

PRINT 'Transaction completed successfully!';
