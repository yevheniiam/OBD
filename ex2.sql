BEGIN TRAN;

-- Оновлення даних у таблиці Agent
UPDATE Agent
SET Experience = 15
WHERE AgentID = 1;

-- Перевірка умови. Якщо у таблиці Client немає клієнтів з вказаним номером телефону, виконується ROLLBACK.
IF (SELECT COUNT(*) FROM Client WHERE PhoneNumber = '999-999-9999') = 0
BEGIN
    PRINT 'No client with the specified phone number. Rolling back transaction.';
    ROLLBACK;
END
ELSE
BEGIN
    COMMIT;
    PRINT 'Transaction completed successfully.';
END;
