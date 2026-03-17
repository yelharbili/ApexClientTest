-- ============================================================
-- 02_types.sql - Types Oracle
-- Schéma : ORASSADM  |  PDB : ORASSUITPDB
-- ============================================================

-- Type objet pour retour standardisé des APIs PL/SQL
CREATE OR REPLACE TYPE T_RESULTAT AS OBJECT (
    code_retour  NUMBER,        -- 0 = succès, -1 = erreur
    message      VARCHAR2(500), -- Message descriptif
    id_genere    NUMBER         -- ID de l'enregistrement créé/modifié
);
/
