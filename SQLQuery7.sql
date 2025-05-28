CREATE TABLE AddressChangeLog (
    LogID INT IDENTITY PRIMARY KEY,
    ClientID INT,
    OldAddress NVARCHAR(200),
    NewAddress NVARCHAR(200),
    ChangeDate DATETIME
);
