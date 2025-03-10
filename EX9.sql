-- Вибірка агентів з кількістю типів страхування більше 0
SELECT ati.InsuranceTypeID, COUNT(ati.AgentID) AS NumberOfAgents
FROM Agent_Type_of_Insurance ati
JOIN Agent a ON a.AgentID = ati.AgentID
GROUP BY ati.InsuranceTypeID
HAVING COUNT(ati.AgentID) > 0;
