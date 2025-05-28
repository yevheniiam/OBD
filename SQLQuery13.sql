CREATE OR ALTER VIEW vw_ClientAgentInfo AS
SELECT 
    c.ClientID,
    c.FirstName AS ClientFirstName,
    c.LastName AS ClientLastName,
    a.FirstName + ' ' + a.LastName AS AgentFullName
FROM Client c
LEFT JOIN Agent a ON c.AgentID = a.AgentID;
