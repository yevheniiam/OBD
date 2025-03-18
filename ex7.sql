SELECT Agent.FirstName, Agent.LastName, Contract.ContractID, Contract.StartDate, Contract.EndDate
FROM Agent
JOIN Contract ON Agent.AgentID = Contract.AgentID;

SELECT Contract.ContractID, Contract.StartDate, Contract.EndDate, Agent.FirstName AS AgentName, Client.FirstName AS ClientName
FROM Contract
JOIN Agent ON Contract.AgentID = Agent.AgentID
JOIN Client ON Contract.ClientID = Client.ClientID;

SELECT Contract.ContractID, Contract.InsuranceAmount, Agent.FirstName AS AgentName
FROM Contract
JOIN Agent ON Contract.AgentID = Agent.AgentID
WHERE Contract.InsuranceAmount > 15000;

SELECT Client.FirstName AS ClientName, Contract.ContractID, Contract.InsuranceAmount, Agent.FirstName AS AgentName
FROM Contract
JOIN Client ON Contract.ClientID = Client.ClientID
JOIN Agent ON Contract.AgentID = Agent.AgentID
WHERE Contract.InsuranceAmount > 20000;

SELECT Client.FirstName AS ClientFirstName, Client.LastName AS ClientLastName, Agent.FirstName AS AgentFirstName, Agent.LastName AS AgentLastName, Contract.InsuranceAmount
FROM Contract
JOIN Client ON Contract.ClientID = Client.ClientID
JOIN Agent ON Contract.AgentID = Agent.AgentID
WHERE Contract.InsuranceAmount > 20000;

