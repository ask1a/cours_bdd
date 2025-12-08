-- question 1
SELECT * FROM clients WHERE date_inscription > '2025-01-01';

-- question 2
select nom, email from clients WHERE nom like 'e%';

-- question 3
select * from clients where email is NULL;

-- question 4
select * from clients where client_id BETWEEN 5 and 10;

-- question 6
SELECT * from clients WHERE nom not LIKE 'M%';

-- question 7
SELECT * FROM clients WHERE date_inscription < '2023-01-01' AND nom LIKE '%ad%';

-- question 8
SELECT * FROM clients WHERE email IN ('alice@gmail.com', 'bob@mail.com');

-- question 9 
select * from clients where date_inscription BETWEEN '2024-01-01' and '2024-03-01';

-- question 10
SELECT * FROM clients WHERE nom not LIKE '%Dupont';




-- -------------------------
-- exerice sur les jointures 

SELECT c.client_id, c.nom, COUNT(DISTINCT p.produit_id) AS nb_produits
FROM clients c
INNER JOIN commandes co ON c.client_id = co.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id
GROUP BY c.client_id, c.nom
HAVING COUNT(DISTINCT p.produit_id) >= 2;


SELECT p.produit_id, p.nom AS produit, lc.quantite
FROM clients c
INNER JOIN commandes co ON c.client_id = co.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id
WHERE c.nom = 'Alice Dupont';


SELECT c.client_id, c.nom, c.email
FROM clients c
LEFT JOIN commandes co ON c.client_id = co.client_id
WHERE co.commande_id IS NULL;


--  --------------------------------------------
-- les fonctions d'agrégation
-- 1
SELECT COUNT(*) AS nombre_produits
FROM produits;

-- 2
SELECT categorie, AVG(prix_unitaire) AS prix_moyen
FROM produits
GROUP BY categorie;

-- 3 
SELECT co.commande_id,
       SUM(lc.quantite * p.prix_unitaire) AS montant_total
FROM commandes c
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id
GROUP BY co.commande_id;

-- 4
SELECT c.client_id, c.nom, COUNT(co.commande_id) AS nb_commandes
FROM clients c
LEFT JOIN commandes co ON c.client_id = co.client_id
GROUP BY c.client_id, c.nom
ORDER BY nb_commandes DESC
LIMIT 1;

-- 5
SELECT categorie AS famille, SUM(stock) AS stock_total
FROM produits
GROUP BY categorie;

-- 6
SELECT STDDEV(prix_unitaire) AS ecart_type_prix
FROM produits;

-- 7
SELECT c.client_id, c.nom,
       SUM(lc.quantite * p.prix_unitaire) AS montant_total_ventes
FROM clients c
INNER JOIN commandes co ON c.client_id = co.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id
GROUP BY c.client_id, c.nom
ORDER BY montant_total_ventes DESC;

-- 8 
SELECT *
FROM commandes
WHERE YEAR(date_commande) = 2025;


-- 9 
SELECT MIN(p.prix_unitaire) AS prix_minimum,
       MAX(p.prix_unitaire) AS prix_maximum,
       AVG(p.prix_unitaire) AS prix_moyen
FROM produits p
INNER JOIN lignes_commandes lc ON p.produit_id = lc.produit_id;


-- 10
SELECT produit_id, nom, stock
FROM produits
WHERE stock % 5 = 0;
