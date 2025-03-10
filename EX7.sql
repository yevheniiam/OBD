-- 1. Вибірка агентів і типів страхування, з якими вони працюють, з використанням LEFT JOIN
SELECT Agent.AgentID, Agent.FirstName, Agent.LastName, InsuranceTypes.Name AS InsuranceType
FROM Agent
LEFT JOIN Agent_Type_of_Insurance ON Agent.AgentID = Agent_Type_of_Insurance.AgentID
LEFT JOIN InsuranceTypes ON Agent_Type_of_Insurance.InsuranceTypeID = InsuranceTypes.InsuranceTypeID;

-- 2. Вибірка агентів та типів страхування за допомогою RIGHT JOIN
SELECT Agent.AgentID, Agent.FirstName, Agent.LastName, InsuranceTypes.Name AS InsuranceType
FROM Agent
RIGHT JOIN Agent_Type_of_Insurance ON Agent.AgentID = Agent_Type_of_Insurance.AgentID
RIGHT JOIN InsuranceTypes ON Agent_Type_of_Insurance.InsuranceTypeID = InsuranceTypes.InsuranceTypeID;

-- 3. Вибірка агентів і типів страхування за допомогою FULL JOIN
SELECT Agent.AgentID, Agent.FirstName, Agent.LastName, InsuranceTypes.Name AS InsuranceType
FROM Agent
FULL JOIN Agent_Type_of_Insurance ON Agent.AgentID = Agent_Type_of_Insurance.AgentID
FULL JOIN InsuranceTypes ON Agent_Type_of_Insurance.InsuranceTypeID = InsuranceTypes.InsuranceTypeID;
