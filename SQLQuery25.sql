CREATE OR ALTER VIEW vContractSummary AS
SELECT 
    ContractID, 
    InsuranceAmount AS ContractTotal, 
    StartDate AS ContractStartDate
FROM Contract;
