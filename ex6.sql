SELECT 
  ContractID,
  StartDate,
  YEAR(StartDate) AS StartYear
FROM Contract;


SELECT 
  ContractID,
  DATEDIFF(DAY, StartDate, EndDate) AS DurationInDays
FROM Contract;


SELECT 
  ContractID,
  EndDate,
  DATEDIFF(DAY, GETDATE(), EndDate) AS DaysRemaining
FROM Contract;
