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
        ON DELETE SET NULL
);


-- Table Emprunt
CREATE TABLE emprunt (
    id_emprunt SERIAL PRIMARY KEY,
    date_emprunt DATE NOT NULL,
    date_retour DATE NOT NULL,
    id_etudiant INT REFERENCES etudiant(id_etudiant)
        ON DELETE CASCADE,
    id_livre INT REFERENCES livre(id_livre)
        ON DELETE CASCADE
);