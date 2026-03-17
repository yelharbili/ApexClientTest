-- ============================================================
-- 01_tables.sql - Tables du Référentiel Assurance
-- Schéma : ORASSADM  |  PDB : ORASSUITPDB
-- ============================================================

-- ============================================================
-- SEQUENCES
-- ============================================================
CREATE SEQUENCE SEQ_BRANCHES       START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_PRODUITS       START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_GARANTIES      START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_FORMULES       START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_CLIENTS        START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_INTERMEDIAIRES START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_CONTRATS       START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_SINISTRES      START WITH 1 INCREMENT BY 1 NOCACHE;

-- ============================================================
-- 1. REF_BRANCHES  (Branches d'assurance)
-- ============================================================
CREATE TABLE REF_BRANCHES (
    id_branche    NUMBER          DEFAULT SEQ_BRANCHES.NEXTVAL  PRIMARY KEY,
    code_branche  VARCHAR2(10)    NOT NULL UNIQUE,
    libelle       VARCHAR2(100)   NOT NULL,
    description   VARCHAR2(500),
    actif         CHAR(1)         DEFAULT 'O' CHECK (actif IN ('O','N')),
    date_creation DATE            DEFAULT SYSDATE,
    date_maj      DATE            DEFAULT SYSDATE
);

COMMENT ON TABLE  REF_BRANCHES              IS 'Branches d''assurance (Auto, Vie, Santé, etc.)';
COMMENT ON COLUMN REF_BRANCHES.code_branche IS 'Code unique de la branche';
COMMENT ON COLUMN REF_BRANCHES.actif        IS 'O = Actif, N = Inactif';

-- ============================================================
-- 2. REF_PRODUITS  (Produits d'assurance)
-- ============================================================
CREATE TABLE REF_PRODUITS (
    id_produit    NUMBER          DEFAULT SEQ_PRODUITS.NEXTVAL  PRIMARY KEY,
    id_branche    NUMBER          NOT NULL,
    code_produit  VARCHAR2(20)    NOT NULL UNIQUE,
    libelle       VARCHAR2(150)   NOT NULL,
    description   VARCHAR2(500),
    actif         CHAR(1)         DEFAULT 'O' CHECK (actif IN ('O','N')),
    date_creation DATE            DEFAULT SYSDATE,
    date_maj      DATE            DEFAULT SYSDATE,
    CONSTRAINT fk_produit_branche FOREIGN KEY (id_branche) REFERENCES REF_BRANCHES (id_branche)
);

CREATE INDEX idx_produit_branche ON REF_PRODUITS (id_branche);

COMMENT ON TABLE REF_PRODUITS IS 'Produits d''assurance rattachés à une branche';

-- ============================================================
-- 3. REF_GARANTIES  (Garanties)
-- ============================================================
CREATE TABLE REF_GARANTIES (
    id_garantie    NUMBER          DEFAULT SEQ_GARANTIES.NEXTVAL  PRIMARY KEY,
    code_garantie  VARCHAR2(20)    NOT NULL UNIQUE,
    libelle        VARCHAR2(150)   NOT NULL,
    description    VARCHAR2(500),
    type_garantie  VARCHAR2(30)    CHECK (type_garantie IN ('PRINCIPALE','COMPLEMENTAIRE','OPTIONNELLE')),
    actif          CHAR(1)         DEFAULT 'O' CHECK (actif IN ('O','N')),
    date_creation  DATE            DEFAULT SYSDATE,
    date_maj       DATE            DEFAULT SYSDATE
);

COMMENT ON TABLE REF_GARANTIES IS 'Garanties proposées (RC, Vol, Incendie, etc.)';

-- ============================================================
-- 4. REF_FORMULES  (Formules / Plans)
-- ============================================================
CREATE TABLE REF_FORMULES (
    id_formule    NUMBER          DEFAULT SEQ_FORMULES.NEXTVAL  PRIMARY KEY,
    id_produit    NUMBER          NOT NULL,
    code_formule  VARCHAR2(20)    NOT NULL UNIQUE,
    libelle       VARCHAR2(150)   NOT NULL,
    description   VARCHAR2(500),
    prime_base    NUMBER(12,2)    DEFAULT 0,
    actif         CHAR(1)         DEFAULT 'O' CHECK (actif IN ('O','N')),
    date_creation DATE            DEFAULT SYSDATE,
    date_maj      DATE            DEFAULT SYSDATE,
    CONSTRAINT fk_formule_produit FOREIGN KEY (id_produit) REFERENCES REF_PRODUITS (id_produit)
);

CREATE INDEX idx_formule_produit ON REF_FORMULES (id_produit);

COMMENT ON TABLE REF_FORMULES IS 'Formules d''assurance (Tiers, Tous Risques, etc.)';

-- ============================================================
-- 5. REF_FORMULE_GARANTIES  (Lien Formule <-> Garantie)
-- ============================================================
CREATE TABLE REF_FORMULE_GARANTIES (
    id_formule     NUMBER  NOT NULL,
    id_garantie    NUMBER  NOT NULL,
    obligatoire    CHAR(1) DEFAULT 'O' CHECK (obligatoire IN ('O','N')),
    taux_couvert   NUMBER(5,2) DEFAULT 100,
    CONSTRAINT pk_formule_garantie  PRIMARY KEY (id_formule, id_garantie),
    CONSTRAINT fk_fg_formule        FOREIGN KEY (id_formule)  REFERENCES REF_FORMULES  (id_formule),
    CONSTRAINT fk_fg_garantie       FOREIGN KEY (id_garantie) REFERENCES REF_GARANTIES (id_garantie)
);

COMMENT ON TABLE REF_FORMULE_GARANTIES IS 'Association N-N entre formules et garanties';

-- ============================================================
-- 6. REF_CLIENTS  (Clients / Assurés)
-- ============================================================
CREATE TABLE REF_CLIENTS (
    id_client      NUMBER          DEFAULT SEQ_CLIENTS.NEXTVAL  PRIMARY KEY,
    code_client    VARCHAR2(20)    NOT NULL UNIQUE,
    type_client    VARCHAR2(10)    DEFAULT 'PHYSIQUE' CHECK (type_client IN ('PHYSIQUE','MORALE')),
    nom            VARCHAR2(100)   NOT NULL,
    prenom         VARCHAR2(100),
    date_naissance DATE,
    sexe           CHAR(1)         CHECK (sexe IN ('M','F')),
    cin            VARCHAR2(20),
    email          VARCHAR2(150),
    telephone      VARCHAR2(20),
    adresse        VARCHAR2(300),
    ville          VARCHAR2(100),
    actif          CHAR(1)         DEFAULT 'O' CHECK (actif IN ('O','N')),
    date_creation  DATE            DEFAULT SYSDATE,
    date_maj       DATE            DEFAULT SYSDATE
);

COMMENT ON TABLE REF_CLIENTS IS 'Clients / Assurés (personnes physiques ou morales)';

-- ============================================================
-- 7. REF_INTERMEDIAIRES  (Courtiers / Agents)
-- ============================================================
CREATE TABLE REF_INTERMEDIAIRES (
    id_intermediaire  NUMBER          DEFAULT SEQ_INTERMEDIAIRES.NEXTVAL  PRIMARY KEY,
    code_inter        VARCHAR2(20)    NOT NULL UNIQUE,
    raison_sociale    VARCHAR2(150)   NOT NULL,
    type_inter        VARCHAR2(20)    DEFAULT 'COURTIER' CHECK (type_inter IN ('COURTIER','AGENT','DIRECT')),
    email             VARCHAR2(150),
    telephone         VARCHAR2(20),
    adresse           VARCHAR2(300),
    ville             VARCHAR2(100),
    taux_commission   NUMBER(5,2)     DEFAULT 0,
    actif             CHAR(1)         DEFAULT 'O' CHECK (actif IN ('O','N')),
    date_creation     DATE            DEFAULT SYSDATE,
    date_maj          DATE            DEFAULT SYSDATE
);

COMMENT ON TABLE REF_INTERMEDIAIRES IS 'Intermédiaires d''assurance (courtiers, agents)';

-- ============================================================
-- 8. CONTRATS  (Contrats d'assurance)
-- ============================================================
CREATE TABLE CONTRATS (
    id_contrat        NUMBER          DEFAULT SEQ_CONTRATS.NEXTVAL  PRIMARY KEY,
    numero_contrat    VARCHAR2(30)    NOT NULL UNIQUE,
    id_client         NUMBER          NOT NULL,
    id_formule        NUMBER          NOT NULL,
    id_intermediaire  NUMBER,
    date_effet        DATE            NOT NULL,
    date_expiration   DATE            NOT NULL,
    prime_totale      NUMBER(12,2)    DEFAULT 0,
    statut            VARCHAR2(20)    DEFAULT 'EN_COURS' CHECK (statut IN ('EN_COURS','SUSPENDU','RESILIE','EXPIRE')),
    date_creation     DATE            DEFAULT SYSDATE,
    date_maj          DATE            DEFAULT SYSDATE,
    CONSTRAINT fk_contrat_client  FOREIGN KEY (id_client)        REFERENCES REF_CLIENTS        (id_client),
    CONSTRAINT fk_contrat_formule FOREIGN KEY (id_formule)       REFERENCES REF_FORMULES        (id_formule),
    CONSTRAINT fk_contrat_inter   FOREIGN KEY (id_intermediaire) REFERENCES REF_INTERMEDIAIRES  (id_intermediaire)
);

CREATE INDEX idx_contrat_client  ON CONTRATS (id_client);
CREATE INDEX idx_contrat_formule ON CONTRATS (id_formule);

COMMENT ON TABLE CONTRATS IS 'Contrats d''assurance souscrits';

-- ============================================================
-- 9. SINISTRES  (Déclarations de sinistres)
-- ============================================================
CREATE TABLE SINISTRES (
    id_sinistre      NUMBER          DEFAULT SEQ_SINISTRES.NEXTVAL  PRIMARY KEY,
    numero_sinistre  VARCHAR2(30)    NOT NULL UNIQUE,
    id_contrat       NUMBER          NOT NULL,
    id_garantie      NUMBER          NOT NULL,
    date_sinistre    DATE            NOT NULL,
    date_declaration DATE            DEFAULT SYSDATE,
    description      VARCHAR2(1000),
    montant_estime   NUMBER(12,2)    DEFAULT 0,
    montant_regle    NUMBER(12,2)    DEFAULT 0,
    statut           VARCHAR2(20)    DEFAULT 'OUVERT' CHECK (statut IN ('OUVERT','EN_COURS','REGLE','REJETE','CLOS')),
    date_creation    DATE            DEFAULT SYSDATE,
    date_maj         DATE            DEFAULT SYSDATE,
    CONSTRAINT fk_sinistre_contrat  FOREIGN KEY (id_contrat)  REFERENCES CONTRATS      (id_contrat),
    CONSTRAINT fk_sinistre_garantie FOREIGN KEY (id_garantie) REFERENCES REF_GARANTIES (id_garantie)
);

CREATE INDEX idx_sinistre_contrat ON SINISTRES (id_contrat);

COMMENT ON TABLE SINISTRES IS 'Sinistres déclarés sur les contrats';
