-- ## Exercice 1 ##  
-- Question 1 :
SELECT * FROM clients WHERE date_inscription BETWEEN '2025-01-01' and '2025-12-31';

-- Question 2 :
SELECT nom, email FROM clients WHERE nom LIKE '%e%';

-- Question 3 :
SELECT * FROM clients WHERE email IS NULL;

-- Question 4 :
SELECT * FROM clients WHERE client_id BETWEEN 5 AND 10;

-- Question 5 :
SELECT * FROM clients WHERE nom NOT LIKE 'M%';

-- Question 6 :
SELECT * FROM clients WHERE date_inscription<'2023-01-01' OR nom LIKE '%ad%';

-- Question 7 :
SELECT * FROM clients WHERE email IN ('alice.dupont@example.com', 'karim.haddad@example.com');

-- Question 8 :
SELECT * FROM clients WHERE date_inscription BETWEEN '2024-01-01' AND '2024-03-31';

-- Question 9 :
SELECT * FROM clients WHERE nom NOT LIKE 'Alice Dupont';


-- ## Exercice 2 ##  
-- Question 1 :
SELECT cl.client_id, cl.nom, co.commande_id FROM clients cl LEFT JOIN commandes co ON cl.client_id = co.client_id;

-- Question 2 :
SELECT co.commande_id, cl.nom, co.statut FROM commandes co LEFT JOIN clients cl ON co.client_id = cl.client_id;

-- Question 3 :
SELECT DISTINCT cl.nom, p.nom FROM clients cl 
INNER JOIN commandes co ON cl.client_id=co.client_id
INNER JOIN lignes_commandes lg ON co.commande_id=lg.commande_id
INNER JOIN produits p ON lg.produit_id=p.produit_id
WHERE cl.nom LIKE 'Alice Dupont';

-- Question 4 :
SELECT cl.nom FROM clients cl LEFT JOIN commandes co ON cl.client_id=co.client_id WHERE co.client_id IS NULL;

-- Question 5 :
SELECT co.commande_id, p.nom, lg.quantite FROM commandes co LEFT JOIN lignes_commandes lg ON co.commande_id=lg.commande_id INNER JOIN produits p ON lg.produit_id=p.produit_id;

-- Question 6 :
SELECT c.nom, p.nom FROM clients c LEFT JOIN commandes co on c.client_id=co.client_id INNER JOIN lignes_commandes lg ON co.commande_id=lg.commande_id INNER JOIN produits p ON lg.produit_id=p.produit_id;

-- Question 7 :
SELECT * FROM commandes;

-- Question 8 :
SELECT c.nom, p.nom FROM clients c CROSS JOIN produits p;


-- ## Exercice 3 ##  
-- Question 1 :
SELECT COUNT(*) AS nb_produits FROM produits;

-- Question 2 :
SELECT ROUND(AVG(prix),2) AS prix_moyen FROM produits GROUP BY categorie;

-- Question 3 :
SELECT commande_id, quantite*prix_unitaire AS montant_total FROM lignes_commandes;

-- Question 4 :
SELECT c.nom, COUNT(co.commande_id) AS nb_commande 
FROM clients c 
INNER JOIN commandes co ON c.client_id=co.client_id 
GROUP BY c.nom 
ORDER BY nb_commande DESC 
LIMIT 1;

-- Question 5 :
SELECT categorie, SUM(stock) as stock_total FROM produits GROUP BY categorie;

-- Question 6 :
SELECT categorie, ROUND(STDDEV(prix),2) AS dispersion_prix FROM produits GROUP BY categorie; 

-- Question 7 :
SELECT c.client_id, c.nom, SUM(lg.quantite*lg.prix_unitaire) AS montant_total FROM clients c LEFT JOIN commandes co ON c.client_id=co.client_id INNER JOIN lignes_commandes lg ON co.commande_id=lg.commande_id GROUP BY c.client_id;

-- Question 8 :
SELECT COUNT(*) FROM commandes WHERE EXTRACT(YEAR FROM date_commande)=2025;

-- Question 9 :
SELECT categorie, MIN(prix) as prix_min, MAX(prix) as prix_max, ROUND(AVG(prix),2) as prix_moyen FROM produits INNER JOIN lignes_commandes ON produits.produit_id=lignes_commandes.produit_id GROUP BY categorie;

-- Question 10 : 
SELECT * FROM produits WHERE stock%5=0;

-- # Partie 2 #
-- Question 1 :
SELECT categorie, ROUND(AVG(prix),2) as prix_moyen FROM produits GROUP BY categorie HAVING AVG(prix) > 800;

-- Question 2 :
SELECT commande_id, SUM(quantite*prix_unitaire) FROM lignes_commandes GROUP BY commande_id HAVING SUM(quantite*prix_unitaire) > 1000;

-- Question 3 :
SELECT famille, SUM(stock) FROM produits GROUP BY famille HAVING SUM(stock)<50;


-- ## Exercice 4 ##  
-- Question 1 :
SELECT produit_id, nom, prix FROM produits 
WHERE prix > (SELECT AVG(prix) FROM produits);

-- Question 2 :
SELECT client_id, nb_commande 
FROM (SELECT client_id, COUNT(*) as nb_commande FROM commandes GROUP BY client_id) as table_nb_commande 
WHERE nb_commande >=2;

-- Question 3 :
SELECT commande_id,
       date_commande,
       CASE 
           WHEN date_commande > '2025-01-01' THEN 'récentes'
           ELSE 'anciennes'
       END AS statut_detail
FROM commandes;

-- Question 4 :
SELECT nom,
       prix,
       CASE
           WHEN prix < 200 THEN 'bas'
           WHEN prix BETWEEN 200 AND 1000 THEN 'Moyen'
           ELSE 'élevé'
       END AS categorie_prix
FROM produits;

-- Question 5 :
SELECT client_id, nom, date_inscription,
    CASE
        WHEN date_inscription > '2024-12-31' THEN 'nouveau'
        ELSE 'ancien'
    END AS ancienneté
FROM clients;

-- Question 6 :
SELECT DISTINCT p.produit_id, nom, stock,
    CASE
        WHEN stock < 5 THEN 'CRITIQUE'
        ELSE 'RAS'
    END AS stock_critique
FROM produits p 
    INNER JOIN lignes_commandes lg 
    ON p.produit_id=lg.produit_id;



-- ##### BDD #####
CREATE DATABASE bibliotheque;
