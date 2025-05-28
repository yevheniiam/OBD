CREATE TABLE PhoneChangeLog (
    LogID INT IDENTITY PRIMARY KEY,
    ClientID INT,
    OldPhone NVARCHAR(50),
    NewPhone NVARCHAR(50),
    ChangeDate DATETIME
);
