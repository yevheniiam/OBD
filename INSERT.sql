INSERT INTO Client (ClientID, FirstName, LastName, Address, PhoneNumber, Age, Surname) VALUES
(101, 'Sophia', 'Miller', '123 Elm St, CA', '555-100-0001', 25, 'Miller'),
(102, 'James', 'Wilson', '456 Oak St, NY', '555-100-0002', 40, 'Wilson'),
(103, 'Olivia', 'Anderson', '789 Pine St, TX', '555-100-0003', 30, 'Anderson'),
(104, 'Ethan', 'Thomas', '321 Cedar St, WA', '555-100-0004', 22, 'Thomas'),
(105, 'Mia', 'Taylor', '654 Maple St, NV', '555-100-0005', 35, 'Taylor'),
(106, 'William', 'Martinez', '741 Birch St, AZ', '555-100-0006', 28, 'Martinez'),
(107, 'Isabella', 'Harris', '852 Redwood St, CO', '555-100-0007', 42, 'Harris'),
(108, 'Benjamin', 'Clark', '963 Cypress St, GA', '555-100-0008', 33, 'Clark'),
(109, 'Charlotte', 'Lewis', '147 Dogwood St, NC', '555-100-0009', 27, 'Lewis'),
(110, 'Alexander', 'Young', '258 Poplar St, MI', '555-100-0010', 45, 'Young'),
(111, 'Amelia', 'Hall', '369 Fir St, OH', '555-100-0011', 31, 'Hall'),
(112, 'Mason', 'Allen', '741 Palm St, OR', '555-100-0012', 29, 'Allen'),
(113, 'Harper', 'King', '852 Magnolia St, PA', '555-100-0013', 36, 'King'),
(114, 'Elijah', 'Scott', '963 Aspen St, VA', '555-100-0014', 24, 'Scott'),
(115, 'Ava', 'Green', '147 Cedar St, MA', '555-100-0015', 41, 'Green'),
(116, 'Logan', 'Adams', '258 Elm St, TN', '555-100-0016', 32, 'Adams'),
(117, 'Sofia', 'Baker', '369 Birch St, KY', '555-100-0017', 30, 'Baker'),
(118, 'Lucas', 'Gonzalez', '741 Pine St, SC', '555-100-0018', 39, 'Gonzalez'),
(119, 'Liam', 'Nelson', '852 Maple St, AL', '555-100-0019', 23, 'Nelson'),
(120, 'Emily', 'Carter', '963 Oak St, MO', '555-100-0020', 38, 'Carter'),
(121, 'Jacob', 'Mitchell', '147 Walnut St, IN', '555-100-0021', 26, 'Mitchell'),
(122, 'Ella', 'Perez', '258 Spruce St, LA', '555-100-0022', 37, 'Perez'),
(123, 'Evelyn', 'Roberts', '369 Chestnut St, WI', '555-100-0023', 34, 'Roberts'),
(124, 'Henry', 'Turner', '741 Redwood St, MN', '555-100-0024', 29, 'Turner'),
(125, 'Scarlett', 'Phillips', '852 Cypress St, CO', '555-100-0025', 43, 'Phillips');
INSERT INTO Agent (AgentID, FirstName, LastName, Address, Experience, Surname)
VALUES
(101, 'John', 'Doe', '123 Main St', 5, 'Doe'),
(102, 'Jane', 'Smith', '456 Oak St', 3, 'Smith'),
(103, 'Michael', 'Johnson', '789 Pine St', 7, 'Johnson'),
(104, 'Emily', 'Davis', '321 Elm St', 4, 'Davis'),
(105, 'Chris', 'Brown', '654 Maple St', 6, 'Brown'),
(106, 'Sarah', 'Wilson', '987 Birch St', 2, 'Wilson'),
(107, 'David', 'Moore', '159 Cedar St', 8, 'Moore'),
(108, 'Laura', 'Taylor', '753 Ash St', 3, 'Taylor'),
(109, 'James', 'Anderson', '246 Fir St', 5, 'Anderson'),
(110, 'Linda', 'Thomas', '369 Redwood St', 4, 'Thomas');

INSERT INTO InsuranceTypes (InsuranceTypeID, Name, Description) 
VALUES 
(1000, 'Life Insurance', 'Coverage for life insurance policies'),
(1001, 'Health Insurance', 'Coverage for medical expenses'),
(1002, 'Auto Insurance', 'Coverage for automobile-related accidents and damages');
INSERT INTO Agent_Type_of_Insurance (AgentID, InsuranceTypeID)
VALUES
(1001, 1001),  -- Агент 101 работает с Life Insurance
(1001, 1002),  -- Агент 101 работает с Health Insurance
(1001, 1003),  -- Агент 102 работает с Auto Insurance
(103, 1004),  -- Агент 103 работает с Home Insurance
(104, 1005),  -- Агент 104 работает с Travel Insurance
(105, 1001),  -- Агент 105 работает с Life Insurance
(106, 1002),  -- Агент 106 работает с Health Insurance
(107, 1003),  -- Агент 107 работает с Auto Insurance
(108, 1004),  -- Агент 108 работает с Home Insurance
(109, 1005);  -- Агент 109 работает с Travel Insurance
INSERT INTO Agent_Type_of_Insurance (AgentID, InsuranceTypeID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25);
INSERT INTO InsuranceEvents (EventID, AmountOfPayments, EventDescription) VALUES
(1, 1000, 'Payment for life insurance claim'),
(2, 5000, 'Health insurance claim for surgery'),
(3, 1500, 'Auto insurance claim for car accident'),
(4, 2000, 'Home insurance claim for fire damage'),
(5, 3000, 'Travel insurance claim for lost luggage'),
(6, 400, 'Pet insurance claim for treatment of injury'),
(7, 20000, 'Flood insurance claim for property damage'),
(8, 10000, 'Earthquake insurance claim for home damages'),
(9, 700, 'Renters insurance claim for theft of belongings'),
(10, 1200, 'Business insurance claim for property damage'),
(11, 1500, 'Fire insurance claim for house fire'),
(12, 500, 'Cyber insurance claim for data breach'),
(13, 3000, 'Combination life and health insurance claim'),
(14, 2500, 'Long-term care insurance claim for elderly care'),
(15, 6000, 'Critical illness insurance claim for cancer treatment'),
(16, 4500, 'Workers compensation insurance claim for injury'),
(17, 7000, 'Mortgage insurance claim for house foreclosure'),
(18, 8000, 'Terrorism insurance claim for property damage'),
(19, 300, 'Product liability insurance claim for injury'),
(20, 5000, 'Marine insurance claim for cargo damage'),
(21, 9000, 'Environmental insurance claim for pollution cleanup'),
(22, 3500, 'Disability insurance claim for long-term disability'),
(23, 5000, 'Business interruption insurance claim'),
(24, 10000, 'Car and home insurance claim for both damages'),
(25, 3000, 'Travel and health insurance claim for medical expenses abroad');
INSERT INTO Contract (ContractID, StartDate, EndDate, InsuranceAmount, CompanyPercentage, AgentID, ClientID, Payout) VALUES
(201, '2023-01-15', '2024-01-15', 10000.50, 0.10, 1, 101, 1),
(202, '2022-06-20', '2023-06-20', 15000.75, 0.15, 2, 102, 0),
(203, '2021-03-10', '2024-03-10', 5000.25, 0.12, 3, 103, 1),
(204, '2022-12-01', '2025-12-01', 20000.00, 0.20, 4, 104, 0),
(205, '2023-05-05', '2024-05-05', 12000.30, 0.18, 5, 105, 1),
(206, '2022-07-10', '2025-07-10', 25000.60, 0.22, 6, 106, 0),
(207, '2021-08-15', '2024-08-15', 18000.40, 0.17, 7, 107, 1),
(208, '2023-09-05', '2024-09-05', 22000.80, 0.19, 8, 108, 0),
(209, '2020-10-12', '2024-10-12', 14000.90, 0.14, 9, 109, 1),
(210, '2022-11-20', '2025-11-20', 30000.00, 0.25, 10, 110, 0),
(211, '2021-04-14', '2024-04-14', 13000.70, 0.16, 11, 111, 1),
(212, '2023-02-28', '2024-02-28', 19000.50, 0.12, 12, 112, 0),
(213, '2022-05-30', '2025-05-30', 21000.90, 0.21, 13, 113, 1),
(214, '2021-06-18', '2024-06-18', 11000.30, 0.10, 14, 114, 0);
