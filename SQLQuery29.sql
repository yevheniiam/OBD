CREATE OR ALTER VIEW vEncryptedClients
WITH ENCRYPTION
AS
SELECT ClientID, FirstName, LastName, Age
FROM Client;
