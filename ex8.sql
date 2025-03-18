SELECT Agent.FirstName AS AgentFirstName, Agent.LastName AS AgentLastName, Client.FirstName AS ClientFirstName, Client.LastName AS ClientLastName
FROM Agent
LEFT JOIN Contract ON Agent.AgentID = Contract.AgentID
LEFT JOIN Client ON Contract.ClientID = Client.ClientID;

SELECT Client.FirstName AS ClientFirstName, Client.LastName AS ClientLastName, Agent.FirstName AS AgentFirstName, Agent.LastName AS AgentLastName
FROM Client
RIGHT JOIN Contract ON Client.ClientID = Contract.ClientID
RIGHT JOIN Agent ON Contract.AgentID = Agent.AgentID;

SELECT Agent.FirstName AS AgentFirstName, Agent.LastName AS AgentLastName, Client.FirstName AS ClientFirstName, Client.LastName AS ClientLastName
FROM Agent
FULL JOIN Contract ON Agent.AgentID = Contract.AgentID
FULL JOIN Client ON Contract.ClientID = Client.ClientID;

SELECT Agent.FirstName AS AgentFirstName, Agent.LastName AS AgentLastName, Agent_Type_of_Insurance.InsuranceTypeID
FROM Agent
LEFT JOIN Agent_Type_of_Insurance ON Agent.AgentID = Agent_Type_of_Insurance.AgentID;

SELECT Agent.FirstName AS AgentFirstName, Agent.LastName AS AgentLastName, Client.FirstName AS ClientFirstName, Client.LastName AS ClientLastName
FROM Agent
LEFT JOIN Contract ON Agent.AgentID = Contract.AgentID
LEFT JOIN Client ON Contract.ClientID = Client.ClientID;
