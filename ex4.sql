SELECT 
  AgentID,
  CONCAT(FirstName, ' ', LastName) AS FullName
FROM 
  Agent;

  SELECT 
  EventID,
  EventDescription,
  LEFT(EventDescription, 3) AS ShortPrefix
FROM 
  InsuranceEvents;


  SELECT 
  ClientID,
  FirstName,
  UPPER(FirstName) AS UppercaseFirstName
FROM 
  Client;
