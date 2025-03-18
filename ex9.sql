SELECT FirstName, LastName, Experience
FROM Agent
WHERE AgentID IN (SELECT AgentID FROM Contract WHERE InsuranceAmount > 15000);

SELECT ContractID, StartDate, EndDate, InsuranceAmount
FROM Contract
WHERE AgentID IN (SELECT AgentID FROM Agent WHERE Experience > 10);

SELECT ContractID, InsuranceAmount
FROM Contract
WHERE InsuranceAmount > (SELECT AVG(InsuranceAmount) FROM Contract);

SELECT ContractID, AgentID, InsuranceAmount
FROM Contract
WHERE InsuranceAmount = (
    SELECT MAX(InsuranceAmount)
    FROM Contract AS C
    WHERE C.AgentID = Contract.AgentID
);

SELECT FirstName, LastName, Address
FROM Agent
WHERE AgentID IN (
    SELECT DISTINCT AgentID
    FROM Contract
    WHERE InsuranceAmount > 15000
);
