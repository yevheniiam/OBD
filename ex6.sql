SELECT * FROM Agent WHERE Experience > 5 AND LastName LIKE 'S%';

SELECT * FROM Agent WHERE Address LIKE '%CA%' AND NOT Address LIKE 'New%';

SELECT * FROM Contract WHERE InsuranceAmount LIKE '2%';

SELECT * FROM Agent WHERE Address LIKE '%NY%' OR Address LIKE '%LA%';

SELECT * FROM Agent WHERE Address LIKE '%St%' OR Address LIKE '%Ave%';
