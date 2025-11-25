# Partie 1 : Afficher des données
Exemple : afficher toutes les lignes
```sql
SELECT * FROM clients;
```
-> Affiche tous les clients avec leurs colonnes (client_id, nom, email, date_inscription).

Exemple : afficher seulement quelques colonnes
```sql
SELECT nom, email FROM clients;
```
-> Affiche uniquement le nom et l’email des clients.

# Partie 2 : Éliminer les doublons avec DISTINCT
Exemple : afficher les statuts de commandes
```sql
SELECT DISTINCT statut FROM commandes;
```
-> Retourne la liste des statuts existants (en cours, livrée, annulée, etc.).

# Partie 3 : Filtrer avec WHERE
Opérateurs de conditions
 - = : égal à
 - <> ou != : différent de
 - < / > : inférieur / supérieur
 - <= : inférieur ou égal
 - IN : valeur dans une liste
 - BETWEEN : valeur comprise dans un intervalle
 - LIKE / ILIKE : recherche textuelle (sensible ou non à la casse)
 - IS NULL : valeur nulle
 - NOT : négation

Exemple : clients inscrits après une date
```sql
SELECT * FROM clients
WHERE date_inscription > '2024-01-01';
```

Exemple : clients dont le nom commence par "A"
```sql
SELECT * FROM clients
WHERE nom LIKE 'A%';
```

Exemple : clients avec email dans une liste
```sql
SELECT * FROM clients
WHERE email IN ('alice@mail.com', 'bob@mail.com');
```

# Erreur de type
Affichons les clients inscrits en 2025.

```sql
ecommerce=# SELECT * FROM clients WHERE date_inscription = 2025;
```
Code
ERROR:  column "2025" does not exist
LINE 1: SELECT * FROM clients WHERE date_inscription = 2025;
Question : Pourquoi y-a-t il une erreur ?

Ici, la colonne date_inscription est de type DATE, et la valeur 2025 est interprétée comme un identifiant de colonne (non existant) au lieu d’une valeur littérale. Pour un champ de type date, il faut entourer la valeur par ' et respecter le format attendu (YYYY-MM-DD).

Exemple correct :
```sql
SELECT * FROM clients WHERE date_inscription = '2025-01-01';
```


# Questions pratiques (table clients)
 - Affiche tous les clients inscrits en 2025.
 - Affiche uniquement les noms et emails des clients dont le nom contient la lettre "e".
 - Affiche les clients dont l’email est nul.
 - Affiche les clients dont l’id est compris entre 5 et 10.
 - Affiche les clients dont le nom ne commence pas par "M".
 - Affiche les clients inscrits avant 2023 ou dont le nom contient "ad".
 - Affiche les clients dont l’email appartient à une liste donnée (IN).
 - Affiche les clients dont la date d’inscription est comprise entre janvier et mars 2024.
 - Affiche les clients dont le nom est différent de "Dupont".
