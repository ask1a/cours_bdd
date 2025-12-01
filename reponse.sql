-- Questions pratiques

-- 1/
SELECT * FROM  clients WHERE date_inscription BETWEEN '2025-01-01' AND '2025-12-31';

-- 2/
SELECT nom, email FROM clients WHERE nom LIKE '%e%';

-- 3/
SELECT * FROM clients WHERE email IS NULL;

-- 4/
SELECT * FROM  clients WHERE client_id BETWEEN 5 AND 10;

-- 5/
SELECT * FROM clients WHERE nom NOT LIKE 'M%';

-- 6/
SELECT * FROM clients WHERE date_inscription < '2023-01-01';

-- 7/
SELECT * FROM clients WHERE email in ('alice.dupont@example.com', 'claire.leroy@yahoo.com');

-- 8/
SELECT * FROM clients WHERE date_inscription BETWEEN '2024-01-04' AND '2024-03-01';

-- 9/
SELECT * FROM clients WHERE nom NOT LIKE '%Dupont%';