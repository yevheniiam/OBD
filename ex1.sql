SELECT 'Agent' AS TableName, COUNT(*) AS RecordCount FROM Agent
UNION ALL
SELECT 'Client', COUNT(*) FROM Client
UNION ALL
SELECT 'InsuranceTypes', COUNT(*) FROM InsuranceTypes
UNION ALL
SELECT 'Cabinet' AS TableName, COUNT(*) AS RecordCount FROM Cabinet
UNION ALL
SELECT 'Agent_Cabinet', COUNT(*) FROM Agent_Cabinet
UNION ALL
SELECT 'InsuranceEvents', COUNT(*) FROM InsuranceEvents
UNION ALL
SELECT 'Agent_Type_of_Insurance', COUNT(*) FROM Agent_Type_of_Insurance
UNION ALL
SELECT 'Contract', COUNT(*) FROM Contract;