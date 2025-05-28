UPDATE Client
SET Address = 'ул. Советская, 20'
WHERE ClientID = 10002;

-- Проверяем лог
SELECT * FROM AddressChangeLog WHERE ClientID = 10002;
