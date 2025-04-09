SELECT 
  EventID,
  AmountOfPayments,
  SUM(AmountOfPayments) OVER(ORDER BY EventID) AS CumulativePayments
FROM 
  InsuranceEvents;
 

 SELECT 
  AgentID,
  SUM(InsuranceAmount) AS TotalAmount,
  RANK() OVER(ORDER BY SUM(InsuranceAmount) DESC) AS RankByAmount
FROM 
  Contract
GROUP BY 
  AgentID;


  SELECT 
  ContractID,
  InsuranceAmount,
  LAG(InsuranceAmount) OVER(ORDER BY ContractID) AS PreviousAmount,
  InsuranceAmount - LAG(InsuranceAmount) OVER(ORDER BY ContractID) AS Difference
FROM 
  Contract;
