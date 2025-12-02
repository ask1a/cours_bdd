--Affiche tous les clients inscrits en 2025.
select * 
from clients
where date_inscription BETWEEN '2025-01-01' and '2025-12-31'; 

--Affiche uniquement les noms et emails des clients dont le nom contient la lettre "e".
select nom, email 
FROM clients 
WHERE nom like '%e%';

--Affiche les clients dont l’email est nul.
select nom, email 
FROM clients 
WHERE email is null;

--Affiche les clients dont l’id est compris entre 5 et 10.
select nom, client_id 
FROM clients 
where client_id BETWEEN 5 and 10;

--Affiche les clients dont le nom ne commence pas par "M".
SELECT nom 
FROM clients 
where nom not LIKE 'M%';

--Affiche les clients inscrits avant 2023 ou dont le nom contient "ad".
select nom, date_inscription
from clients
where date_inscription < '2023-01-01' or nom like '%ad%';

--Affiche les clients dont l’email appartient à une liste donnée (IN).
select nom
from clients
where email in ('emma.caron@example.com','laura.fontaine@gmail.com'); 

--Affiche les clients dont la date d’inscription est comprise entre janvier et mars 2024.
select nom
from clients
where date_inscription BETWEEN '2024-01-01' and '2024-03-31'; 

--Affiche les clients dont le nom est différent de "Dupont"
select nom
from clients
where nom != 'Dupont'; 