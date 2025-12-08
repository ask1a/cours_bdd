CREATE DATABASE bibliotheque;


-- Table Auteur
CREATE TABLE auteur (
    id_auteur SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(100)
);

-- Table Livre
CREATE TABLE livre (
    id_livre SERIAL PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    annee_publication INT,
    id_auteur INT REFERENCES auteur(id_auteur)
        ON DELETE SET NULL
);


-- table Departement
CREATE TABLE departement (
    id_departement SERIAL PRIMARY KEY,
    cursus VARCHAR(255) NOT NULL
);


-- Table Etudiant
CREATE TABLE etudiant (
    id_etudiant SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(100),
    date_inscription DATE NOT NULL,
    id_departement INT REFERENCES departement(id_departement)
        ON DELETE SET NULL -- Supprimer la référence si le département est supprimé
);


-- Table Emprunt
CREATE TABLE emprunt (
    id_emprunt SERIAL PRIMARY KEY,
    date_emprunt DATE NOT NULL,
    date_retour DATE NOT NULL,
    id_etudiant INT REFERENCES etudiant(id_etudiant)
        ON DELETE CASCADE, -- Supprimer les emprunts si l'étudiant est supprimé
    id_livre INT REFERENCES livre(id_livre)
        ON DELETE CASCADE  -- Supprimer les emprunts si le livre est supprimé
);


-- Insertions d'exemples de données

INSERT INTO auteur (nom, prenom) VALUES
('Hugo', 'Victor'),
('Dumas', 'Alexandre'),
('Camus', 'Albert');

INSERT INTO livre (titre, annee_publication, id_auteur) VALUES
('Les Misérables', 1862, 1),
('Le Comte de Monte-Cristo', 1844, 2),
('L''Étranger', 1942, 3);

INSERT INTO departement (cursus) VALUES
('Informatique'),
('Littérature'),
('Sciences Sociales');

INSERT INTO etudiant (nom, prenom, date_inscription, id_departement) VALUES
('Dupont', 'Jean', '2022-09-01', 1),
('Martin', 'Claire', '2021-09-01', 2),
('Bernard', 'Luc', '2023-01-15', 3);

INSERT INTO emprunt (date_emprunt, date_retour, id_etudiant, id_livre) VALUES
('2024-05-01', '2024-05-15', 1, 1),
('2024-06-10', '2024-06-24', 2, 2),
('2024-07-05', '2024-07-19', 3, 3);
