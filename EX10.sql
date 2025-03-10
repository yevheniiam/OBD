SELECT  
    a.AgentID, 
    a.FirstName, 
    a.LastName, 
    (SELECT COUNT(*) 
     FROM Agent_Type_of_Insurance atoi 
     WHERE atoi.AgentID = a.AgentID) AS NumberOfInsuranceTypes, 
    AVG(a.Experience) AS AverageExperience
FROM 
    Agent a
JOIN 
    Agent_Type_of_Insurance atoi ON a.AgentID = atoi.AgentID
JOIN 
    InsuranceTypes it ON atoi.InsuranceTypeID = it.InsuranceTypeID
WHERE 
    a.Experience > 5 
    AND it.Name IN ('Life Insurance', 'Health Insurance', 'Auto Insurance')
GROUP BY 
    a.AgentID, a.FirstName, a.LastName
HAVING 
    COUNT(atoi.InsuranceTypeID) >= 2 
ORDER BY 
    AverageExperience DESC;
