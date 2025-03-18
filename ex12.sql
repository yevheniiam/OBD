SELECT Client.ClientID, Client.FirstName, Client.LastName, Contract.InsuranceAmount
FROM Client
JOIN Contract ON Client.ClientID = Contract.ClientID
WHERE Contract.InsuranceAmount > 10000;

SELECT Client.ClientID, Client.FirstName, Client.LastName, AVG(Contract.InsuranceAmount) AS AverageInsurance
FROM Client
JOIN Contract ON Client.ClientID = Contract.ClientID
WHERE Client.Age > 30
GROUP BY Client.ClientID, Client.FirstName, Client.LastName;


SELECT Agent.AgentID, Agent.FirstName, Agent.LastName, SUM(Contract.InsuranceAmount) AS TotalInsurance
FROM Agent
JOIN Contract ON Agent.AgentID = Contract.AgentID
JOIN Client ON Contract.ClientID = Client.ClientID
WHERE Client.Age BETWEEN 25 AND 40
GROUP BY Agent.AgentID, Agent.FirstName, Agent.LastName;

SELECT Client.ClientID, Client.FirstName, Client.LastName, SUM(Contract.InsuranceAmount) AS TotalInsurance
FROM Client
JOIN Contract ON Client.ClientID = Contract.ClientID
WHERE Client.Age < 30 AND Contract.InsuranceAmount > 20000
GROUP BY Client.ClientID, Client.FirstName, Client.LastName;

SELECT Agent.AgentID, Agent.FirstName, Agent.LastName, AVG(Contract.InsuranceAmount) AS AverageInsurance
FROM Agent
JOIN Contract ON Agent.AgentID = Contract.AgentID
JOIN Client ON Contract.ClientID = Client.ClientID
WHERE Client.Address LIKE '%CA%'
GROUP BY Agent.AgentID, Agent.FirstName, Agent.LastName;
