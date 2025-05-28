CREATE OR ALTER VIEW vClientContractCounts AS
SELECT 
    c.ClientID,
    c.FirstName,
    c.LastName,
    COUNT(ct.ContractID) AS ContractCount
FROM Client c
LEFT JOIN Contract ct ON c.ClientID = ct.ClientID
GROUP BY c.ClientID, c.FirstName, c.LastName;
