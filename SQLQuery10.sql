INSERT INTO Client (ClientID, FirstName, LastName, PhoneNumber, Age, Address)
VALUES (10002, 'Мария', 'Петрова', '0987654321', 25, 'ул. Ленина, 10');

-- Проверяем лог
SELECT * FROM ClientLog WHERE ClientID = 10002;
