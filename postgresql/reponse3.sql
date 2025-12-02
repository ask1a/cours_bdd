select * from produits;
select * from lignes_commandes;
select * from commandes;

--Compter le nombre de produits disponibles dans la table produits.
SELECT count(DISTINCT produit_id) 
FROM produits;

--Afficher le prix moyen des produits par catégorie (GROUP BY categorie).
SELECT AVG(prix), categorie 
FROM produits 
GROUP BY categorie;

--Calculer le montant total de chaque commande (somme des quantite * prix_unitaire).
SELECT lc.commande_id, SUM(lc.quantite * lc.prix_unitaire) AS "Montant total" 
FROM lignes_commandes lc
GROUP BY lc.commande_id
ORDER BY lc.commande_id;

--Afficher le client qui a passé le plus de commandes.
SELECT cl.nom, count(DISTINCT c.commande_id) as "Nombre de commandes"
FROM commandes c INNER JOIN clients cl ON c.client_id = cl.client_id
GROUP BY cl.nom
LIMIT 1;

--Calculer la somme des stocks disponibles par famille de produits.
SELECT famille, SUM(stock) as "Stock disponible"
FROM produits
GROUP BY famille;

--Afficher l’écart-type des prix des produits pour analyser la dispersion.
SELECT categorie, STDDEV(prix) as "Ecart-type des prix"
FROM produits
GROUP BY categorie;

--Calculer le montant total des ventes par client.
SELECT c.nom, SUM(lc.quantite * lc.prix_unitaire) AS "Montant total" 
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id
GROUP BY c.nom
ORDER BY "Montant total" DESC ;

--Afficher les commandes passées en 2025 et leur nombre.

--Calculer le prix minimum, maximum et moyen des produits commandés par catégorie.
SELECT p.categorie, MIN(prix_unitaire), MAX(prix_unitaire), AVG(prix_unitaire) 
FROM produits p INNER JOIN lignes_commandes lc ON p.produit_id = lc.produit_id
GROUP BY categorie;

--Calculer le prix minimum, maximum et moyen des produits commandés par famille.
SELECT p.famille, MIN(prix_unitaire), MAX(prix_unitaire), AVG(prix_unitaire) 
FROM produits p INNER JOIN lignes_commandes lc ON p.produit_id = lc.produit_id
GROUP BY famille;

--Afficher les produits dont le stock est un multiple de 5 (utiliser %).
SELECT
    produit_id,
    stock
FROM
    produits
GROUP BY
    produit_id
HAVING
    stock % 5 = 0;

--Afficher les catégories de produits dont le prix moyen est supérieur à 800
--Afficher les commandes dont le montant total (somme des quantités × prix unitaire) dépasse 1000.
--Afficher les familles de produits dont le stock cumulé est inférieur à 50.