-- ============================================================
-- install_all.sql - Script d'installation principal
-- Schéma : ORASSADM  |  PDB : ORASSUITPDB
-- ============================================================
-- Exécution :
--   sql ORASSADM/ORASSADM@192.168.108.135:1521/ORASSUITPDB @d:\testLundi\testApex\db\install_all.sql
-- ============================================================

SET SERVEROUTPUT ON
SET DEFINE OFF

PROMPT ========================================
PROMPT  INSTALLATION REFERENTIEL ASSURANCE
PROMPT  Schema: ORASSADM
PROMPT  Date  : Automatique
PROMPT ========================================
PROMPT

PROMPT [1/6] Création des tables et séquences...
@d:\testLundi\testApex\db\01_tables.sql
PROMPT

PROMPT [2/6] Création des types Oracle...
@d:\testLundi\testApex\db\02_types.sql
PROMPT

PROMPT [3/6] Création des vues...
@d:\testLundi\testApex\db\03_vues.sql
PROMPT

PROMPT [4/6] Création des packages PL/SQL...
@d:\testLundi\testApex\db\04_packages.sql
PROMPT

PROMPT [5/6] Configuration du module ORDS REST...
@d:\testLundi\testApex\db\05_ords_rest.sql
PROMPT

PROMPT [6/6] Insertion des données de test...
@d:\testLundi\testApex\db\06_data.sql
PROMPT

PROMPT ========================================
PROMPT  INSTALLATION TERMINEE AVEC SUCCES !
PROMPT ========================================
PROMPT
PROMPT  Testez les APIs REST :
PROMPT  http://192.168.108.135:8181/ords/orassadm/referentiel/branches/
PROMPT  http://192.168.108.135:8181/ords/orassadm/referentiel/produits/
PROMPT  http://192.168.108.135:8181/ords/orassadm/referentiel/garanties/
PROMPT  http://192.168.108.135:8181/ords/orassadm/referentiel/formules/
PROMPT  http://192.168.108.135:8181/ords/orassadm/referentiel/clients/
PROMPT  http://192.168.108.135:8181/ords/orassadm/referentiel/intermediaires/
PROMPT  http://192.168.108.135:8181/ords/orassadm/referentiel/contrats/
PROMPT  http://192.168.108.135:8181/ords/orassadm/referentiel/sinistres/
PROMPT ========================================
