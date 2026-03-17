-- ============================================================
-- 04_packages.sql - Packages PL/SQL (Spécifications + Corps)
-- Schéma : ORASSADM  |  PDB : ORASSUITPDB
-- Chaque package expose des fonctions CRUD retournant du JSON (CLOB)
-- ============================================================

-- ************************************************************
-- PKG_BRANCHES
-- ************************************************************
CREATE OR REPLACE PACKAGE PKG_BRANCHES AS
    FUNCTION get_all RETURN CLOB;
    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB;
    FUNCTION creer(p_code VARCHAR2, p_libelle VARCHAR2, p_description VARCHAR2 DEFAULT NULL) RETURN CLOB;
    FUNCTION modifier(p_id NUMBER, p_code VARCHAR2, p_libelle VARCHAR2, p_description VARCHAR2 DEFAULT NULL, p_actif CHAR DEFAULT 'O') RETURN CLOB;
    FUNCTION supprimer(p_id NUMBER) RETURN CLOB;
END PKG_BRANCHES;
/

CREATE OR REPLACE PACKAGE BODY PKG_BRANCHES AS

    FUNCTION get_all RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_branche'    VALUE id_branche,
                'code_branche'  VALUE code_branche,
                'libelle'       VALUE libelle,
                'description'   VALUE description,
                'actif'         VALUE actif,
                'date_creation' VALUE TO_CHAR(date_creation,'YYYY-MM-DD')
            ) RETURNING CLOB
        ) INTO v_json FROM REF_BRANCHES ORDER BY id_branche;
        RETURN NVL(v_json, '[]');
    END;

    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_OBJECT(
            'id_branche'    VALUE id_branche,
            'code_branche'  VALUE code_branche,
            'libelle'       VALUE libelle,
            'description'   VALUE description,
            'actif'         VALUE actif,
            'date_creation' VALUE TO_CHAR(date_creation,'YYYY-MM-DD')
        RETURNING CLOB) INTO v_json FROM REF_BRANCHES WHERE id_branche = p_id;
        RETURN v_json;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RETURN '{"error":"Branche non trouvée"}';
    END;

    FUNCTION creer(p_code VARCHAR2, p_libelle VARCHAR2, p_description VARCHAR2 DEFAULT NULL) RETURN CLOB IS
        v_id NUMBER;
    BEGIN
        INSERT INTO REF_BRANCHES (code_branche, libelle, description)
        VALUES (p_code, p_libelle, p_description)
        RETURNING id_branche INTO v_id;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Branche créée', 'id_genere' VALUE v_id);
    EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Code branche déjà existant');
    WHEN OTHERS THEN
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE SQLERRM);
    END;

    FUNCTION modifier(p_id NUMBER, p_code VARCHAR2, p_libelle VARCHAR2, p_description VARCHAR2 DEFAULT NULL, p_actif CHAR DEFAULT 'O') RETURN CLOB IS
    BEGIN
        UPDATE REF_BRANCHES
        SET code_branche = p_code, libelle = p_libelle, description = p_description, actif = p_actif, date_maj = SYSDATE
        WHERE id_branche = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Branche non trouvée');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Branche modifiée', 'id_genere' VALUE p_id);
    END;

    FUNCTION supprimer(p_id NUMBER) RETURN CLOB IS
    BEGIN
        DELETE FROM REF_BRANCHES WHERE id_branche = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Branche non trouvée');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Branche supprimée');
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Impossible de supprimer: ' || SQLERRM);
    END;

END PKG_BRANCHES;
/

-- ************************************************************
-- PKG_PRODUITS
-- ************************************************************
CREATE OR REPLACE PACKAGE PKG_PRODUITS AS
    FUNCTION get_all RETURN CLOB;
    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB;
    FUNCTION get_by_branche(p_id_branche NUMBER) RETURN CLOB;
    FUNCTION creer(p_id_branche NUMBER, p_code VARCHAR2, p_libelle VARCHAR2, p_description VARCHAR2 DEFAULT NULL) RETURN CLOB;
    FUNCTION modifier(p_id NUMBER, p_id_branche NUMBER, p_code VARCHAR2, p_libelle VARCHAR2, p_description VARCHAR2 DEFAULT NULL, p_actif CHAR DEFAULT 'O') RETURN CLOB;
    FUNCTION supprimer(p_id NUMBER) RETURN CLOB;
END PKG_PRODUITS;
/

CREATE OR REPLACE PACKAGE BODY PKG_PRODUITS AS

    FUNCTION get_all RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_produit'    VALUE p.id_produit,
                'code_produit'  VALUE p.code_produit,
                'libelle'       VALUE p.libelle,
                'description'   VALUE p.description,
                'actif'         VALUE p.actif,
                'branche'       VALUE JSON_OBJECT(
                    'id_branche'   VALUE b.id_branche,
                    'code_branche' VALUE b.code_branche,
                    'libelle'      VALUE b.libelle
                )
            ) RETURNING CLOB
        ) INTO v_json
        FROM REF_PRODUITS p JOIN REF_BRANCHES b ON b.id_branche = p.id_branche
        ORDER BY p.id_produit;
        RETURN NVL(v_json, '[]');
    END;

    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_OBJECT(
            'id_produit'    VALUE p.id_produit,
            'code_produit'  VALUE p.code_produit,
            'libelle'       VALUE p.libelle,
            'description'   VALUE p.description,
            'actif'         VALUE p.actif,
            'branche'       VALUE JSON_OBJECT(
                'id_branche'   VALUE b.id_branche,
                'code_branche' VALUE b.code_branche,
                'libelle'      VALUE b.libelle
            )
        RETURNING CLOB) INTO v_json
        FROM REF_PRODUITS p JOIN REF_BRANCHES b ON b.id_branche = p.id_branche
        WHERE p.id_produit = p_id;
        RETURN v_json;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RETURN '{"error":"Produit non trouvé"}';
    END;

    FUNCTION get_by_branche(p_id_branche NUMBER) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_produit'   VALUE id_produit,
                'code_produit' VALUE code_produit,
                'libelle'      VALUE libelle,
                'actif'        VALUE actif
            ) RETURNING CLOB
        ) INTO v_json FROM REF_PRODUITS WHERE id_branche = p_id_branche ORDER BY id_produit;
        RETURN NVL(v_json, '[]');
    END;

    FUNCTION creer(p_id_branche NUMBER, p_code VARCHAR2, p_libelle VARCHAR2, p_description VARCHAR2 DEFAULT NULL) RETURN CLOB IS
        v_id NUMBER;
    BEGIN
        INSERT INTO REF_PRODUITS (id_branche, code_produit, libelle, description)
        VALUES (p_id_branche, p_code, p_libelle, p_description)
        RETURNING id_produit INTO v_id;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Produit créé', 'id_genere' VALUE v_id);
    EXCEPTION WHEN OTHERS THEN
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE SQLERRM);
    END;

    FUNCTION modifier(p_id NUMBER, p_id_branche NUMBER, p_code VARCHAR2, p_libelle VARCHAR2, p_description VARCHAR2 DEFAULT NULL, p_actif CHAR DEFAULT 'O') RETURN CLOB IS
    BEGIN
        UPDATE REF_PRODUITS
        SET id_branche = p_id_branche, code_produit = p_code, libelle = p_libelle,
            description = p_description, actif = p_actif, date_maj = SYSDATE
        WHERE id_produit = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Produit non trouvé');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Produit modifié', 'id_genere' VALUE p_id);
    END;

    FUNCTION supprimer(p_id NUMBER) RETURN CLOB IS
    BEGIN
        DELETE FROM REF_PRODUITS WHERE id_produit = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Produit non trouvé');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Produit supprimé');
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Impossible de supprimer: ' || SQLERRM);
    END;

END PKG_PRODUITS;
/

-- ************************************************************
-- PKG_GARANTIES
-- ************************************************************
CREATE OR REPLACE PACKAGE PKG_GARANTIES AS
    FUNCTION get_all RETURN CLOB;
    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB;
    FUNCTION creer(p_code VARCHAR2, p_libelle VARCHAR2, p_type VARCHAR2 DEFAULT 'PRINCIPALE', p_description VARCHAR2 DEFAULT NULL) RETURN CLOB;
    FUNCTION modifier(p_id NUMBER, p_code VARCHAR2, p_libelle VARCHAR2, p_type VARCHAR2, p_description VARCHAR2 DEFAULT NULL, p_actif CHAR DEFAULT 'O') RETURN CLOB;
    FUNCTION supprimer(p_id NUMBER) RETURN CLOB;
END PKG_GARANTIES;
/

CREATE OR REPLACE PACKAGE BODY PKG_GARANTIES AS

    FUNCTION get_all RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_garantie'   VALUE id_garantie,
                'code_garantie' VALUE code_garantie,
                'libelle'       VALUE libelle,
                'description'   VALUE description,
                'type_garantie' VALUE type_garantie,
                'actif'         VALUE actif
            ) RETURNING CLOB
        ) INTO v_json FROM REF_GARANTIES ORDER BY id_garantie;
        RETURN NVL(v_json, '[]');
    END;

    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_OBJECT(
            'id_garantie'   VALUE id_garantie,
            'code_garantie' VALUE code_garantie,
            'libelle'       VALUE libelle,
            'description'   VALUE description,
            'type_garantie' VALUE type_garantie,
            'actif'         VALUE actif
        RETURNING CLOB) INTO v_json FROM REF_GARANTIES WHERE id_garantie = p_id;
        RETURN v_json;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RETURN '{"error":"Garantie non trouvée"}';
    END;

    FUNCTION creer(p_code VARCHAR2, p_libelle VARCHAR2, p_type VARCHAR2 DEFAULT 'PRINCIPALE', p_description VARCHAR2 DEFAULT NULL) RETURN CLOB IS
        v_id NUMBER;
    BEGIN
        INSERT INTO REF_GARANTIES (code_garantie, libelle, type_garantie, description)
        VALUES (p_code, p_libelle, p_type, p_description)
        RETURNING id_garantie INTO v_id;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Garantie créée', 'id_genere' VALUE v_id);
    EXCEPTION WHEN OTHERS THEN
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE SQLERRM);
    END;

    FUNCTION modifier(p_id NUMBER, p_code VARCHAR2, p_libelle VARCHAR2, p_type VARCHAR2, p_description VARCHAR2 DEFAULT NULL, p_actif CHAR DEFAULT 'O') RETURN CLOB IS
    BEGIN
        UPDATE REF_GARANTIES
        SET code_garantie = p_code, libelle = p_libelle, type_garantie = p_type,
            description = p_description, actif = p_actif, date_maj = SYSDATE
        WHERE id_garantie = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Garantie non trouvée');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Garantie modifiée', 'id_genere' VALUE p_id);
    END;

    FUNCTION supprimer(p_id NUMBER) RETURN CLOB IS
    BEGIN
        DELETE FROM REF_GARANTIES WHERE id_garantie = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Garantie non trouvée');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Garantie supprimée');
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Impossible de supprimer: ' || SQLERRM);
    END;

END PKG_GARANTIES;
/

-- ************************************************************
-- PKG_FORMULES
-- ************************************************************
CREATE OR REPLACE PACKAGE PKG_FORMULES AS
    FUNCTION get_all RETURN CLOB;
    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB;
    FUNCTION get_by_produit(p_id_produit NUMBER) RETURN CLOB;
    FUNCTION creer(p_id_produit NUMBER, p_code VARCHAR2, p_libelle VARCHAR2, p_prime_base NUMBER DEFAULT 0, p_description VARCHAR2 DEFAULT NULL) RETURN CLOB;
    FUNCTION modifier(p_id NUMBER, p_id_produit NUMBER, p_code VARCHAR2, p_libelle VARCHAR2, p_prime_base NUMBER, p_description VARCHAR2 DEFAULT NULL, p_actif CHAR DEFAULT 'O') RETURN CLOB;
    FUNCTION supprimer(p_id NUMBER) RETURN CLOB;
    FUNCTION ajouter_garantie(p_id_formule NUMBER, p_id_garantie NUMBER, p_obligatoire CHAR DEFAULT 'O', p_taux NUMBER DEFAULT 100) RETURN CLOB;
    FUNCTION retirer_garantie(p_id_formule NUMBER, p_id_garantie NUMBER) RETURN CLOB;
    FUNCTION get_garanties(p_id_formule NUMBER) RETURN CLOB;
END PKG_FORMULES;
/

CREATE OR REPLACE PACKAGE BODY PKG_FORMULES AS

    FUNCTION get_all RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_formule'   VALUE f.id_formule,
                'code_formule' VALUE f.code_formule,
                'libelle'      VALUE f.libelle,
                'description'  VALUE f.description,
                'prime_base'   VALUE f.prime_base,
                'actif'        VALUE f.actif,
                'produit'      VALUE JSON_OBJECT(
                    'id_produit'   VALUE p.id_produit,
                    'code_produit' VALUE p.code_produit,
                    'libelle'      VALUE p.libelle
                )
            ) RETURNING CLOB
        ) INTO v_json
        FROM REF_FORMULES f JOIN REF_PRODUITS p ON p.id_produit = f.id_produit
        ORDER BY f.id_formule;
        RETURN NVL(v_json, '[]');
    END;

    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_OBJECT(
            'id_formule'   VALUE f.id_formule,
            'code_formule' VALUE f.code_formule,
            'libelle'      VALUE f.libelle,
            'description'  VALUE f.description,
            'prime_base'   VALUE f.prime_base,
            'actif'        VALUE f.actif,
            'produit'      VALUE JSON_OBJECT(
                'id_produit'   VALUE p.id_produit,
                'code_produit' VALUE p.code_produit,
                'libelle'      VALUE p.libelle
            ),
            'garanties'    VALUE (
                SELECT JSON_ARRAYAGG(
                    JSON_OBJECT(
                        'id_garantie'   VALUE g.id_garantie,
                        'code_garantie' VALUE g.code_garantie,
                        'libelle'       VALUE g.libelle,
                        'obligatoire'   VALUE fg.obligatoire,
                        'taux_couvert'  VALUE fg.taux_couvert
                    )
                ) FROM REF_FORMULE_GARANTIES fg
                JOIN REF_GARANTIES g ON g.id_garantie = fg.id_garantie
                WHERE fg.id_formule = f.id_formule
            )
        RETURNING CLOB) INTO v_json
        FROM REF_FORMULES f JOIN REF_PRODUITS p ON p.id_produit = f.id_produit
        WHERE f.id_formule = p_id;
        RETURN v_json;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RETURN '{"error":"Formule non trouvée"}';
    END;

    FUNCTION get_by_produit(p_id_produit NUMBER) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_formule'   VALUE id_formule,
                'code_formule' VALUE code_formule,
                'libelle'      VALUE libelle,
                'prime_base'   VALUE prime_base,
                'actif'        VALUE actif
            ) RETURNING CLOB
        ) INTO v_json FROM REF_FORMULES WHERE id_produit = p_id_produit ORDER BY id_formule;
        RETURN NVL(v_json, '[]');
    END;

    FUNCTION creer(p_id_produit NUMBER, p_code VARCHAR2, p_libelle VARCHAR2, p_prime_base NUMBER DEFAULT 0, p_description VARCHAR2 DEFAULT NULL) RETURN CLOB IS
        v_id NUMBER;
    BEGIN
        INSERT INTO REF_FORMULES (id_produit, code_formule, libelle, prime_base, description)
        VALUES (p_id_produit, p_code, p_libelle, p_prime_base, p_description)
        RETURNING id_formule INTO v_id;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Formule créée', 'id_genere' VALUE v_id);
    EXCEPTION WHEN OTHERS THEN
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE SQLERRM);
    END;

    FUNCTION modifier(p_id NUMBER, p_id_produit NUMBER, p_code VARCHAR2, p_libelle VARCHAR2, p_prime_base NUMBER, p_description VARCHAR2 DEFAULT NULL, p_actif CHAR DEFAULT 'O') RETURN CLOB IS
    BEGIN
        UPDATE REF_FORMULES
        SET id_produit = p_id_produit, code_formule = p_code, libelle = p_libelle,
            prime_base = p_prime_base, description = p_description, actif = p_actif, date_maj = SYSDATE
        WHERE id_formule = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Formule non trouvée');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Formule modifiée', 'id_genere' VALUE p_id);
    END;

    FUNCTION supprimer(p_id NUMBER) RETURN CLOB IS
    BEGIN
        DELETE FROM REF_FORMULE_GARANTIES WHERE id_formule = p_id;
        DELETE FROM REF_FORMULES WHERE id_formule = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Formule non trouvée');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Formule supprimée');
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Impossible de supprimer: ' || SQLERRM);
    END;

    FUNCTION ajouter_garantie(p_id_formule NUMBER, p_id_garantie NUMBER, p_obligatoire CHAR DEFAULT 'O', p_taux NUMBER DEFAULT 100) RETURN CLOB IS
    BEGIN
        INSERT INTO REF_FORMULE_GARANTIES (id_formule, id_garantie, obligatoire, taux_couvert)
        VALUES (p_id_formule, p_id_garantie, p_obligatoire, p_taux);
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Garantie ajoutée à la formule');
    EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Cette garantie est déjà dans la formule');
    WHEN OTHERS THEN
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE SQLERRM);
    END;

    FUNCTION retirer_garantie(p_id_formule NUMBER, p_id_garantie NUMBER) RETURN CLOB IS
    BEGIN
        DELETE FROM REF_FORMULE_GARANTIES WHERE id_formule = p_id_formule AND id_garantie = p_id_garantie;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Association non trouvée');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Garantie retirée de la formule');
    END;

    FUNCTION get_garanties(p_id_formule NUMBER) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_garantie'   VALUE g.id_garantie,
                'code_garantie' VALUE g.code_garantie,
                'libelle'       VALUE g.libelle,
                'type_garantie' VALUE g.type_garantie,
                'obligatoire'   VALUE fg.obligatoire,
                'taux_couvert'  VALUE fg.taux_couvert
            ) RETURNING CLOB
        ) INTO v_json
        FROM REF_FORMULE_GARANTIES fg JOIN REF_GARANTIES g ON g.id_garantie = fg.id_garantie
        WHERE fg.id_formule = p_id_formule;
        RETURN NVL(v_json, '[]');
    END;

END PKG_FORMULES;
/

-- ************************************************************
-- PKG_CLIENTS
-- ************************************************************
CREATE OR REPLACE PACKAGE PKG_CLIENTS AS
    FUNCTION get_all RETURN CLOB;
    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB;
    FUNCTION rechercher(p_nom VARCHAR2 DEFAULT NULL, p_ville VARCHAR2 DEFAULT NULL) RETURN CLOB;
    FUNCTION creer(p_code VARCHAR2, p_type VARCHAR2, p_nom VARCHAR2, p_prenom VARCHAR2 DEFAULT NULL,
                   p_date_naissance DATE DEFAULT NULL, p_sexe CHAR DEFAULT NULL, p_cin VARCHAR2 DEFAULT NULL,
                   p_email VARCHAR2 DEFAULT NULL, p_telephone VARCHAR2 DEFAULT NULL,
                   p_adresse VARCHAR2 DEFAULT NULL, p_ville VARCHAR2 DEFAULT NULL) RETURN CLOB;
    FUNCTION modifier(p_id NUMBER, p_code VARCHAR2, p_type VARCHAR2, p_nom VARCHAR2, p_prenom VARCHAR2 DEFAULT NULL,
                      p_date_naissance DATE DEFAULT NULL, p_sexe CHAR DEFAULT NULL, p_cin VARCHAR2 DEFAULT NULL,
                      p_email VARCHAR2 DEFAULT NULL, p_telephone VARCHAR2 DEFAULT NULL,
                      p_adresse VARCHAR2 DEFAULT NULL, p_ville VARCHAR2 DEFAULT NULL, p_actif CHAR DEFAULT 'O') RETURN CLOB;
    FUNCTION supprimer(p_id NUMBER) RETURN CLOB;
END PKG_CLIENTS;
/

CREATE OR REPLACE PACKAGE BODY PKG_CLIENTS AS

    FUNCTION get_all RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_client'      VALUE id_client,
                'code_client'    VALUE code_client,
                'type_client'    VALUE type_client,
                'nom'            VALUE nom,
                'prenom'         VALUE prenom,
                'email'          VALUE email,
                'telephone'      VALUE telephone,
                'ville'          VALUE ville,
                'actif'          VALUE actif
            ) RETURNING CLOB
        ) INTO v_json FROM REF_CLIENTS ORDER BY id_client;
        RETURN NVL(v_json, '[]');
    END;

    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_OBJECT(
            'id_client'      VALUE id_client,
            'code_client'    VALUE code_client,
            'type_client'    VALUE type_client,
            'nom'            VALUE nom,
            'prenom'         VALUE prenom,
            'date_naissance' VALUE TO_CHAR(date_naissance,'YYYY-MM-DD'),
            'sexe'           VALUE sexe,
            'cin'            VALUE cin,
            'email'          VALUE email,
            'telephone'      VALUE telephone,
            'adresse'        VALUE adresse,
            'ville'          VALUE ville,
            'actif'          VALUE actif
        RETURNING CLOB) INTO v_json FROM REF_CLIENTS WHERE id_client = p_id;
        RETURN v_json;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RETURN '{"error":"Client non trouvé"}';
    END;

    FUNCTION rechercher(p_nom VARCHAR2 DEFAULT NULL, p_ville VARCHAR2 DEFAULT NULL) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_client'   VALUE id_client,
                'code_client' VALUE code_client,
                'nom'         VALUE nom,
                'prenom'      VALUE prenom,
                'ville'       VALUE ville
            ) RETURNING CLOB
        ) INTO v_json
        FROM REF_CLIENTS
        WHERE (p_nom IS NULL OR UPPER(nom) LIKE '%' || UPPER(p_nom) || '%')
          AND (p_ville IS NULL OR UPPER(ville) LIKE '%' || UPPER(p_ville) || '%');
        RETURN NVL(v_json, '[]');
    END;

    FUNCTION creer(p_code VARCHAR2, p_type VARCHAR2, p_nom VARCHAR2, p_prenom VARCHAR2 DEFAULT NULL,
                   p_date_naissance DATE DEFAULT NULL, p_sexe CHAR DEFAULT NULL, p_cin VARCHAR2 DEFAULT NULL,
                   p_email VARCHAR2 DEFAULT NULL, p_telephone VARCHAR2 DEFAULT NULL,
                   p_adresse VARCHAR2 DEFAULT NULL, p_ville VARCHAR2 DEFAULT NULL) RETURN CLOB IS
        v_id NUMBER;
    BEGIN
        INSERT INTO REF_CLIENTS (code_client, type_client, nom, prenom, date_naissance, sexe, cin, email, telephone, adresse, ville)
        VALUES (p_code, p_type, p_nom, p_prenom, p_date_naissance, p_sexe, p_cin, p_email, p_telephone, p_adresse, p_ville)
        RETURNING id_client INTO v_id;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Client créé', 'id_genere' VALUE v_id);
    EXCEPTION WHEN OTHERS THEN
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE SQLERRM);
    END;

    FUNCTION modifier(p_id NUMBER, p_code VARCHAR2, p_type VARCHAR2, p_nom VARCHAR2, p_prenom VARCHAR2 DEFAULT NULL,
                      p_date_naissance DATE DEFAULT NULL, p_sexe CHAR DEFAULT NULL, p_cin VARCHAR2 DEFAULT NULL,
                      p_email VARCHAR2 DEFAULT NULL, p_telephone VARCHAR2 DEFAULT NULL,
                      p_adresse VARCHAR2 DEFAULT NULL, p_ville VARCHAR2 DEFAULT NULL, p_actif CHAR DEFAULT 'O') RETURN CLOB IS
    BEGIN
        UPDATE REF_CLIENTS
        SET code_client = p_code, type_client = p_type, nom = p_nom, prenom = p_prenom,
            date_naissance = p_date_naissance, sexe = p_sexe, cin = p_cin,
            email = p_email, telephone = p_telephone, adresse = p_adresse,
            ville = p_ville, actif = p_actif, date_maj = SYSDATE
        WHERE id_client = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Client non trouvé');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Client modifié', 'id_genere' VALUE p_id);
    END;

    FUNCTION supprimer(p_id NUMBER) RETURN CLOB IS
    BEGIN
        DELETE FROM REF_CLIENTS WHERE id_client = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Client non trouvé');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Client supprimé');
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Impossible de supprimer: ' || SQLERRM);
    END;

END PKG_CLIENTS;
/

-- ************************************************************
-- PKG_INTERMEDIAIRES
-- ************************************************************
CREATE OR REPLACE PACKAGE PKG_INTERMEDIAIRES AS
    FUNCTION get_all RETURN CLOB;
    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB;
    FUNCTION creer(p_code VARCHAR2, p_raison VARCHAR2, p_type VARCHAR2 DEFAULT 'COURTIER',
                   p_email VARCHAR2 DEFAULT NULL, p_telephone VARCHAR2 DEFAULT NULL,
                   p_adresse VARCHAR2 DEFAULT NULL, p_ville VARCHAR2 DEFAULT NULL,
                   p_taux NUMBER DEFAULT 0) RETURN CLOB;
    FUNCTION modifier(p_id NUMBER, p_code VARCHAR2, p_raison VARCHAR2, p_type VARCHAR2,
                      p_email VARCHAR2 DEFAULT NULL, p_telephone VARCHAR2 DEFAULT NULL,
                      p_adresse VARCHAR2 DEFAULT NULL, p_ville VARCHAR2 DEFAULT NULL,
                      p_taux NUMBER DEFAULT 0, p_actif CHAR DEFAULT 'O') RETURN CLOB;
    FUNCTION supprimer(p_id NUMBER) RETURN CLOB;
END PKG_INTERMEDIAIRES;
/

CREATE OR REPLACE PACKAGE BODY PKG_INTERMEDIAIRES AS

    FUNCTION get_all RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_intermediaire' VALUE id_intermediaire,
                'code_inter'       VALUE code_inter,
                'raison_sociale'   VALUE raison_sociale,
                'type_inter'       VALUE type_inter,
                'email'            VALUE email,
                'telephone'        VALUE telephone,
                'ville'            VALUE ville,
                'taux_commission'  VALUE taux_commission,
                'actif'            VALUE actif
            ) RETURNING CLOB
        ) INTO v_json FROM REF_INTERMEDIAIRES ORDER BY id_intermediaire;
        RETURN NVL(v_json, '[]');
    END;

    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_OBJECT(
            'id_intermediaire' VALUE id_intermediaire,
            'code_inter'       VALUE code_inter,
            'raison_sociale'   VALUE raison_sociale,
            'type_inter'       VALUE type_inter,
            'email'            VALUE email,
            'telephone'        VALUE telephone,
            'adresse'          VALUE adresse,
            'ville'            VALUE ville,
            'taux_commission'  VALUE taux_commission,
            'actif'            VALUE actif
        RETURNING CLOB) INTO v_json FROM REF_INTERMEDIAIRES WHERE id_intermediaire = p_id;
        RETURN v_json;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RETURN '{"error":"Intermédiaire non trouvé"}';
    END;

    FUNCTION creer(p_code VARCHAR2, p_raison VARCHAR2, p_type VARCHAR2 DEFAULT 'COURTIER',
                   p_email VARCHAR2 DEFAULT NULL, p_telephone VARCHAR2 DEFAULT NULL,
                   p_adresse VARCHAR2 DEFAULT NULL, p_ville VARCHAR2 DEFAULT NULL,
                   p_taux NUMBER DEFAULT 0) RETURN CLOB IS
        v_id NUMBER;
    BEGIN
        INSERT INTO REF_INTERMEDIAIRES (code_inter, raison_sociale, type_inter, email, telephone, adresse, ville, taux_commission)
        VALUES (p_code, p_raison, p_type, p_email, p_telephone, p_adresse, p_ville, p_taux)
        RETURNING id_intermediaire INTO v_id;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Intermédiaire créé', 'id_genere' VALUE v_id);
    EXCEPTION WHEN OTHERS THEN
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE SQLERRM);
    END;

    FUNCTION modifier(p_id NUMBER, p_code VARCHAR2, p_raison VARCHAR2, p_type VARCHAR2,
                      p_email VARCHAR2 DEFAULT NULL, p_telephone VARCHAR2 DEFAULT NULL,
                      p_adresse VARCHAR2 DEFAULT NULL, p_ville VARCHAR2 DEFAULT NULL,
                      p_taux NUMBER DEFAULT 0, p_actif CHAR DEFAULT 'O') RETURN CLOB IS
    BEGIN
        UPDATE REF_INTERMEDIAIRES
        SET code_inter = p_code, raison_sociale = p_raison, type_inter = p_type,
            email = p_email, telephone = p_telephone, adresse = p_adresse,
            ville = p_ville, taux_commission = p_taux, actif = p_actif, date_maj = SYSDATE
        WHERE id_intermediaire = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Intermédiaire non trouvé');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Intermédiaire modifié', 'id_genere' VALUE p_id);
    END;

    FUNCTION supprimer(p_id NUMBER) RETURN CLOB IS
    BEGIN
        DELETE FROM REF_INTERMEDIAIRES WHERE id_intermediaire = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Intermédiaire non trouvé');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Intermédiaire supprimé');
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Impossible de supprimer: ' || SQLERRM);
    END;

END PKG_INTERMEDIAIRES;
/

-- ************************************************************
-- PKG_CONTRATS
-- ************************************************************
CREATE OR REPLACE PACKAGE PKG_CONTRATS AS
    FUNCTION get_all RETURN CLOB;
    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB;
    FUNCTION get_by_client(p_id_client NUMBER) RETURN CLOB;
    FUNCTION creer(p_numero VARCHAR2, p_id_client NUMBER, p_id_formule NUMBER,
                   p_id_intermediaire NUMBER DEFAULT NULL, p_date_effet DATE,
                   p_date_expiration DATE, p_prime NUMBER DEFAULT 0) RETURN CLOB;
    FUNCTION modifier_statut(p_id NUMBER, p_statut VARCHAR2) RETURN CLOB;
    FUNCTION supprimer(p_id NUMBER) RETURN CLOB;
END PKG_CONTRATS;
/

CREATE OR REPLACE PACKAGE BODY PKG_CONTRATS AS

    FUNCTION get_all RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_contrat'      VALUE id_contrat,
                'numero_contrat'  VALUE numero_contrat,
                'client_nom'      VALUE client_nom,
                'client_prenom'   VALUE client_prenom,
                'formule_libelle' VALUE formule_libelle,
                'produit_libelle' VALUE produit_libelle,
                'branche_libelle' VALUE branche_libelle,
                'date_effet'      VALUE TO_CHAR(date_effet,'YYYY-MM-DD'),
                'date_expiration' VALUE TO_CHAR(date_expiration,'YYYY-MM-DD'),
                'prime_totale'    VALUE prime_totale,
                'statut_contrat'  VALUE statut_contrat,
                'intermediaire'   VALUE intermediaire_nom
            ) RETURNING CLOB
        ) INTO v_json FROM V_CONTRATS_DETAIL ORDER BY id_contrat;
        RETURN NVL(v_json, '[]');
    END;

    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_OBJECT(
            'id_contrat'      VALUE id_contrat,
            'numero_contrat'  VALUE numero_contrat,
            'date_effet'      VALUE TO_CHAR(date_effet,'YYYY-MM-DD'),
            'date_expiration' VALUE TO_CHAR(date_expiration,'YYYY-MM-DD'),
            'prime_totale'    VALUE prime_totale,
            'statut_contrat'  VALUE statut_contrat,
            'client'          VALUE JSON_OBJECT(
                'id_client'   VALUE id_client,
                'code_client' VALUE code_client,
                'nom'         VALUE client_nom,
                'prenom'      VALUE client_prenom,
                'type_client' VALUE type_client,
                'telephone'   VALUE client_telephone,
                'email'       VALUE client_email
            ),
            'formule'         VALUE JSON_OBJECT(
                'id_formule'    VALUE id_formule,
                'code_formule'  VALUE code_formule,
                'libelle'       VALUE formule_libelle,
                'prime_base'    VALUE prime_base
            ),
            'produit'         VALUE JSON_OBJECT(
                'id_produit'   VALUE id_produit,
                'code_produit' VALUE code_produit,
                'libelle'      VALUE produit_libelle
            ),
            'branche'         VALUE JSON_OBJECT(
                'id_branche'   VALUE id_branche,
                'code_branche' VALUE code_branche,
                'libelle'      VALUE branche_libelle
            ),
            'intermediaire'   VALUE JSON_OBJECT(
                'id_intermediaire' VALUE id_intermediaire,
                'code_inter'       VALUE code_inter,
                'nom'              VALUE intermediaire_nom,
                'taux_commission'  VALUE taux_commission
            )
        RETURNING CLOB) INTO v_json FROM V_CONTRATS_DETAIL WHERE id_contrat = p_id;
        RETURN v_json;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RETURN '{"error":"Contrat non trouvé"}';
    END;

    FUNCTION get_by_client(p_id_client NUMBER) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_contrat'      VALUE id_contrat,
                'numero_contrat'  VALUE numero_contrat,
                'formule_libelle' VALUE formule_libelle,
                'date_effet'      VALUE TO_CHAR(date_effet,'YYYY-MM-DD'),
                'prime_totale'    VALUE prime_totale,
                'statut_contrat'  VALUE statut_contrat
            ) RETURNING CLOB
        ) INTO v_json FROM V_CONTRATS_DETAIL WHERE id_client = p_id_client;
        RETURN NVL(v_json, '[]');
    END;

    FUNCTION creer(p_numero VARCHAR2, p_id_client NUMBER, p_id_formule NUMBER,
                   p_id_intermediaire NUMBER DEFAULT NULL, p_date_effet DATE,
                   p_date_expiration DATE, p_prime NUMBER DEFAULT 0) RETURN CLOB IS
        v_id NUMBER;
    BEGIN
        INSERT INTO CONTRATS (numero_contrat, id_client, id_formule, id_intermediaire, date_effet, date_expiration, prime_totale)
        VALUES (p_numero, p_id_client, p_id_formule, p_id_intermediaire, p_date_effet, p_date_expiration, p_prime)
        RETURNING id_contrat INTO v_id;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Contrat créé', 'id_genere' VALUE v_id);
    EXCEPTION WHEN OTHERS THEN
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE SQLERRM);
    END;

    FUNCTION modifier_statut(p_id NUMBER, p_statut VARCHAR2) RETURN CLOB IS
    BEGIN
        UPDATE CONTRATS SET statut = p_statut, date_maj = SYSDATE WHERE id_contrat = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Contrat non trouvé');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Statut du contrat modifié', 'id_genere' VALUE p_id);
    END;

    FUNCTION supprimer(p_id NUMBER) RETURN CLOB IS
    BEGIN
        DELETE FROM SINISTRES WHERE id_contrat = p_id;
        DELETE FROM CONTRATS WHERE id_contrat = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Contrat non trouvé');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Contrat supprimé');
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Impossible de supprimer: ' || SQLERRM);
    END;

END PKG_CONTRATS;
/

-- ************************************************************
-- PKG_SINISTRES
-- ************************************************************
CREATE OR REPLACE PACKAGE PKG_SINISTRES AS
    FUNCTION get_all RETURN CLOB;
    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB;
    FUNCTION get_by_contrat(p_id_contrat NUMBER) RETURN CLOB;
    FUNCTION creer(p_numero VARCHAR2, p_id_contrat NUMBER, p_id_garantie NUMBER,
                   p_date_sinistre DATE, p_description VARCHAR2 DEFAULT NULL,
                   p_montant_estime NUMBER DEFAULT 0) RETURN CLOB;
    FUNCTION modifier_statut(p_id NUMBER, p_statut VARCHAR2, p_montant_regle NUMBER DEFAULT NULL) RETURN CLOB;
    FUNCTION supprimer(p_id NUMBER) RETURN CLOB;
END PKG_SINISTRES;
/

CREATE OR REPLACE PACKAGE BODY PKG_SINISTRES AS

    FUNCTION get_all RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_sinistre'      VALUE id_sinistre,
                'numero_sinistre'  VALUE numero_sinistre,
                'numero_contrat'   VALUE numero_contrat,
                'client_nom'       VALUE client_nom,
                'client_prenom'    VALUE client_prenom,
                'garantie_libelle' VALUE garantie_libelle,
                'date_sinistre'    VALUE TO_CHAR(date_sinistre,'YYYY-MM-DD'),
                'montant_estime'   VALUE montant_estime,
                'montant_regle'    VALUE montant_regle,
                'statut_sinistre'  VALUE statut_sinistre
            ) RETURNING CLOB
        ) INTO v_json FROM V_SINISTRES_DETAIL ORDER BY id_sinistre;
        RETURN NVL(v_json, '[]');
    END;

    FUNCTION get_by_id(p_id NUMBER) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_OBJECT(
            'id_sinistre'     VALUE id_sinistre,
            'numero_sinistre' VALUE numero_sinistre,
            'date_sinistre'   VALUE TO_CHAR(date_sinistre,'YYYY-MM-DD'),
            'date_declaration' VALUE TO_CHAR(date_declaration,'YYYY-MM-DD'),
            'description'     VALUE sinistre_description,
            'montant_estime'  VALUE montant_estime,
            'montant_regle'   VALUE montant_regle,
            'statut_sinistre' VALUE statut_sinistre,
            'contrat'         VALUE JSON_OBJECT(
                'id_contrat'      VALUE id_contrat,
                'numero_contrat'  VALUE numero_contrat,
                'statut_contrat'  VALUE statut_contrat
            ),
            'client'          VALUE JSON_OBJECT(
                'id_client'    VALUE id_client,
                'code_client'  VALUE code_client,
                'nom'          VALUE client_nom,
                'prenom'       VALUE client_prenom
            ),
            'garantie'        VALUE JSON_OBJECT(
                'id_garantie'    VALUE id_garantie,
                'code_garantie'  VALUE code_garantie,
                'libelle'        VALUE garantie_libelle,
                'type_garantie'  VALUE type_garantie
            )
        RETURNING CLOB) INTO v_json FROM V_SINISTRES_DETAIL WHERE id_sinistre = p_id;
        RETURN v_json;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RETURN '{"error":"Sinistre non trouvé"}';
    END;

    FUNCTION get_by_contrat(p_id_contrat NUMBER) RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id_sinistre'     VALUE id_sinistre,
                'numero_sinistre' VALUE numero_sinistre,
                'garantie_libelle' VALUE garantie_libelle,
                'date_sinistre'   VALUE TO_CHAR(date_sinistre,'YYYY-MM-DD'),
                'montant_estime'  VALUE montant_estime,
                'statut_sinistre' VALUE statut_sinistre
            ) RETURNING CLOB
        ) INTO v_json FROM V_SINISTRES_DETAIL WHERE id_contrat = p_id_contrat;
        RETURN NVL(v_json, '[]');
    END;

    FUNCTION creer(p_numero VARCHAR2, p_id_contrat NUMBER, p_id_garantie NUMBER,
                   p_date_sinistre DATE, p_description VARCHAR2 DEFAULT NULL,
                   p_montant_estime NUMBER DEFAULT 0) RETURN CLOB IS
        v_id NUMBER;
    BEGIN
        INSERT INTO SINISTRES (numero_sinistre, id_contrat, id_garantie, date_sinistre, description, montant_estime)
        VALUES (p_numero, p_id_contrat, p_id_garantie, p_date_sinistre, p_description, p_montant_estime)
        RETURNING id_sinistre INTO v_id;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Sinistre créé', 'id_genere' VALUE v_id);
    EXCEPTION WHEN OTHERS THEN
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE SQLERRM);
    END;

    FUNCTION modifier_statut(p_id NUMBER, p_statut VARCHAR2, p_montant_regle NUMBER DEFAULT NULL) RETURN CLOB IS
    BEGIN
        UPDATE SINISTRES
        SET statut = p_statut,
            montant_regle = NVL(p_montant_regle, montant_regle),
            date_maj = SYSDATE
        WHERE id_sinistre = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Sinistre non trouvé');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Statut du sinistre modifié', 'id_genere' VALUE p_id);
    END;

    FUNCTION supprimer(p_id NUMBER) RETURN CLOB IS
    BEGIN
        DELETE FROM SINISTRES WHERE id_sinistre = p_id;
        IF SQL%ROWCOUNT = 0 THEN
            RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Sinistre non trouvé');
        END IF;
        COMMIT;
        RETURN JSON_OBJECT('code_retour' VALUE 0, 'message' VALUE 'Sinistre supprimé');
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        RETURN JSON_OBJECT('code_retour' VALUE -1, 'message' VALUE 'Impossible de supprimer: ' || SQLERRM);
    END;

END PKG_SINISTRES;
/
