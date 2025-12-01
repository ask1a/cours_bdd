--SELECT * FROM clients WHERE date_inscription BETWEEN '2025-01-01' AND '2025-12-31';
--SELECT nom,email FROM clients WHERE nom LIKE'%e%' and email LIKE '%e%';
--SELECT nom FROM clients WHERE email IS NULL;
--SELECT nom FROM clients WHERE client_id BETWEEN 5 and 10;
--SELECT * FROM clients WHERE nom NOT LIKE 'M%';
--SELECT * FROM clients WHERE date_inscription BETWEEN '2023-01-01' AND '2023-12-31' AND nom LIKE '%ad%';
--SELECT * FROM clients WHERE email IN ('alice@mail.com', 'bob@mail.com');
--SELECT * FROM clients WHERE date_inscription BETWEEN '2024-01-01' AND '2024-03-31';
--SELECT * FROM clients WHERE nom != 'Dupont';
-- [2]
---SELECT * FROM clients c INNER JOIN commandes o ON c.client_id = o.client_id WHERE c.nom = 'Bob Martin';
--SELECT c.nom, c.email, co.commande_id,co.statut FROM clients c LEFT JOIN commandes co ON c.client_id = co.client_id;
--SELECT  c.nom AS client, co.statut FROM commandes co INNER JOIN clients c ON co.client_id = c.client_id INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id INNER JOIN produits p ON lc.produit_id = p.produit_id;
--SELECT  c.nom AS client, p.nom AS produit FROM commandes co INNER JOIN clients c ON co.client_id = c.client_id INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id INNER JOIN produits p ON lc.produit_id = p.produit_id WHERE c.nom = 'Alice Dupont';
--SELECT c.nom AS client, co.commande_id FROM commandes co  INNER JOIN clients c ON co.client_id = c.client_id  INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id  INNER JOIN produits p ON lc.produit_id = p.produit_id  WHERE co.commande_id is NULL;
--SELECT c.nom AS client, p.nom as produit, lc.quantite as qte FROM commandes co  INNER JOIN clients c ON co.client_id = c.client_id  INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id  INNER JOIN produits p ON lc.produit_id = p.produit_id;
--SELECT c.nom, p.nom FROM clients c CROSS JOIN produits p;














