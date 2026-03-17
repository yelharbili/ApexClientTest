-- ============================================================
-- 05_ords_rest.sql - Module ORDS REST (APIs JSON)
-- Schéma : ORASSADM  |  PDB : ORASSUITPDB
-- URL de base : http://192.168.108.135:8181/ords/orassadm/referentiel/
-- ============================================================

-- Activer ORDS sur le schéma ORASSADM
BEGIN
    ORDS.ENABLE_SCHEMA(
        p_enabled             => TRUE,
        p_schema              => 'ORASSADM',
        p_url_mapping_type    => 'BASE_PATH',
        p_url_mapping_pattern => 'orassadm',
        p_auto_rest_auth      => FALSE
    );
    COMMIT;
END;
/

-- ============================================================
-- Supprimer le module existant s'il existe
-- ============================================================
BEGIN
    ORDS.DELETE_MODULE(p_module_name => 'referentiel');
    COMMIT;
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- ============================================================
-- Créer le module ORDS "referentiel"
-- ============================================================
BEGIN
    ORDS.DEFINE_MODULE(
        p_module_name    => 'referentiel',
        p_base_path      => '/referentiel/',
        p_items_per_page => 0,
        p_status         => 'PUBLISHED',
        p_comments       => 'API Référentiel Assurance'
    );
    COMMIT;
END;
/

-- ************************************************************
-- BRANCHES
-- ************************************************************

-- GET /referentiel/branches/  (liste)
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'branches/');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'branches/',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_BRANCHES.get_all); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- POST /referentiel/branches/  (créer)
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'branches/',
        p_method => 'POST', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_BRANCHES.creer(:code_branche, :libelle, :description)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- GET /referentiel/branches/:id  (détail)
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'branches/:id');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'branches/:id',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_BRANCHES.get_by_id(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- PUT /referentiel/branches/:id  (modifier)
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'branches/:id',
        p_method => 'PUT', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_BRANCHES.modifier(:id, :code_branche, :libelle, :description, :actif)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- DELETE /referentiel/branches/:id  (supprimer)
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'branches/:id',
        p_method => 'DELETE', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_BRANCHES.supprimer(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- ************************************************************
-- PRODUITS
-- ************************************************************

-- GET /referentiel/produits/
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'produits/');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'produits/',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_PRODUITS.get_all); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- POST /referentiel/produits/
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'produits/',
        p_method => 'POST', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_PRODUITS.creer(:id_branche, :code_produit, :libelle, :description)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- GET /referentiel/produits/:id
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'produits/:id');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'produits/:id',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_PRODUITS.get_by_id(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- PUT /referentiel/produits/:id
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'produits/:id',
        p_method => 'PUT', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_PRODUITS.modifier(:id, :id_branche, :code_produit, :libelle, :description, :actif)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- DELETE /referentiel/produits/:id
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'produits/:id',
        p_method => 'DELETE', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_PRODUITS.supprimer(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- ************************************************************
-- GARANTIES
-- ************************************************************

-- GET /referentiel/garanties/
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'garanties/');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'garanties/',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_GARANTIES.get_all); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- POST /referentiel/garanties/
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'garanties/',
        p_method => 'POST', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_GARANTIES.creer(:code_garantie, :libelle, :type_garantie, :description)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- GET /referentiel/garanties/:id
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'garanties/:id');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'garanties/:id',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_GARANTIES.get_by_id(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- PUT /referentiel/garanties/:id
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'garanties/:id',
        p_method => 'PUT', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_GARANTIES.modifier(:id, :code_garantie, :libelle, :type_garantie, :description, :actif)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- DELETE /referentiel/garanties/:id
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'garanties/:id',
        p_method => 'DELETE', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_GARANTIES.supprimer(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- ************************************************************
-- FORMULES
-- ************************************************************

-- GET /referentiel/formules/
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'formules/');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'formules/',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_FORMULES.get_all); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- POST /referentiel/formules/
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'formules/',
        p_method => 'POST', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_FORMULES.creer(:id_produit, :code_formule, :libelle, :prime_base, :description)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- GET /referentiel/formules/:id  (inclut les garanties liées)
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'formules/:id');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'formules/:id',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_FORMULES.get_by_id(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- PUT /referentiel/formules/:id
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'formules/:id',
        p_method => 'PUT', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_FORMULES.modifier(:id, :id_produit, :code_formule, :libelle, :prime_base, :description, :actif)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- DELETE /referentiel/formules/:id
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'formules/:id',
        p_method => 'DELETE', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_FORMULES.supprimer(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- GET /referentiel/formules/:id/garanties  (garanties d'une formule)
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'formules/:id/garanties');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'formules/:id/garanties',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_FORMULES.get_garanties(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- POST /referentiel/formules/:id/garanties  (ajouter une garantie)
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'formules/:id/garanties',
        p_method => 'POST', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_FORMULES.ajouter_garantie(:id, :id_garantie, :obligatoire, :taux_couvert)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- ************************************************************
-- CLIENTS
-- ************************************************************

-- GET /referentiel/clients/
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'clients/');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'clients/',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_CLIENTS.get_all); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- POST /referentiel/clients/
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'clients/',
        p_method => 'POST', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_CLIENTS.creer(:code_client, :type_client, :nom, :prenom, TO_DATE(:date_naissance,''YYYY-MM-DD''), :sexe, :cin, :email, :telephone, :adresse, :ville)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- GET /referentiel/clients/:id
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'clients/:id');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'clients/:id',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_CLIENTS.get_by_id(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- PUT /referentiel/clients/:id
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'clients/:id',
        p_method => 'PUT', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_CLIENTS.modifier(:id, :code_client, :type_client, :nom, :prenom, TO_DATE(:date_naissance,''YYYY-MM-DD''), :sexe, :cin, :email, :telephone, :adresse, :ville, :actif)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- DELETE /referentiel/clients/:id
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'clients/:id',
        p_method => 'DELETE', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_CLIENTS.supprimer(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- Recherche clients : GET /referentiel/clients/recherche?nom=xxx&ville=xxx
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'clients/recherche');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'clients/recherche',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_CLIENTS.rechercher(:nom, :ville)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- ************************************************************
-- INTERMEDIAIRES
-- ************************************************************

-- GET /referentiel/intermediaires/
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'intermediaires/');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'intermediaires/',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_INTERMEDIAIRES.get_all); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- POST /referentiel/intermediaires/
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'intermediaires/',
        p_method => 'POST', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_INTERMEDIAIRES.creer(:code_inter, :raison_sociale, :type_inter, :email, :telephone, :adresse, :ville, :taux_commission)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- GET /referentiel/intermediaires/:id
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'intermediaires/:id');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'intermediaires/:id',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_INTERMEDIAIRES.get_by_id(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- PUT /referentiel/intermediaires/:id
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'intermediaires/:id',
        p_method => 'PUT', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_INTERMEDIAIRES.modifier(:id, :code_inter, :raison_sociale, :type_inter, :email, :telephone, :adresse, :ville, :taux_commission, :actif)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- DELETE /referentiel/intermediaires/:id
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'intermediaires/:id',
        p_method => 'DELETE', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_INTERMEDIAIRES.supprimer(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- ************************************************************
-- CONTRATS
-- ************************************************************

-- GET /referentiel/contrats/
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'contrats/');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'contrats/',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_CONTRATS.get_all); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- POST /referentiel/contrats/
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'contrats/',
        p_method => 'POST', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_CONTRATS.creer(:numero_contrat, :id_client, :id_formule, :id_intermediaire, TO_DATE(:date_effet,''YYYY-MM-DD''), TO_DATE(:date_expiration,''YYYY-MM-DD''), :prime_totale)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- GET /referentiel/contrats/:id
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'contrats/:id');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'contrats/:id',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_CONTRATS.get_by_id(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- PUT /referentiel/contrats/:id/statut  (changer statut)
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'contrats/:id/statut');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'contrats/:id/statut',
        p_method => 'PUT', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_CONTRATS.modifier_statut(:id, :statut)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- DELETE /referentiel/contrats/:id
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'contrats/:id',
        p_method => 'DELETE', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_CONTRATS.supprimer(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- Contrats par client : GET /referentiel/contrats/client/:id
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'contrats/client/:id');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'contrats/client/:id',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_CONTRATS.get_by_client(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- ************************************************************
-- SINISTRES
-- ************************************************************

-- GET /referentiel/sinistres/
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'sinistres/');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'sinistres/',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_SINISTRES.get_all); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- POST /referentiel/sinistres/
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'sinistres/',
        p_method => 'POST', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_SINISTRES.creer(:numero_sinistre, :id_contrat, :id_garantie, TO_DATE(:date_sinistre,''YYYY-MM-DD''), :description, :montant_estime)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- GET /referentiel/sinistres/:id
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'sinistres/:id');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'sinistres/:id',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_SINISTRES.get_by_id(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- PUT /referentiel/sinistres/:id/statut  (changer statut + montant réglé)
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'sinistres/:id/statut');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'sinistres/:id/statut',
        p_method => 'PUT', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_SINISTRES.modifier_statut(:id, :statut, :montant_regle)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- DELETE /referentiel/sinistres/:id
BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'sinistres/:id',
        p_method => 'DELETE', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_SINISTRES.supprimer(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

-- Sinistres par contrat : GET /referentiel/sinistres/contrat/:id
BEGIN
    ORDS.DEFINE_TEMPLATE(p_module_name => 'referentiel', p_pattern => 'sinistres/contrat/:id');
    ORDS.DEFINE_HANDLER(
        p_module_name => 'referentiel', p_pattern => 'sinistres/contrat/:id',
        p_method => 'GET', p_source_type => 'plsql/block',
        p_source => 'BEGIN HTP.P(PKG_SINISTRES.get_by_contrat(:id)); END;',
        p_mimes_allowed => 'application/json'
    );
    COMMIT;
END;
/

PROMPT ========================================
PROMPT Module ORDS "referentiel" créé avec succès
PROMPT URL de base : http://192.168.108.135:8181/ords/orassadm/referentiel/
PROMPT ========================================
