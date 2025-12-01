SELECT * FROM produits;
SELECT nom FROM clients WHERE email LIKE '%example.com';
SELECT produit_id, SUM(quantite) FROM lignes_commandes GROUP BY produit_id;