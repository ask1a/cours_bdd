select * from clients where email != '';
SELECT produit_id, SUM(quantite) FROM lignes_commandes GROUP BY produit_id;
SELECT * from produits;