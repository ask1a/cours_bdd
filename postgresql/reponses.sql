-- ## Exercice 1 ##  
-- Question 1 :
-- SELECT * FROM clients WHERE date_inscription BETWEEN '2025-01-01' and '2025-12-31';

-- Question 2 :
-- SELECT nom, email FROM clients WHERE nom LIKE '%e%';

-- Question 3 :
-- SELECT * FROM clients WHERE email IS NULL;

-- Question 4 :
-- SELECT * FROM clients WHERE client_id BETWEEN 5 AND 10;

-- Question 5 :
-- SELECT * FROM clients WHERE nom NOT LIKE 'M%';

-- Question 6 :
-- SELECT * FROM clients WHERE date_inscription<'2023-01-01' OR nom LIKE '%ad%';

-- Question 7 :
-- SELECT * FROM clients WHERE email IN ('alice.dupont@example.com', 'karim.haddad@example.com');

-- Question 8 :
-- SELECT * FROM clients WHERE date_inscription BETWEEN '2024-01-01' AND '2024-03-31';

-- Question 9 :
-- SELECT * FROM clients WHERE nom NOT LIKE 'Alice Dupont';


-- ## Exercice 2 ##  
-- Question 1 :
-- SELECT cl.client_id, cl.nom, co.commande_id FROM clients cl LEFT JOIN commandes co ON cl.client_id = co.client_id;

-- Question 2 :
-- SELECT co.commande_id, cl.nom, co.statut FROM commandes co LEFT JOIN clients cl ON co.client_id = cl.client_id;

-- Question 3 :
-- SELECT DISTINCT cl.nom, p.nom FROM clients cl 
-- INNER JOIN commandes co ON cl.client_id=co.client_id
-- INNER JOIN lignes_commandes lg ON co.commande_id=lg.commande_id
-- INNER JOIN produits p ON lg.produit_id=p.produit_id
-- WHERE cl.nom LIKE 'Alice Dupont';

-- Question 4 :
-- SELECT cl.nom FROM clients cl LEFT JOIN commandes co ON cl.client_id=co.client_id WHERE co.client_id IS NULL;

-- Question 5 :
-- SELECT co.commande_id, p.nom, lg.quantite FROM commandes co LEFT JOIN lignes_commandes lg ON co.commande_id=lg.commande_id INNER JOIN produits p ON lg.produit_id=p.produit_id;

-- Question 6 :
-- SELECT c.nom, p.nom FROM clients c LEFT JOIN commandes co on c.client_id=co.client_id INNER JOIN lignes_commandes lg ON co.commande_id=lg.commande_id INNER JOIN produits p ON lg.produit_id=p.produit_id;

-- Question 7 :
-- SELECT * FROM commandes;

-- Question 8 :
-- SELECT c.nom, p.nom FROM clients c CROSS JOIN produits p;


-- ## Exercice 3 ##  
-- Question 1 :
-- SELECT COUNT(*) AS nb_produits FROM produits;

-- Question 2 :
-- SELECT ROUND(AVG(prix),2) AS prix_moyen FROM produits GROUP BY categorie;

-- Question 3 :
-- SELECT commande_id, quantite*prix_unitaire AS montant_total FROM lignes_commandes;

-- Question 4 :
-- SELECT c.nom, COUNT(co.commande_id) AS nb_commande 
-- FROM clients c 
-- INNER JOIN commandes co ON c.client_id=co.client_id 
-- GROUP BY c.nom 
-- ORDER BY nb_commande DESC 
-- LIMIT 1;

-- Question 5 :
-- SELECT categorie, SUM(stock) as stock_total FROM produits GROUP BY categorie;

-- Question 6 :
-- SELECT categorie, ROUND(STDDEV(prix),2) AS dispersion_prix FROM produits GROUP BY categorie; 

-- Question 7 :
-- SELECT c.client_id, c.nom, SUM(lg.quantite*lg.prix_unitaire) AS montant_total FROM clients c LEFT JOIN commandes co ON c.client_id=co.client_id INNER JOIN lignes_commandes lg ON co.commande_id=lg.commande_id GROUP BY c.client_id;

-- Question 8 :
-- SELECT COUNT(*) FROM commandes WHERE EXTRACT(YEAR FROM date_commande)=2025;

-- Question 9 :
-- SELECT categorie, MIN(prix) as prix_min, MAX(prix) as prix_max, ROUND(AVG(prix),2) as prix_moyen FROM produits GROUP BY categorie;

-- Question 10 : 
-- SELECT * FROM produits WHERE stock%5=0;


