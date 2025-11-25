# Exercice : Gestion d’une bibliothèque universitaire

## Objectif
Modéliser le schéma relationnel d’une base de données permettant de gérer les emprunts de livres dans une bibliothèque universitaire.

---

## Contexte
Une bibliothèque souhaite suivre les livres disponibles, les étudiants qui les empruntent, et les dates d’emprunt et de retour. Elle veut aussi connaître les auteurs des livres et les départements auxquels les étudiants appartiennent.

---

## Données à modéliser

Entités principales
- Livre
  - id (clé primaire)
  - titre
  - année_publication
  - auteur_id (clé étrangère vers Auteur)

- Auteur
  - id (clé primaire)
  - ...

---

## Relations à représenter
- Un auteur peut avoir écrit plusieurs livres (relation un-à-plusieurs).
- Un livre peut être emprunté plusieurs fois, mais un emprunt concerne un seul livre et un seul étudiant (relation plusieurs-à-plusieurs via la table Emprunt).
- Un étudiant appartient à un seul cursus, mais un cursus peut avoir plusieurs étudiants (relation un-à-plusieurs).

---

## Contraintes à intégrer
- Les clés primaires et étrangères.
- Les types de relations (1:N, N:N).
- Les options ON DELETE (CASCADE ou SET NULL selon les cas).
- Atomicité des attributs (pas de listes dans une cellule).

---

## Outil recommandé pour créer le schéma
Utilisez [dbdiagram.io](https://dbdiagram.io/home) — un outil gratuit et intuitif pour créer des schémas relationnels en ligne.

> Vous pouvez y décrire votre modèle en pseudo-SQL comme ceci :
```sql
Table livre {
  id int [pk]
  titre varchar
  année_publication int
  auteur_id int [ref: > auteur.id]
}

Table auteur {
  id int [pk]
  ...}
```

---

### Livrables attendus
- Un schéma relationnel clair avec les entités, attributs, clés et relations.
- Une capture ou export du schéma depuis dbdiagram.io.
- Une brève justification des choix de modélisation (relations, contraintes, etc.).
- Créer les tables dans postgres dans une nouvelle base de donnée bibliothèque


## Créer la base
Depuis psql (ou via docker exec si tu es dans un container) :

```sql
CREATE DATABASE bibliotheque;
```
-> Ici la base se nomme bibliotheque

## Se connecter à la base
Toujours dans psql :

```bash
\c bibliotheque
```
ou en ligne de commande :

```bash
psql -h localhost -U postgres -d bibliotheque
```
## Créer les tables
Une fois connecté à la nouvelle base, exécuter le script :

```sql
-- Table Livre
CREATE TABLE livre (
    id SERIAL PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    annee_publication INT,
    auteur_id INT REFERENCES auteur(id)
        ON DELETE SET NULL
);
```
