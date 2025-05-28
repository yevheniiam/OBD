CREATE OR ALTER VIEW vClientAgentAgeDifference AS
SELECT 
    c.ClientID,
    c.FirstName AS ClientFirstName,
    c.LastName AS ClientLastName,
    a.FirstName AS AgentFirstName,
    a.LastName AS AgentLastName,
    c.Age,
    a.Experience,
    (c.Age - a.Experience) AS AgeExperienceDifference
FROM Client c
LEFT JOIN Agent a ON c.AgentID = a.AgentID;
