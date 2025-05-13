BEGIN TRANSACTION;

BEGIN TRY
    -- Check if an agent with AgentID = 1 exists
    IF EXISTS (SELECT 1 FROM Agent WHERE AgentID = 1)
    BEGIN
        -- Add a new client if the agent exists
        INSERT INTO Client (FirstName, LastName, PhoneNumber)
        VALUES ('Ivan', 'Petrenko', '123-456-7890');

        COMMIT;
        PRINT 'Client successfully added. Data is consistent.';
    END
    ELSE
    BEGIN
        THROW 51000, 'Agent not found. Client was not added.', 1;
    END
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Transaction rolled back: ' + ERROR_MESSAGE();
END CATCH;
