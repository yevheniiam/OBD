SELECT 
  AgentID,
  CONCAT(FirstName, ' ', LastName) AS FullName
FROM Agent;

SELECT 
  EventID,
  EventDescription,
  LEN(EventDescription) AS DescriptionLength
FROM InsuranceEvents;


SELECT 
  EventID,
  EventDescription,
  UPPER(EventDescription) AS UpperCaseDescription
FROM InsuranceEvents;
