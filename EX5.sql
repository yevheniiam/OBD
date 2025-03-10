-- Вибірка агентів, чії імена починаються з "A" або прізвище містить "son"
SELECT AgentID, FirstName, LastName, Experience
FROM Agent
WHERE FirstName LIKE 'A%'  -- Імена, що починаються на "A"
   OR LastName LIKE '%son%'  -- Прізвища, що містять "son";
