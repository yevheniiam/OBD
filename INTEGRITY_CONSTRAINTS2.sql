-- 1. Обмеження домена: тип даних і діапазон значень (CHECK на вік)
IF NOT EXISTS (
    SELECT * FROM sys.check_constraints WHERE name = 'CHK_ClientAge'
)
BEGIN
    ALTER TABLE Client
    ADD CONSTRAINT CHK_ClientAge CHECK (Age >= 18);
END

-- 2. Обмеження атрибута: NOT NULL і UNIQUE
ALTER TABLE Agent
ALTER COLUMN PhoneNumber NVARCHAR(50) NOT NULL;

IF NOT EXISTS (
    SELECT * FROM sys.objects WHERE type = 'UQ' AND name = 'UQ_AgentPhone' AND parent_object_id = OBJECT_ID('Agent')
)
BEGIN
    ALTER TABLE Agent
    ADD CONSTRAINT UQ_AgentPhone UNIQUE (PhoneNumber);
END

-- 3. Обмеження кортежу: перевірка залежності між стовпцями
IF NOT EXISTS (
    SELECT * FROM sys.check_constraints WHERE name = 'CHK_ContractDates'
)
BEGIN
    ALTER TABLE Contract
    ADD CONSTRAINT CHK_ContractDates CHECK (EndDate IS NULL OR EndDate >= StartDate);
END

-- 4. Обмеження відношення: первинний ключ та унікальні комбінації
IF NOT EXISTS (
    SELECT * FROM sys.key_constraints WHERE name = 'PK_Agent'
)
BEGIN
    ALTER TABLE Agent
    ADD CONSTRAINT PK_Agent PRIMARY KEY (AgentID);
END

IF NOT EXISTS (
    SELECT * FROM sys.objects WHERE type = 'UQ' AND name = 'UQ_ClientName' AND parent_object_id = OBJECT_ID('Client')
)
BEGIN
    ALTER TABLE Client
    ADD CONSTRAINT UQ_ClientName UNIQUE (FirstName, LastName);
END

-- 5. Обмеження бази даних: зовнішній ключ між таблицями
IF NOT EXISTS (
    SELECT * FROM sys.foreign_keys WHERE name = 'FK_Contract_Client'
)
BEGIN
    ALTER TABLE Contract
    ADD CONSTRAINT FK_Contract_Client FOREIGN KEY (ClientID) REFERENCES Client(ClientID);
END

IF NOT EXISTS (
    SELECT * FROM sys.foreign_keys WHERE name = 'FK_Contract_Agent'
)
BEGIN
    ALTER TABLE Contract
    ADD CONSTRAINT FK_Contract_Agent FOREIGN KEY (AgentID) REFERENCES Agent(AgentID);
END
