CREATE OR ALTER VIEW vClientContracts AS
SELECT 
    c.ClientID,
    c.FirstName,
    c.LastName,
    ct.ContractID,
    ct.StartDate
FROM Client c
JOIN Contract ct ON c.ClientID = ct.ClientID;
