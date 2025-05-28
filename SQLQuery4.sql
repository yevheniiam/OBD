CREATE TRIGGER trg_LogClientInsert
ON Client
AFTER INSERT
AS
BEGIN
    INSERT INTO ClientLog (ClientID, FirstName, ActionType, ActionDate)
    SELECT ClientID, FirstName, 'INSERT', GETDATE()
    FROM inserted;
END;
