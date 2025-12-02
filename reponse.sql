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

SELECT c.nom, c.email, co.commande_id, co.date_commande
FROM clients c
INNER JOIN commandes co ON c.client_id = co.client_id;

SELECT c.nom, c.email, co.commande_id
FROM clients c
LEFT JOIN commandes co ON c.client_id = co.client_id;

SELECT co.commande_id, c.nom AS client, p.nom AS produit, lc.quantite
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id;

SELECT c.nom, co.commande_id
FROM clients c
FULL OUTER JOIN commandes co ON c.client_id = co.client_id;

SELECT c.nom, p.nom
FROM clients c
CROSS JOIN produits p;


SELECT * FROM commandes;

SELECT c.nom, co.commande_id
FROM clients c 
FULL OUTER JOIN commandes co ON c.client_id = co.client_id;

SELECT co.commande_id, co.statut, c.nom
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id;

SELECT p.nom as produit, c.nom as client
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id
WHERE c.nom = 'Alice Dupont';

-- Prix maximum et minimum des produits 
SELECT COUNT(*) AS nb_clients FROM clients;

SELECT AVG(prix) AS prix_moyen FROM produits;

SELECT COUNT(*) AS  nb_produits FROM produits;

-- affichage du prix moyen des produits par catégorie

SELECT p.categorie, AVG(prix) AS prix_moyen1 
FROM produits p
GROUP BY p.categorie;

SELECT * FROM commandes;

SELECT commande_id, SUM(quantite*prix_unitaire)
FROM lignes_commandes
GROUP BY commande_id;

SELECT c.nom, co.client_id, COUNT(*) AS nbre_commande
FROM commandes co 
INNER JOIN clients c ON c.client_id = co.client_id
GROUP BY co.client_id, c.nom
ORDER BY nbre_commande DESC
LIMIT 1;

-- SUM DES STOCKS PAR FAMILLE
SELECT famille, SUM(stock) as nbre_stock
FROM produits
GROUP BY famille;


-- Ecart type des prix des produits
SELECT STDDEV(prix) AS dispersion_prix 
FROM produits;

-- MONTANT TOTAL DES VENTES PAR CLIENT
SELECT c.client_id, SUM(quantite*prix_unitaire)
FROM lignes_commandes ls
INNER JOIN commandes co ON co.commande_id = ls.commande_id
INNER JOIN clients c ON co.client_id = c.client_id
GROUP BY c.client_id ;

-- TROUVER DES CLIENTS AVEC MOINS DE TROIS COMMANDES
SELECT client_id, COUNT(client_id) AS nombre_commandes
FROM Commandes
GROUP BY client_id
HAVING COUNT(client_id) < 3;

SELECT client_id, COUNT(client_id) AS nombre_commandes
FROM Commandes
GROUP BY client_id;

SELECT categorie, AVG(prix) AS prix_moyen_pro
FROM produits
GROUP BY categorie
HAVING AVG(prix) > 800;


SELECT commande_id, SUM(quantite*prix_unitaire)
FROM lignes_commandes
GROUP BY commande_id
HAVING SUM(quantite*prix_unitaire) > 1000;

SELECT famille, SUM(stock)
FROM produits
GROUP BY famille
HAVING SUM(stock) < 50;

-- CLIENT AYANT PASSé UNE COMMANDE 
SELECT nom, email
FROM clients
WHERE client_id IN (
    SELECT client_id
    FROM commandes
);

SELECT * FROM produits
WHERE prix < ( 
    SELECT AVG(prix)
    FROM produits
);

SELECT client_id
FROM (
    SELECT  client_id , COUNT(client_id) as nbre_commandes_unique
    FROM commandes
    GROUP BY client_id
) AS SUBQUERY
WHERE nbre_commandes_unique >=2;

SELECT * FROM (
    SELECT commande_id, 
           date_commande,
           CASE 
                WHEN date_commande < '2025-01-01' THEN 'ANCIENNES'
                ELSE 'RECENTES'
           END AS SUPPLEMENT_colonne
    FROM commandes
) AS SUPPLEMENT_TABLE;

SELECT nom, prix,
       CASE
           WHEN prix < 200 THEN 'BAS'
           WHEN prix BETWEEN 200 AND 600 THEN 'Moyen'
           ELSE 'Elevé'
       END AS categorie_prix
FROM produits;

SELECT nom, email,
       CASE
           WHEN date_inscription < '2024-01-01' THEN 'ANCIEN'
           ELSE 'NOUVEAU'
        END AS client_status
FROM clients;

SELECT co.commande_id, stock,
       CASE
           WHEN stock < 5 THEN 'CRITIQUE'
           ELSE 'NON CRITIQUE'
        END AS status_stock
FROM produits p
INNER JOIN lignes_commandes ls ON p.produit_id = ls.produit_id
INNER JOIN commandes co ON ls.commande_id = co.commande_id ;
