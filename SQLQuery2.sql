CREATE TRIGGER trg_CheckAgeBeforeInsert
ON Client
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Age < 18)
    BEGIN
        RAISERROR(' л≥Їнт маЇ бути 18+ рок≥в', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        INSERT INTO Client (ClientID, FirstName, LastName, PhoneNumber, Age, Address)
        SELECT ClientID, FirstName, LastName, PhoneNumber, Age, Address FROM inserted;
    END
END;
