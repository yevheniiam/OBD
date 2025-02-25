CREATE TABLE Agent (
    AgentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address VARCHAR(200),
    Experience INT NOT NULL,
    Surname VARCHAR(200)
);

CREATE TABLE Client (
    ClientID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address VARCHAR(200),
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    Age INT CHECK (Age >= 18),
    Surname VARCHAR(50)
);

CREATE TABLE Contract (
    ContractID INT PRIMARY KEY,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL CHECK (StartDate <= EndDate),
    InsuranceAmount DECIMAL(10,2) CHECK (InsuranceAmount > 0) NOT NULL ,
    CompanyPercentage DECIMAL(3,2) CHECK (CompanyPercentage BETWEEN 0 AND 1) NOT NULL,
    AgentID INT NOT NULL,
    ClientID INT NOT NULL,
    Payout INT,
    FOREIGN KEY (AgentID) REFERENCES Agent(AgentID),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
);

CREATE TABLE InsuranceTypes (
    InsuranceTypeID INT PRIMARY KEY,
    Name VARCHAR(50) UNIQUE NOT NULL,
    Description VARCHAR(200) NOT NULL
);

CREATE TABLE InsuranceEvents (
    EventID INT PRIMARY KEY,
    AmountOfPayments INT,
    EventDescription VARCHAR(200)
);

CREATE TABLE Cabinet (
    CabinetID INT PRIMARY KEY,
    Number INT UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL
);

CREATE TABLE Agent_Cabinet (
    AgentID INT NOT NULL,
    CabinetID INT NOT NULL,
    FOREIGN KEY (AgentID) REFERENCES Agent(AgentID),
    FOREIGN KEY (CabinetID) REFERENCES Cabinet(CabinetID)
);

CREATE TABLE Agent_Type_of_Insurance (
    AgentID INT NOT NULL,
    InsuranceTypeID INT NOT NULL,
    FOREIGN KEY (AgentID) REFERENCES Agent(AgentID),
    FOREIGN KEY (InsuranceTypeID) REFERENCES InsuranceTypes(InsuranceTypeID)
);
