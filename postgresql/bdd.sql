-- Base de donnée
-- CREATE DATABASE bibliotheque;
DROP TABLE IF EXISTS auteurs;
CREATE TABLE auteurs (
    auteur_id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    nationalite VARCHAR(100)
);
DROP TABLE IF EXISTS livres;
CREATE TABLE livres (
    livre_id SERIAL PRIMARY KEY,
    titre VARCHAR(200) NOT NULL,
    auteur_id INT REFERENCES auteurs(auteur_id)
    ON DELETE SET NULL,
    annee_publication INT,
    genre VARCHAR(100)
);
DROP TABLE IF EXISTS departements;
CREATE TABLE departements (
    departement_id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);
DROP TABLE IF EXISTS etudiant;
CREATE TABLE etudiant (
    membre_id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    departement_id INT REFERENCES departements(departement_id)
    ON DELETE SET NULL
);
DROP TABLE IF EXISTS emprunts;
CREATE TABLE emprunts (
    emprunt_id SERIAL PRIMARY KEY,
    membre_id INT REFERENCES etudiant(membre_id)
        ON DELETE CASCADE, -- Si un membre est supprimé, ses emprunts le sont aussi
    livre_id INT REFERENCES livres(livre_id)
        ON DELETE CASCADE, -- Si un livre est supprimé, les emprunts associés le sont aussi
    date_emprunt DATE NOT NULL,
    date_retour DATE
);

INSERT INTO auteurs (nom, nationalite) VALUES
('Victor Hugo', 'Française'),
('J.K. Rowling', 'Britannique'),
('Gabriel García Márquez', 'Colombienne'),
('George Orwell', 'Britannique'),
('Jane Austen', 'Britannique'),
('Mark Twain', 'Américaine'),
('Evelyne Brisou-Pellen', 'Française');

INSERT INTO livres (titre, auteur_id, annee_publication, genre) VALUES
('Les Misérables', 1, 1862, 'Roman'),
('Harry Potter à l''école des sorciers', 2, 1997, 'Fantasy'),
('Cent ans de solitude', 3, 1967, 'Magical Realism'),
('1984', 4, 1949, 'Dystopie'),
('Orgueil et Préjugés', 5, 1813, 'Roman'),
('Les Aventures de Tom Sawyer', 6, 1876, 'Roman d''aventure'),
('Le Manoir', 7, 2016, 'Jeunesse');

INSERT INTO departements (nom) VALUES
('Informatique'),
('Littérature');

INSERT INTO etudiant (nom, email, departement_id) VALUES
('Alice Dupont', 'alice@email.fr', 1),
('Bob Martin', 'bob@email.com', 2),
('Claire Bernard', 'cl@email.fr',1);
INSERT INTO emprunts (membre_id, livre_id, date_emprunt, date_retour) VALUES
(1, 1, '2024-01-15', '2024-02-15'),
(2, 2, '2024-02-01', NULL),
(3, 3, '2024-03-10', '2024-03-20');