CREATE TRIGGER trg_AddressUpdateLog
ON Client
AFTER UPDATE
AS
BEGIN
    INSERT INTO AddressChangeLog (ClientID, OldAddress, NewAddress, ChangeDate)
    SELECT d.ClientID, d.Address, i.Address, GETDATE()
    FROM deleted d
    JOIN inserted i ON d.ClientID = i.ClientID
    WHERE d.Address <> i.Address;
END;
