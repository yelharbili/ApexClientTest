-- ============================================================
-- 03_vues.sql - Vues Métier
-- Schéma : ORASSADM  |  PDB : ORASSUITPDB
-- ============================================================

-- ============================================================
-- V_CONTRATS_DETAIL : Contrat enrichi avec client, formule, produit, branche
-- ============================================================
CREATE OR REPLACE VIEW V_CONTRATS_DETAIL AS
SELECT
    c.id_contrat,
    c.numero_contrat,
    c.date_effet,
    c.date_expiration,
    c.prime_totale,
    c.statut            AS statut_contrat,
    -- Client
    cl.id_client,
    cl.code_client,
    cl.nom              AS client_nom,
    cl.prenom           AS client_prenom,
    cl.type_client,
    cl.telephone        AS client_telephone,
    cl.email            AS client_email,
    -- Formule
    f.id_formule,
    f.code_formule,
    f.libelle           AS formule_libelle,
    f.prime_base,
    -- Produit
    p.id_produit,
    p.code_produit,
    p.libelle           AS produit_libelle,
    -- Branche
    b.id_branche,
    b.code_branche,
    b.libelle           AS branche_libelle,
    -- Intermédiaire
    i.id_intermediaire,
    i.code_inter,
    i.raison_sociale    AS intermediaire_nom,
    i.taux_commission
FROM CONTRATS c
    JOIN REF_CLIENTS        cl ON cl.id_client        = c.id_client
    JOIN REF_FORMULES       f  ON f.id_formule        = c.id_formule
    JOIN REF_PRODUITS       p  ON p.id_produit        = f.id_produit
    JOIN REF_BRANCHES       b  ON b.id_branche        = p.id_branche
    LEFT JOIN REF_INTERMEDIAIRES i ON i.id_intermediaire = c.id_intermediaire;

-- ============================================================
-- V_SINISTRES_DETAIL : Sinistre enrichi avec contrat, client, garantie
-- ============================================================
CREATE OR REPLACE VIEW V_SINISTRES_DETAIL AS
SELECT
    s.id_sinistre,
    s.numero_sinistre,
    s.date_sinistre,
    s.date_declaration,
    s.description       AS sinistre_description,
    s.montant_estime,
    s.montant_regle,
    s.statut            AS statut_sinistre,
    -- Contrat
    c.id_contrat,
    c.numero_contrat,
    c.statut            AS statut_contrat,
    -- Client
    cl.id_client,
    cl.code_client,
    cl.nom              AS client_nom,
    cl.prenom           AS client_prenom,
    -- Garantie
    g.id_garantie,
    g.code_garantie,
    g.libelle           AS garantie_libelle,
    g.type_garantie
FROM SINISTRES s
    JOIN CONTRATS       c  ON c.id_contrat  = s.id_contrat
    JOIN REF_CLIENTS    cl ON cl.id_client   = c.id_client
    JOIN REF_GARANTIES  g  ON g.id_garantie  = s.id_garantie;

-- ============================================================
-- V_PRODUITS_FORMULES : Produit avec ses formules et nombre de garanties
-- ============================================================
CREATE OR REPLACE VIEW V_PRODUITS_FORMULES AS
SELECT
    p.id_produit,
    p.code_produit,
    p.libelle           AS produit_libelle,
    b.code_branche,
    b.libelle           AS branche_libelle,
    f.id_formule,
    f.code_formule,
    f.libelle           AS formule_libelle,
    f.prime_base,
    (SELECT COUNT(*) FROM REF_FORMULE_GARANTIES fg WHERE fg.id_formule = f.id_formule) AS nb_garanties
FROM REF_PRODUITS p
    JOIN REF_BRANCHES b ON b.id_branche = p.id_branche
    LEFT JOIN REF_FORMULES f ON f.id_produit = p.id_produit;
