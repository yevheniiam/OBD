CREATE TRIGGER trg_LogPhoneChange
ON Client
AFTER UPDATE
AS
BEGIN
    INSERT INTO PhoneChangeLog (ClientID, OldPhone, NewPhone, ChangeDate)
    SELECT d.ClientID, d.PhoneNumber, i.PhoneNumber, GETDATE()
    FROM deleted d
    JOIN inserted i ON d.ClientID = i.ClientID
    WHERE d.PhoneNumber <> i.PhoneNumber;
END;
