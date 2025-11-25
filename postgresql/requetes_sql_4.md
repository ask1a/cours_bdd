# Les sous‑requêtes (subqueries)
## 1. Définition
Une sous‑requête est une requête imbriquée à l’intérieur d’une autre. Elle peut apparaître :
 - Dans la clause WHERE (filtrer selon un résultat calculé)
 - Dans la clause FROM (comme une table temporaire)
 - Dans la clause SELECT (calculer une valeur pour chaque ligne)

## 2. Exemples pratiques
### a) Clients ayant passé au moins une commande
```sql
SELECT nom, email
FROM clients
WHERE client_id IN (
    SELECT client_id
    FROM commandes
);
```
### b) Produits dont le prix est supérieur au prix moyen
```sql
SELECT nom, prix
FROM produits
WHERE prix > (
    SELECT AVG(prix) FROM produits
);
```
### c) Nombre de commandes par client (sous‑requête dans SELECT)
```sql
SELECT c.nom,
       (SELECT COUNT(*) FROM commandes co WHERE co.client_id = c.client_id) AS nb_commandes
FROM clients c;
```

# L’opérateur CASE
## 1. Définition
CASE permet de créer des conditions dans une requête SQL, un peu comme un if/else. Syntaxe de base :

```sql
CASE
    WHEN condition1 THEN valeur1
    WHEN condition2 THEN valeur2
    ELSE valeur_defaut
END
```
## 2. Exemples pratiques
### a) Catégoriser les produits selon leur prix
```sql
SELECT nom,
       prix,
       CASE
           WHEN prix < 20 THEN 'Bon marché'
           WHEN prix BETWEEN 20 AND 100 THEN 'Moyen'
           ELSE 'Cher'
       END AS categorie_prix
FROM produits;
```
### b) Traduire le statut des commandes
```sql
SELECT commande_id,
       statut,
       CASE statut
           WHEN 'en cours' THEN 'Commande en préparation'
           WHEN 'livrée' THEN 'Commande terminée'
           WHEN 'annulée' THEN 'Commande annulée'
           ELSE 'Statut inconnu'
       END AS statut_detail
FROM commandes;
```
### c) Vérifier si un client a renseigné son email
```sql
SELECT nom,
       CASE
           WHEN email IS NULL THEN 'Email manquant'
           ELSE 'Email renseigné'
       END AS info_email
FROM clients;
```

# Exercices pratiques
 - Afficher les produits dont le prix est supérieur au prix moyen (sous‑requête).
 - Afficher les clients qui ont passé au moins deux commandes (sous‑requête avec COUNT).
 - Afficher les commandes avec une colonne supplémentaire indiquant si elles sont "récentes" (après 2025‑01‑01) ou "anciennes" (avant).
 - Catégoriser les produits en trois classes de prix : bas, moyen, élevé (avec CASE).
 - Afficher les clients avec une colonne indiquant "nouveau" si inscrits après 2024, sinon "ancien".
 - Afficher les produits commandés et ajouter une colonne "stock critique" si le stock est inférieur à 5.
 - Utiliser une sous‑requête pour afficher le produit le plus cher commandé par chaque client.
 - Afficher les commandes avec une colonne "statut détaillé" traduite en français (avec CASE).
 - Afficher les clients qui n’ont jamais passé de commande (sous‑requête avec NOT IN).
 - Afficher les lignes de commande avec une colonne calculée "montant_total" et une classification : "petite commande" (<50), "moyenne" (50‑200), "grande" (>200)
