BEGIN TRAN;

BEGIN TRY
    -- Оновлення даних у таблиці Agent
    UPDATE Agent
    SET Experience = 20
    WHERE AgentID = 1;

    -- Оновлення даних у таблиці Client
    UPDATE Client
    SET PhoneNumber = '555-123-4567'
    WHERE ClientID = 1;

    -- Якщо все успішно, підтверджуємо транзакцію
    COMMIT;

END TRY

BEGIN CATCH
    -- Якщо сталася помилка, скасовуємо транзакцію
    ROLLBACK;

    -- Виводимо повідомлення про помилку
    PRINT 'Error occurred: ' + ERROR_MESSAGE();
END CATCH;
