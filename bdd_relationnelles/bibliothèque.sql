CREATE TABLE auteur (
    id_auteur SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    date_naissance DATE
);

CREATE TABLE cursus (
    id_cursus SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL
);

CREATE TABLE etudiant (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    date_naissance DATE,
    id_cursus INT,
    FOREIGN KEY (id_cursus) REFERENCES cursus(id_cursus)
);

CREATE TABLE livre (
    id_livre SERIAL PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    annee_publication INT,
    id_auteur INT,
    FOREIGN KEY (id_auteur) REFERENCES auteur(id_auteur)
);

CREATE TABLE emprunt (
    id_emprunt SERIAL PRIMARY KEY,
    date_emprunt DATE,
    date_retour DATE,
    id_livre INT,
    FOREIGN KEY (id_livre) REFERENCES livre(id_livre),
    id_etudiant INT,
    FOREIGN KEY (id_etudiant) REFERENCES etudiant(id_etudiant)
);
