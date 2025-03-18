SELECT 
    c.ContractID,
    c.StartDate AS ContractStartDate,
    c.EndDate AS ContractEndDate,
    it.Name AS InsuranceType, 
    a.FirstName AS AgentFirstName,
    a.LastName AS AgentLastName,
    a.Address AS AgentAddress, 
    a.Experience AS AgentExperience, 
    cab.PhoneNumber AS AgentPhone  
FROM 
    Contract c
JOIN 
    Client cl ON c.ClientID = cl.ClientID
JOIN 
    Agent a ON c.AgentID = a.AgentID
JOIN 
    Agent_Type_of_Insurance ati ON a.AgentID = ati.AgentID 
JOIN 
    dbo.InsuranceTypes it ON ati.InsuranceTypeID = it.InsuranceTypeID  
JOIN 
    Agent_Cabinet ac ON a.AgentID = ac.AgentID
JOIN 
    Cabinet cab ON ac.CabinetID = cab.CabinetID
WHERE 
    cl.ClientID = 114; 
