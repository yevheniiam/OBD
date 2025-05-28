CREATE TABLE ClientLog (
    LogID INT IDENTITY PRIMARY KEY,
    ClientID INT,
    FirstName NVARCHAR(100),
    ActionType NVARCHAR(20),
    ActionDate DATETIME
);
