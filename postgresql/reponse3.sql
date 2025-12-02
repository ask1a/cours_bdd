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

--Calculer le montant total des ventes par client.

--Afficher les commandes passées en 2025 et leur nombre.

--Calculer le prix minimum, maximum et moyen des produits commandés par catégorie.

--Afficher les produits dont le stock est un multiple de 5 (utiliser %).
