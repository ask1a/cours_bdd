SELECT * FROM clients WHERE date_inscription BETWEEN '2025-01-01' AND '2025-12-31';
SELECT nom,email FROM clients WHERE nom LIKE'%e%' and email LIKE '%e%';
SELECT nom FROM clients WHERE email IS NULL;
SELECT nom FROM clients WHERE client_id BETWEEN 5 and 10;
SELECT * FROM clients WHERE nom NOT LIKE 'M%';
SELECT * FROM clients WHERE date_inscription BETWEEN '2023-01-01' AND '2023-12-31' AND nom LIKE '%ad%';
SELECT * FROM clients WHERE email IN ('alice@mail.com', 'bob@mail.com');
SELECT * FROM clients WHERE date_inscription BETWEEN '2024-01-01' AND '2024-03-31';
SELECT * FROM clients WHERE nom != 'Dupont';
