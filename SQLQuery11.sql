UPDATE Client
SET PhoneNumber = '1112223333'
WHERE ClientID = 10002;

-- Проверяем лог
SELECT * FROM PhoneChangeLog WHERE ClientID = 10002;
