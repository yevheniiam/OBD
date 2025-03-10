-- Вибірка агентів і типів страхування, з якими вони працюють
SELECT Agent.AgentID, Agent.FirstName, Agent.LastName, InsuranceTypes.Name AS InsuranceType
FROM Agent
JOIN Agent_Type_of_Insurance ON Agent.AgentID = Agent_Type_of_Insurance.AgentID
JOIN InsuranceTypes ON Agent_Type_of_Insurance.InsuranceTypeID = InsuranceTypes.InsuranceTypeID;
