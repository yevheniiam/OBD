-- Створення таблиці Agent
CREATE TABLE Agent (
    AgentID INT PRIMARY KEY,                         -- Первинний ключ: унікальний ідентифікатор агента
    FirstName NVARCHAR(100) NOT NULL,                -- Не допускається NULL: ім’я агента обов’язкове
    LastName NVARCHAR(100) NOT NULL,                 -- Прізвище агента також обов’язкове
    PhoneNumber NVARCHAR(50) UNIQUE,                 -- Унікальне значення: не може бути однакових телефонів
    Email NVARCHAR(100) CHECK (Email LIKE '%@%')     -- Перевірка формату: email має містити символ "@"
);

-- Створення таблиці Client
CREATE TABLE Client (
    ClientID INT PRIMARY KEY,                        -- Первинний ключ: унікальний ідентифікатор клієнта
    FirstName NVARCHAR(100) NOT NULL,                -- Ім’я клієнта обов’язкове
    LastName NVARCHAR(100) NOT NULL,                 -- Прізвище обов’язкове
    PhoneNumber NVARCHAR(50) NOT NULL CHECK (LEN(PhoneNumber) >= 10), -- Телефон має бути щонайменше 10 символів
    Email NVARCHAR(100),                             -- Email не обов’язковий
    Age INT CHECK (Age >= 18),                       -- Клієнт повинен бути повнолітнім
    City NVARCHAR(100)                               -- Назва міста
);

-- Створення таблиці Contract
CREATE TABLE Contract (
    ContractID INT PRIMARY KEY,                      -- Унікальний ідентифікатор договору
    ClientID INT NOT NULL,                           -- Зовнішній ключ на клієнта
    AgentID INT NOT NULL,                            -- Зовнішній ключ на агента
    StartDate DATE NOT NULL,                         -- Дата початку договору
    EndDate DATE,                                    -- Дата завершення договору (може бути NULL)
    
    -- Забезпечення цілісності зовнішніх ключів:
    CONSTRAINT FK_Client FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    CONSTRAINT FK_Agent FOREIGN KEY (AgentID) REFERENCES Agent(AgentID),
    
    -- Перевірка логіки дат: дата завершення має бути після або дорівнювати даті початку
    CONSTRAINT CHK_Dates CHECK (EndDate IS NULL OR EndDate >= StartDate)
);
