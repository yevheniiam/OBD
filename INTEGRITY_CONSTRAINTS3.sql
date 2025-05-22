-- 1. Обмеження домена: тип даних і діапазон значень (CHECK на вік)
ALTER TABLE Client
ADD CONSTRAINT CHK_ClientAge CHECK (Age >= 18);

-- 2. Обмеження атрибута: NOT NULL і UNIQUE
ALTER TABLE Agent
ALTER COLUMN PhoneNumber NVARCHAR(50) NOT NULL;

ALTER TABLE Agent
ADD CONSTRAINT UQ_AgentPhone UNIQUE (PhoneNumber);

-- 3. Обмеження кортежу: перевірка залежності між стовпцями
ALTER TABLE Contract
ADD CONSTRAINT CHK_ContractDates CHECK (EndDate IS NULL OR EndDate >= StartDate);

-- 4. Обмеження відношення: первинний ключ та унікальні комбінації
ALTER TABLE Agent
ADD CONSTRAINT PK_Agent PRIMARY KEY (AgentID);

ALTER TABLE Client
ADD CONSTRAINT UQ_ClientName UNIQUE (FirstName, LastName);

-- 5. Обмеження бази даних: зовнішній ключ між таблицями
ALTER TABLE Contract
ADD CONSTRAINT FK_Contract_Client FOREIGN KEY (ClientID) REFERENCES Client(ClientID);

ALTER TABLE Contract
ADD CONSTRAINT FK_Contract_Agent FOREIGN KEY (AgentID) REFERENCES Agent(AgentID);
