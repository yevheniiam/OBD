-- Вибірка агентів, які мають досвід більше 3 років і працюють з типами страхування 1 або 3
SELECT AgentID, FirstName, LastName
FROM Agent
WHERE AgentID IN (
    -- Підзапит: вибірка агентів, які працюють з типами страхування 1 або 3
    SELECT AgentID
    FROM Agent_Type_of_Insurance
    WHERE InsuranceTypeID IN (1, 3)
)
AND Experience > 3;
