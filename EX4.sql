-- Вибірка агентів, що працюють з типами страхування 1 або 3
-- і їх досвід більше 3 років
SELECT Agent.AgentID, Agent.FirstName, Agent.LastName, Agent.Experience
FROM Agent
JOIN Agent_Type_of_Insurance ON Agent.AgentID = Agent_Type_of_Insurance.AgentID
WHERE (Agent_Type_of_Insurance.InsuranceTypeID = 1 OR Agent_Type_of_Insurance.InsuranceTypeID = 3)
  AND Agent.Experience > 3;
