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
