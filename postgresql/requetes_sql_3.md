# Les fonctions d’agrégation en SQL
## 1. Définition
Les fonctions d’agrégation permettent de réaliser des calculs sur un ensemble de lignes et de retourner une seule valeur. Elles sont souvent utilisées avec GROUP BY.

## 2. Principales fonctions
|Fonction|Description|Exemple|
|--------|-----------|-------|
|COUNT|	Compte le nombre de lignes	|SELECT COUNT(*) FROM clients;|
|MAX|	Retourne la valeur maximale	|SELECT MAX(prix) FROM produits;|
|MIN|	Retourne la valeur minimale	|SELECT MIN(stock) FROM produits;|
|AVG|	Calcule la moyenne	|SELECT AVG(prix) FROM produits;|
|STDDEV|	Calcule l’écart-type	|SELECT STDDEV(prix) FROM produits;|
|SUM|	Calcule la somme	|SELECT SUM(quantite) FROM lignes_commandes;|

## 3. Exemples pratiques sur ton schéma
### a) Nombre total de clients
```sql
SELECT COUNT(*) AS nb_clients FROM clients;
```
### b) Prix maximum et minimum des produits
```sql
SELECT MAX(prix) AS prix_max, MIN(prix) AS prix_min FROM produits;
```
### c) Moyenne du prix des produits
```sql
SELECT AVG(prix) AS prix_moyen FROM produits;
```
### d) Somme des quantités commandées
```sql
SELECT SUM(quantite) AS total_quantites FROM lignes_commandes;
```
### e) Écart-type du prix des produits
```sql
SELECT STDDEV(prix) AS dispersion_prix FROM produits;
```
### f) Agrégation avec GROUP BY : total par client
```sql
SELECT c.nom, COUNT(co.commande_id) AS nb_commandes
FROM clients c
LEFT JOIN commandes co ON c.client_id = co.client_id
GROUP BY c.nom;
```
-> Affiche le nombre de commandes par client.

# Les calculs arithmétiques en SQL
## 1. Opérateurs
|Opérateur|	Description|	Exemple|
|---------|------------|---------|
|+	|Addition	|SELECT prix + 10 FROM produits;|
|-	|Soustraction	|SELECT prix - 5 FROM produits;|
|*	|Multiplication	|SELECT prix * quantite FROM lignes_commandes;|
|/	|Division	|SELECT prix / 2 FROM produits;|
|%	|Modulo (reste d’une division entière)	|SELECT 10 % 3;|

## 2. Exemples pratiques
### a) Calculer le montant total d’une ligne de commande
```sql
SELECT ligne_id, quantite * prix_unitaire AS montant_total
FROM lignes_commandes;
```
### b) Augmenter tous les prix de 5%
```sql
SELECT produit_id, nom, prix, prix * 1.05 AS prix_augmenté
FROM produits;
```
### c) Calculer le nombre de commandes par année
```sql
SELECT EXTRACT(YEAR FROM date_commande) AS annee,
       COUNT(*) AS nb_commandes
FROM commandes
GROUP BY annee;
```
# Exercices pratiques
 - Compter le nombre de produits disponibles dans la table produits.
 - Afficher le prix moyen des produits par catégorie (GROUP BY categorie).
 - Calculer le montant total de chaque commande (somme des quantite * prix_unitaire).
 - Afficher le client qui a passé le plus de commandes.
 - Calculer la somme des stocks disponibles par famille de produits.
 - Afficher l’écart-type des prix des produits pour analyser la dispersion.
 - Calculer le montant total des ventes par client.
 - Afficher les commandes passées en 2025 et leur nombre.
 - Calculer le prix minimum, maximum et moyen des produits commandés.
 - Afficher les produits dont le stock est un multiple de 5 (utiliser %).
