BEGIN TRANSACTION; -- Start of the transaction

BEGIN TRY
    -- Update the agent's experience in the Agent table
    UPDATE Agent
    SET Experience = 10
    WHERE AgentID = 1;

    -- Update the client's phone number in the Client table
    UPDATE Client
    SET PhoneNumber = '123-456-7890'
    WHERE ClientID = 1;

    -- If everything is successful, commit the transaction
    COMMIT TRANSACTION;
    PRINT 'Transaction completed successfully!';
END TRY

BEGIN CATCH
    -- If an error occurs, roll back the transaction
    ROLLBACK TRANSACTION;
    PRINT 'Transaction was rolled back due to an error!';
END CATCH;
