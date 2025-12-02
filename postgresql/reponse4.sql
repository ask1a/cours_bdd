--Afficher les produits dont le prix est supérieur au prix moyen (sous‑requête).

--Afficher les clients qui ont passé au moins deux commandes (sous‑requête avec COUNT).

--Afficher les commandes avec une colonne supplémentaire indiquant si elles sont "récentes" (après 2025‑01‑01) ou "anciennes" (avant).
SELECT commande_id, client_id, date_commande, statut,
    CASE date_commande
        WHEN < '2025‑01‑01' THEN 'ancienne'
        ELSE 'récente'
    END AS anciennete
FROM commandes;
--Catégoriser les produits en trois classes de prix : bas, moyen, élevé (avec CASE).

--Afficher les clients avec une colonne indiquant "nouveau" si inscrits après 2024, sinon "ancien".

--Afficher les produits commandés et ajouter une colonne "stock critique" si le stock est inférieur à 5.

--Utiliser une sous‑requête pour afficher le produit le plus cher commandé par chaque client.

--Afficher les commandes avec une colonne "statut détaillé" traduite en français (avec CASE).

--Afficher les clients qui n’ont jamais passé de commande (sous‑requête avec NOT IN).

--Afficher les lignes de commande avec une colonne calculée "montant_total" et une classification : "petite commande" (<50), "moyenne" (50‑200), "grande" (>200)