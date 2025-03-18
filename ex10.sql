SELECT Agent.FirstName, Agent.LastName, SUM(Contract.InsuranceAmount) AS TotalInsurance
FROM Agent
JOIN Contract ON Agent.AgentID = Contract.AgentID
GROUP BY Agent.AgentID
HAVING SUM(Contract.InsuranceAmount) > 20000;

SELECT Agent.FirstName, Agent.LastName, AVG(Contract.InsuranceAmount) AS AverageInsurance
FROM Agent
JOIN Contract ON Agent.AgentID = Contract.AgentID
GROUP BY Agent.AgentID;

SELECT Agent.AgentID, Agent.FirstName, Agent.LastName, COUNT(Contract.ContractID) AS ContractCount
FROM Agent
JOIN Contract ON Agent.AgentID = Contract.AgentID
GROUP BY Agent.AgentID, Agent.FirstName, Agent.LastName;

SELECT Agent.AgentID, Agent.FirstName, Agent.LastName, MAX(Contract.InsuranceAmount) AS MaxInsurance
FROM Agent
JOIN Contract ON Agent.AgentID = Contract.AgentID
GROUP BY Agent.AgentID, Agent.FirstName, Agent.LastName;

SELECT Agent.AgentID, Agent.FirstName, Agent.LastName, AVG(Contract.InsuranceAmount) AS AverageInsurance
FROM Agent
JOIN Contract ON Agent.AgentID = Contract.AgentID
GROUP BY Agent.AgentID, Agent.FirstName, Agent.LastName
HAVING AVG(Contract.InsuranceAmount) > 15000;
