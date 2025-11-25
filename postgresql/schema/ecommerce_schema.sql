-- Création du schéma e-commerce
DROP TABLE IF EXISTS lignes_commandes CASCADE;
DROP TABLE IF EXISTS commandes CASCADE;
DROP TABLE IF EXISTS produits CASCADE;
DROP TABLE IF EXISTS clients CASCADE;

-- Table des clients
CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    date_inscription DATE DEFAULT CURRENT_DATE
);

-- Table des produits
CREATE TABLE produits (
    produit_id SERIAL PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    famille VARCHAR(100),
    categorie VARCHAR(100),
    prix NUMERIC(10,2) NOT NULL,
    stock INT DEFAULT 0
);

-- Table des commandes
CREATE TABLE commandes (
    commande_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL REFERENCES clients(client_id),
    date_commande TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statut VARCHAR(50) DEFAULT 'en cours'
);

-- Table des lignes de commande (relation N:N entre commandes et produits)
CREATE TABLE lignes_commandes (
    ligne_id SERIAL PRIMARY KEY,
    commande_id INT NOT NULL REFERENCES commandes(commande_id) ON DELETE CASCADE,
    produit_id INT NOT NULL REFERENCES produits(produit_id),
    quantite INT NOT NULL CHECK (quantite > 0),
    prix_unitaire NUMERIC(10,2) NOT NULL
);
