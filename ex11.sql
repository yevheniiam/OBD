SELECT Agent.AgentID, Agent.FirstName, Agent.LastName, COUNT(Contract.ContractID) AS ContractCount
FROM Agent
JOIN Contract ON Agent.AgentID = Contract.AgentID
WHERE Contract.InsuranceAmount > 15000
GROUP BY Agent.AgentID, Agent.FirstName, Agent.LastName
ORDER BY ContractCount DESC;

SELECT Agent.AgentID, MAX(Contract.InsuranceAmount) AS MaxInsurance, MIN(Contract.InsuranceAmount) AS MinInsurance
FROM Agent
JOIN Contract ON Agent.AgentID = Contract.AgentID
GROUP BY Agent.AgentID;

SELECT Agent.FirstName, Agent.LastName, Contract.ContractID, Contract.InsuranceAmount
FROM Contract
JOIN Agent ON Contract.AgentID = Agent.AgentID
WHERE Contract.InsuranceAmount > 15000;

SELECT Agent.AgentID, AVG(Contract.InsuranceAmount) AS AverageInsurance
FROM Agent
JOIN Contract ON Agent.AgentID = Contract.AgentID
WHERE Contract.InsuranceAmount > 15000 AND Contract.Payout = 0
GROUP BY Agent.AgentID;

SELECT TOP 1 Agent.AgentID, Agent.FirstName, Agent.LastName, SUM(Contract.InsuranceAmount) AS TotalInsurance
FROM Agent
JOIN Contract ON Agent.AgentID = Contract.AgentID
WHERE Contract.ClientID IN (
    SELECT ClientID
    FROM Contract
    WHERE InsuranceAmount > 20000
)
GROUP BY Agent.AgentID, Agent.FirstName, Agent.LastName
ORDER BY TotalInsurance DESC;

