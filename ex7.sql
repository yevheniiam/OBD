BEGIN TRAN;

BEGIN TRY
    -- Оновлення даних в таблиці Agent
    UPDATE Agent
    SET Experience = 10
    WHERE AgentID = 1;
    
    -- Оновлення даних в таблиці Client
    UPDATE Client
    SET PhoneNumber = '555-123-4567'
    WHERE ClientID = 1;

    -- Якщо все в порядку, підтверджуємо транзакцію
    COMMIT;
    PRINT 'Transaction completed successfully!';
END TRY

BEGIN CATCH
    -- У випадку помилки скасовуємо транзакцію
    ROLLBACK;
    PRINT 'Error occurred: ' + ERROR_MESSAGE();
END CATCH;
