# Normalisation et Formes Normales

## Présentation rapide
La normalisation est un ensemble de règles visant à structurer une base de données relationnelle pour réduire la redondance, éviter les anomalies de modification et faciliter les opérations CRUD (Create, Read, Update, Delete).

---

## Pourquoi normaliser
La normalisation améliore la qualité du modèle de données : elle rationalise le stockage, réduit les incohérences et facilite la maintenance. En pratique on normalise souvent jusqu'à la troisième forme normale pour trouver un bon compromis entre propreté du modèle et performances (trop de normalisation peut multiplier les jointures et impacter les performances).

---

### Rappel : formes normales et vocabulaire
- Formes courantes : Première Forme Normale (1NF), Deuxième Forme Normale (2NF), Troisième Forme Normale (3NF) ; au-delà existent BCNF, 4NF, 5NF, etc..  
- Clé primaire : ensemble minimal d'attributs identifiant une ligne.  
- Clé composite : clé primaire composée de plusieurs colonnes.  
- Dépendance fonctionnelle : notion centrale pour déterminer si un attribut dépend d'une clé ou d'une partie de clé.

---

### Définition générale de la normalisation
- Définition synthétique : c’est le processus d’adaptation de la structure d’une base de données à des formes normales, c’est‑à‑dire l’application de règles pour obtenir un modèle cohérent et peu redondant.  
- Remarque : la dénormalisation est le choix volontaire d’éloigner le modèle des formes normales pour des raisons de performance ou de simplicité de lecture des requêtes, à utiliser avec précaution.

---

## Première Forme Normale (1NF) — règles et exemple
- Règles essentielles :
  - Chaque table doit posséder une clé primaire unique (par ex. CustomerID).  
  - Chaque attribut doit contenir une valeur atomique (pas de listes ou valeurs multiples dans une même cellule).  
- Exemple :
    Exemple non normalisé :
    
    ```Code
    Client(id, nom, commandes)
    ```
     Ici, client peut contenir une liste de commandes (ex: "cmd1, cmd3, cmd4").
    
    Correction en 1NF :
    
    ```Code
    Client(id, nom)
    Commande(id_commande, id_client, date)
    ```
    -> Chaque commande est stocké dans une ligne distincte.
  
- Bénéfice : facilite le tri, la recherche et les jointures ; évite les opérations coûteuses d’extraction et de parsing des valeurs multi‑contenues.

---

## Deuxième Forme Normale (2NF) — règles et approche
- Conditions :
  - La table doit être en 1NF ;  
  - Tous les attributs non‑clé doivent dépendre entièrement de la clé primaire (pas de dépendances partielles sur une composante d’une clé composite).  
- Quand l'appliquer : utile surtout si la table utilise une clé primaire composite (ex. EmployeeID + DepartmentID) ; si certains attributs n’utilisent qu’une partie de la clé composite, il faut extraire ces attributs dans une table séparée pour éviter les anomalies de suppression et garantir l’intégrité des informations (ex. informations sur le département ne dépendant que de DepartmentID).
- Exemple:
    Exemple en 1NF mais pas en 2NF :

    ```Code
    Commande(id_commande, id_client, produit, nom_client)
    ```
    Ici, nom_client dépend seulement de id_client, pas de la clé complète id_commande.
    
    Correction en 2NF :
    
    ```Code
    Client(id_client, nom_client)
    Commande(id_commande, id_client, produit)
    ```
    -> On sépare les informations du client dans une table dédiée.
- Remarque : une table qui n’a pas de clé composite et qui respecte la 1NF satisfait automatiquement à la 2NF.

---

## Troisième Forme Normale (3NF) — règles et mise en pratique
- Conditions :
    - la table doit être en 2NF
    - aucun attribut non-clé ne doit dépendre d'un autre attribut non-clé (on évite les dépendances transitoires).  
- Conséquence pratique : si un attribut A dépend de B et B dépend de la clé primaire, déplacer A (et B si nécessaire) dans une table distincte liée par clé étrangère.  
- Exemple :
    - 2NF mais pas en 3NF
    ```Code
    Employe(id_employe, nom, id_departement, nom_departement, directeur_departement)
    ```
    Problème :
    - `nom_departement` et `directeur_departement` dépendent de `id_departement`, qui est lui-même un attribut non-clé.
    - Donc, il existe une dépendance transitive : `id_employe → id_departement → nom_departement, directeur_departement`.
    
    Correction en 3NF  
    On sépare les informations du département dans une table dédiée :
    
    ```Code
    Employe(id_employe, nom, id_departement)
    Departement(id_departement, nom_departement, directeur_departement)
    ```
    Résultat :
    
    Les attributs du département ne dépendent plus de l’employé, mais uniquement de la clé primaire de la table `Departement`.
    On évite les anomalies de mise à jour (ex. changer le nom du département dans une seule table au lieu de toutes les lignes des employés).

---

## Processus recommandé pour normaliser jusqu’à 3NF
1. Vérifier la 1NF : créer des clés primaires et s’assurer que chaque attribut est atomique.  
2. Identifier les clés composites et vérifier la 2NF : déplacer les attributs dépendant d’une partie de la clé vers de nouvelles tables.  
3. Traiter les dépendances transitoires pour atteindre la 3NF : extraire les attributs qui dépendent d’autres attributs non‑clé dans des tables dédiées.  
4. Après conception, tester les cas d’usage courants (insertions, suppressions, mises à jour) pour vérifier qu’aucune anomalie ne survient et mesurer l’impact des jointures sur les performances.

---

## Avantages, limites et bonnes pratiques
- Avantages : réduction de la redondance, cohérence améliorée, maintenance facilitée, conception claire (entités distinctes).  
- Limites : multiplication des tables et des jointures peut ralentir certaines requêtes ; équilibre à trouver entre normalisation et pragmatisme (parfois dénormaliser pour la lecture/performance).  
- Bonnes pratiques : normaliser au moins jusqu’à la 3NF pour la plupart des cas ; documenter les choix de dénormalisation et tester les scénarios d’échelle/performances en environnement représentatif.

---

## Résumé concis
- 1NF : atomicité des attributs et clé primaire unique.  
- 2NF : pas de dépendance partielle sur une clé composite.  
- 3NF : pas de dépendance transitive entre attributs non‑clé.  
- Normaliser améliore la qualité du modèle ; dénormaliser peut être légitime pour des raisons de performance, à condition d’en mesurer les conséquences.

--- 
