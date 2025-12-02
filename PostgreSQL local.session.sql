SELECT client_id, count(client_id) as nombres_commandes
FROM commandes
GROUP BY client_id
HAVING count(client_id)<5;


-- produit avec un prix moyen de 800
SELECT categorie, avg(prix) as prix_moyen
FROM produits
GROUP BY produit_id
HAVING avg(prix) > 800;

-- commande dont mt > 1000

SELECT commande_id, sum(quantite*prix_unitaire) as montant_total
FROM lignes_commandes
GROUP BY commande_id
HAVING sum(quantite * prix_unitaire) > 1000;

-- famille de produit dont le stock cumulé est inférieur

--- Exercice de la partie sql4
-- Afficher les produits dont le prix est supérieur au prix moyen 

SELECT p.produit_id, p.nom, p.prix
FROM produits p
WHERE p.prix > (SELECT AVG(prix) FROM produits);


--3
SELECT commande_id, client_id, commande_date,
       CASE
           WHEN commande_date > '2025-01-01' THEN 'Récentes'
           ELSE 'Anciennes'
       END AS statut_commande
FROM commandes;

-- 4
SELECT produit_id, nom, prix,
       CASE
           WHEN prix < 50 THEN 'Bas'
           WHEN prix BETWEEN 50 AND 200 THEN 'Moyen'
           ELSE 'Élevé'
       END AS categorie_prix
FROM produits;

-- 5 
SELECT client_id, nom, date_inscription,
       CASE
           WHEN date_inscription > '2024-01-01' THEN 'Nouveau'
           ELSE 'Ancien'
       END AS statut_client
FROM clients;

-- 6 
SELECT p.produit_id, p.nom, p.prix, c.quantite,
       CASE
           WHEN c.quantite < 5 THEN 'Stock critique'
           ELSE 'Stock suffisant'
       END AS statut_stock
FROM produits p
JOIN commandes c ON p.produit_id = c.produit_id;

-- 7 
SELECT client_id, produit_id, nom, prix
FROM produits p
WHERE prix = (
    SELECT MAX(prix)
    FROM produits
    JOIN commandes c ON p.produit_id = c.produit_id
    WHERE c.client_id = p.client_id
);


-- 8
SELECT commande_id, client_id, statut,
       CASE statut
           WHEN 'pending' THEN 'En attente'
           WHEN 'shipped' THEN 'Expédiée'
           WHEN 'delivered' THEN 'Livrée'
           ELSE 'Inconnu'
       END AS statut_detailed
FROM commandes;

-- 9
SELECT ligne_commande_id, commande_id, produit_id, quantite, prix_unitaire,
       quantite * prix_unitaire AS montant_total,
       CASE
           WHEN quantite * prix_unitaire < 50 THEN 'Petite commande'
           WHEN quantite * prix_unitaire BETWEEN 50 AND 200 THEN 'Moyenne commande'
           ELSE 'Grande commande'
       END AS classification_commande
FROM lignes_commande;

-- 10
SELECT ligne_commande_id, commande_id, produit_id, quantite, prix_unitaire,
       quantite * prix_unitaire AS montant_total,
       CASE
           WHEN quantite * prix_unitaire < 50 THEN 'Petite commande'
           WHEN quantite * prix_unitaire BETWEEN 50 AND 200 THEN 'Moyenne commande'
           ELSE 'Grande commande'
       END AS classification_commande
FROM lignes_commande;
