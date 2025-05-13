
BEGIN TRAN;

BEGIN TRY
    -- Обновление данных в таблице Agent
    UPDATE Agent
    SET Experience = 20
    WHERE AgentID = 1;

    -- Обновление данных в таблице Client
    UPDATE Client
    SET PhoneNumber = '555-123-4567'
    WHERE ClientID = 1;

    -- Логирование изменений в таблице audit_log
    INSERT INTO audit_log (Action, Timestamp)
    VALUES ('Updated agent experience and client phone number', GETDATE());

    -- Подтверждение транзакции
    COMMIT;

    PRINT 'Transaction completed and changes logged successfully!';

END TRY

BEGIN CATCH
    -- Откат транзакции в случае ошибки
    ROLLBACK;

    -- Вывод сообщения об ошибке
    PRINT 'Error occurred: ' + ERROR_MESSAGE();
END CATCH;