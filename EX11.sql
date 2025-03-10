SELECT 
    a.AgentID, 
    a.FirstName, 
    a.LastName, 
    a.Address, 
    a.Experience, 
    it.Name AS InsuranceType
FROM 
    Agent a
JOIN 
    Agent_Type_of_Insurance atoi ON a.AgentID = atoi.AgentID
JOIN 
    InsuranceTypes it ON atoi.InsuranceTypeID = it.InsuranceTypeID
WHERE 
    a.Experience > 5  -- Фільтрація агентів з досвідом більше 5 років
    AND it.Name IN ('Life Insurance', 'Health Insurance', 'Auto Insurance')  -- Агент має працювати з певними типами страхувань
ORDER BY 
    a.Experience DESC;  -- Сортування за досвідом (від найвищого до найнижчого)
