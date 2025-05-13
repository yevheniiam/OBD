BEGIN TRANSACTION;

BEGIN TRY
    -- 1. Вставляю нового агента
    INSERT INTO Agent (FirstName, LastName, Email, Experience)
    VALUES ('Petro', 'Ivanenko', 'petro.ivanenko@example.com', 7);

    -- Зберігаю новий AgentID
    DECLARE @NewAgentID INT = SCOPE_IDENTITY();

    -- 2. Вставляю нового клієнта
    INSERT INTO Client (FirstName, LastName, PhoneNumber)
    VALUES ('Olena', 'Shevchenko', '111-222-3333');

    -- Зберігаю новий ClientID
    DECLARE @NewClientID INT = SCOPE_IDENTITY();

    -- 3. Додаю контракт між агентом і клієнтом
    INSERT INTO Contract (AgentID, ClientID, StartDate, EndDate, InsuranceAmount, CompanyPercentage)
    VALUES (@NewAgentID, @NewClientID, GETDATE(), DATEADD(YEAR, 1, GETDATE()), 10000.00, 10.00);

    -- Успішне завершення
    COMMIT TRANSACTION;
    PRINT 'Усі дії виконано успішно.';
END TRY

BEGIN CATCH
    -- У разі помилки — скасування змін
    ROLLBACK TRANSACTION;
    PRINT 'Транзакцію скасовано через помилку: ' + ERROR_MESSAGE();
END CATCH;
