BEGIN TRANSACTION;

-- 1. Оновлюю дані агента
UPDATE Agent
SET Experience = 15
WHERE AgentID = 1;

-- 2. Умова, яка викликає ROLLBACK, якщо немає жодного клієнта з певним номером телефону
IF (SELECT COUNT(*) FROM Client WHERE PhoneNumber = '000-000-0000') = 0
    ROLLBACK;
ELSE
    COMMIT;
