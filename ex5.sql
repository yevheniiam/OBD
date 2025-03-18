SELECT * FROM Contract WHERE InsuranceAmount > 20000 OR CompanyPercentage > 0.15;

SELECT * FROM Agent WHERE NOT Address LIKE '%CA%';

SELECT * FROM Agent_Type_of_Insurance WHERE AgentID = 1 OR AgentID = 2;

SELECT * FROM Agent WHERE Experience > 5 AND NOT Address LIKE '%NY%';

SELECT * FROM Contract WHERE InsuranceAmount > 15000 AND (AgentID BETWEEN 1 AND 5);
