SELECT * FROM clients
WHERE date_inscription >= '2025-01-01';

SELECT * FROM clients
WHERE nom LIKE '%e%' AND email LIKE '%e%';

SELECT * FROM clients
WHERE email = 'NULL';

SELECT * FROM clients
WHERE 5 < client_id AND client_id < 10;

SELECT * FROM clients
WHERE nom NOT LIKE 'm%';

SELECT * FROM clients
WHERE date_inscription <= '2023-01-01'
AND nom LIKE '%ad%';

SELECT * FROM clients
WHERE email IN ('alice.dupont@exemple.com', 'alice.dupont@exemple.com');

SELECT * FROM clients
WHERE '2024-01-01'< date_inscription 
AND date_inscription < '2024-03-31';

SELECT * FROM clients
WHERE nom NOT LIKE 'Dupont';