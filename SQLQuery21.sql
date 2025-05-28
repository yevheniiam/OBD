CREATE OR ALTER VIEW vVIPClients AS
SELECT 
    ClientID,
    FirstName,
    LastName,
    ContractCount
FROM vClientContractCounts
WHERE ContractCount > 5;
