SELECT MAX(AmountOfPayments) AS MaxPayment FROM InsuranceEvent;

 SELECT AVG(AmountOfPayments) AS AveragePayment FROM InsuranceEvent;

SELECT it.Name AS InsuranceType, SUM(ie.AmountOfPayments) AS TotalPayments
FROM InsuranceEvent ie
JOIN InsuranceTypes it ON ie.InsuranceTypeID = it.InsuranceTypeID
GROUP BY it.Name;
