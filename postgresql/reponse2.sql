-- Affiche la liste des clients avec leurs commandes (même ceux qui n’ont pas de commande).
SELECT c.nom, co.commande_id
FROM clients c
RIGHT JOIN commandes co ON c.client_id = co.client_id;

-- Affiche toutes les commandes avec le nom du client et leur statut.
SELECT c.nom, co.statut, co.commande_id
FROM clients c
RIGHT JOIN commandes co ON c.client_id = co.client_id;

-- Affiche les produits commandés par "Alice Dupont".
SELECT DISTINCT c.nom, p.nom, p.prix
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id
WHERE c.nom = 'Alice Dupont';

-- Affiche les clients qui n’ont jamais passé de commande.
SELECT c.nom, co.commande_id
FROM clients c
RIGHT JOIN commandes co ON c.client_id = co.client_id
WHERE co.commande_id is NULL;

-- Affiche toutes les commandes avec les produits associés et la quantité commandée.
SELECT co.commande_id, lc.quantite, p.nom
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id

-- Affiche les clients et les produits qu’ils ont commandés, en utilisant une jointure multiple.
SELECT c.nom, co.commande_id, lc.quantite, p.nom
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id

-- Affiche toutes les commandes, même celles sans client (test avec FULL OUTER JOIN).
-- Affiche toutes les combinaisons possibles entre clients et produits (CROSS JOIN).
-- Affiche les clients qui ont commandé au moins deux produits différents.
-- Affiche les produits qui n’ont jamais été commandés.
