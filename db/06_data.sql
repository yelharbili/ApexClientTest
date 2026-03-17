-- ============================================================
-- 06_data.sql - Données de Test
-- Schéma : ORASSADM  |  PDB : ORASSUITPDB
-- ============================================================

-- ============================================================
-- BRANCHES D'ASSURANCE
-- ============================================================
INSERT INTO REF_BRANCHES (code_branche, libelle, description) VALUES ('AUTO', 'Automobile', 'Assurance véhicules terrestres à moteur');
INSERT INTO REF_BRANCHES (code_branche, libelle, description) VALUES ('VIE', 'Vie', 'Assurance vie et décès');
INSERT INTO REF_BRANCHES (code_branche, libelle, description) VALUES ('SANTE', 'Santé', 'Assurance maladie et complémentaire santé');
INSERT INTO REF_BRANCHES (code_branche, libelle, description) VALUES ('HABIT', 'Habitation', 'Assurance multirisque habitation');
INSERT INTO REF_BRANCHES (code_branche, libelle, description) VALUES ('RESP', 'Responsabilité Civile', 'Assurance responsabilité civile professionnelle');

-- ============================================================
-- PRODUITS D'ASSURANCE
-- ============================================================
-- Automobile
INSERT INTO REF_PRODUITS (id_branche, code_produit, libelle, description)
VALUES (1, 'AUTO-VP', 'Auto Véhicule Particulier', 'Assurance pour voitures particulières');
INSERT INTO REF_PRODUITS (id_branche, code_produit, libelle, description)
VALUES (1, 'AUTO-UTI', 'Auto Utilitaire', 'Assurance pour véhicules utilitaires');
-- Vie
INSERT INTO REF_PRODUITS (id_branche, code_produit, libelle, description)
VALUES (2, 'VIE-IND', 'Vie Individuelle', 'Assurance vie individuelle épargne');
INSERT INTO REF_PRODUITS (id_branche, code_produit, libelle, description)
VALUES (2, 'VIE-GRP', 'Vie Groupe', 'Assurance vie collective entreprise');
-- Santé
INSERT INTO REF_PRODUITS (id_branche, code_produit, libelle, description)
VALUES (3, 'SANTE-IND', 'Santé Individuelle', 'Complémentaire santé individuelle');
INSERT INTO REF_PRODUITS (id_branche, code_produit, libelle, description)
VALUES (3, 'SANTE-FAM', 'Santé Famille', 'Complémentaire santé familiale');
-- Habitation
INSERT INTO REF_PRODUITS (id_branche, code_produit, libelle, description)
VALUES (4, 'HABIT-MRH', 'Multirisque Habitation', 'Assurance multirisque habitation complète');

-- ============================================================
-- GARANTIES
-- ============================================================
INSERT INTO REF_GARANTIES (code_garantie, libelle, type_garantie, description) VALUES ('RC', 'Responsabilité Civile', 'PRINCIPALE', 'Couverture des dommages causés aux tiers');
INSERT INTO REF_GARANTIES (code_garantie, libelle, type_garantie, description) VALUES ('VOL', 'Vol', 'COMPLEMENTAIRE', 'Couverture contre le vol du véhicule');
INSERT INTO REF_GARANTIES (code_garantie, libelle, type_garantie, description) VALUES ('INC', 'Incendie', 'COMPLEMENTAIRE', 'Couverture contre l''incendie');
INSERT INTO REF_GARANTIES (code_garantie, libelle, type_garantie, description) VALUES ('BDG', 'Bris de Glace', 'OPTIONNELLE', 'Remplacement des vitres et pare-brise');
INSERT INTO REF_GARANTIES (code_garantie, libelle, type_garantie, description) VALUES ('DC', 'Décès', 'PRINCIPALE', 'Capital versé aux bénéficiaires en cas de décès');
INSERT INTO REF_GARANTIES (code_garantie, libelle, type_garantie, description) VALUES ('INV', 'Invalidité', 'COMPLEMENTAIRE', 'Rente en cas d''invalidité permanente');
INSERT INTO REF_GARANTIES (code_garantie, libelle, type_garantie, description) VALUES ('HOSP', 'Hospitalisation', 'PRINCIPALE', 'Prise en charge des frais d''hospitalisation');
INSERT INTO REF_GARANTIES (code_garantie, libelle, type_garantie, description) VALUES ('DENT', 'Soins Dentaires', 'OPTIONNELLE', 'Remboursement des soins dentaires');
INSERT INTO REF_GARANTIES (code_garantie, libelle, type_garantie, description) VALUES ('OPT', 'Optique', 'OPTIONNELLE', 'Remboursement lunettes et lentilles');
INSERT INTO REF_GARANTIES (code_garantie, libelle, type_garantie, description) VALUES ('DDE', 'Dégât des Eaux', 'PRINCIPALE', 'Couverture dégâts des eaux habitation');
INSERT INTO REF_GARANTIES (code_garantie, libelle, type_garantie, description) VALUES ('ASSI', 'Assistance', 'OPTIONNELLE', 'Assistance dépannage et remorquage 24/7');
INSERT INTO REF_GARANTIES (code_garantie, libelle, type_garantie, description) VALUES ('CATA', 'Catastrophe Naturelle', 'COMPLEMENTAIRE', 'Couverture catastrophes naturelles');

-- ============================================================
-- FORMULES
-- ============================================================
-- Auto VP
INSERT INTO REF_FORMULES (id_produit, code_formule, libelle, prime_base, description)
VALUES (1, 'AUTO-TIERS', 'Tiers Simple', 1500.00, 'Couverture minimale obligatoire');
INSERT INTO REF_FORMULES (id_produit, code_formule, libelle, prime_base, description)
VALUES (1, 'AUTO-INTER', 'Tiers Étendu', 2800.00, 'Tiers + Vol + Incendie');
INSERT INTO REF_FORMULES (id_produit, code_formule, libelle, prime_base, description)
VALUES (1, 'AUTO-TR', 'Tous Risques', 4500.00, 'Couverture all-inclusive');
-- Vie Individuelle
INSERT INTO REF_FORMULES (id_produit, code_formule, libelle, prime_base, description)
VALUES (3, 'VIE-ESSEN', 'Essentielle', 3000.00, 'Protection décès de base');
INSERT INTO REF_FORMULES (id_produit, code_formule, libelle, prime_base, description)
VALUES (3, 'VIE-PREM', 'Premium', 6000.00, 'Décès + Invalidité complète');
-- Santé Individuelle
INSERT INTO REF_FORMULES (id_produit, code_formule, libelle, prime_base, description)
VALUES (5, 'SANTE-ECO', 'Économique', 1200.00, 'Hospitalisation uniquement');
INSERT INTO REF_FORMULES (id_produit, code_formule, libelle, prime_base, description)
VALUES (5, 'SANTE-CONF', 'Confort', 2400.00, 'Hospitalisation + Soins dentaires + Optique');
-- Habitation
INSERT INTO REF_FORMULES (id_produit, code_formule, libelle, prime_base, description)
VALUES (7, 'MRH-BASE', 'MRH Base', 800.00, 'Protection de base habitation');
INSERT INTO REF_FORMULES (id_produit, code_formule, libelle, prime_base, description)
VALUES (7, 'MRH-PLUS', 'MRH Plus', 1500.00, 'Protection étendue habitation');

-- ============================================================
-- FORMULE - GARANTIES (Associations)
-- ============================================================
-- Auto Tiers : RC obligatoire
INSERT INTO REF_FORMULE_GARANTIES VALUES (1, 1, 'O', 100);
-- Auto Tiers Étendu : RC + Vol + Incendie
INSERT INTO REF_FORMULE_GARANTIES VALUES (2, 1, 'O', 100);
INSERT INTO REF_FORMULE_GARANTIES VALUES (2, 2, 'O', 80);
INSERT INTO REF_FORMULE_GARANTIES VALUES (2, 3, 'O', 80);
-- Auto Tous Risques : RC + Vol + Incendie + Bris de Glace + Assistance
INSERT INTO REF_FORMULE_GARANTIES VALUES (3, 1, 'O', 100);
INSERT INTO REF_FORMULE_GARANTIES VALUES (3, 2, 'O', 100);
INSERT INTO REF_FORMULE_GARANTIES VALUES (3, 3, 'O', 100);
INSERT INTO REF_FORMULE_GARANTIES VALUES (3, 4, 'O', 100);
INSERT INTO REF_FORMULE_GARANTIES VALUES (3, 11, 'O', 100);
-- Vie Essentielle : Décès
INSERT INTO REF_FORMULE_GARANTIES VALUES (4, 5, 'O', 100);
-- Vie Premium : Décès + Invalidité
INSERT INTO REF_FORMULE_GARANTIES VALUES (5, 5, 'O', 100);
INSERT INTO REF_FORMULE_GARANTIES VALUES (5, 6, 'O', 100);
-- Santé Économique : Hospitalisation
INSERT INTO REF_FORMULE_GARANTIES VALUES (6, 7, 'O', 70);
-- Santé Confort : Hospitalisation + Dentaire + Optique
INSERT INTO REF_FORMULE_GARANTIES VALUES (7, 7, 'O', 90);
INSERT INTO REF_FORMULE_GARANTIES VALUES (7, 8, 'O', 60);
INSERT INTO REF_FORMULE_GARANTIES VALUES (7, 9, 'O', 50);
-- MRH Base : Incendie + Dégât des Eaux
INSERT INTO REF_FORMULE_GARANTIES VALUES (8, 3, 'O', 100);
INSERT INTO REF_FORMULE_GARANTIES VALUES (8, 10, 'O', 100);
-- MRH Plus : Incendie + Dégât des Eaux + Vol + Catastrophe Naturelle
INSERT INTO REF_FORMULE_GARANTIES VALUES (9, 3, 'O', 100);
INSERT INTO REF_FORMULE_GARANTIES VALUES (9, 10, 'O', 100);
INSERT INTO REF_FORMULE_GARANTIES VALUES (9, 2, 'O', 80);
INSERT INTO REF_FORMULE_GARANTIES VALUES (9, 12, 'O', 100);

-- ============================================================
-- CLIENTS
-- ============================================================
INSERT INTO REF_CLIENTS (code_client, type_client, nom, prenom, date_naissance, sexe, cin, email, telephone, adresse, ville)
VALUES ('CLI-001', 'PHYSIQUE', 'BENALI', 'Mohammed', DATE '1985-03-15', 'M', 'BK123456', 'mohammed.benali@email.com', '0661234567', '12 Rue Hassan II', 'Casablanca');

INSERT INTO REF_CLIENTS (code_client, type_client, nom, prenom, date_naissance, sexe, cin, email, telephone, adresse, ville)
VALUES ('CLI-002', 'PHYSIQUE', 'ELMOUSSAOUI', 'Fatima', DATE '1990-07-22', 'F', 'BJ789012', 'fatima.elmoussaoui@email.com', '0677654321', '45 Bd Mohammed V', 'Rabat');

INSERT INTO REF_CLIENTS (code_client, type_client, nom, prenom, date_naissance, sexe, cin, email, telephone, adresse, ville)
VALUES ('CLI-003', 'PHYSIQUE', 'TAZI', 'Youssef', DATE '1978-11-03', 'M', 'BE345678', 'youssef.tazi@email.com', '0654321987', '8 Av des FAR', 'Marrakech');

INSERT INTO REF_CLIENTS (code_client, type_client, nom, prenom, date_naissance, sexe, email, telephone, adresse, ville)
VALUES ('CLI-004', 'MORALE', 'SOCIETE ATLAS CONSTRUCT', NULL, NULL, NULL, 'contact@atlas-construct.ma', '0522987654', '120 Zone Industrielle Ain Sebaa', 'Casablanca');

INSERT INTO REF_CLIENTS (code_client, type_client, nom, prenom, date_naissance, sexe, cin, email, telephone, adresse, ville)
VALUES ('CLI-005', 'PHYSIQUE', 'ALAOUI', 'Amina', DATE '1995-01-10', 'F', 'BM567890', 'amina.alaoui@email.com', '0699887766', '33 Rue de la Liberté', 'Fès');

-- ============================================================
-- INTERMEDIAIRES
-- ============================================================
INSERT INTO REF_INTERMEDIAIRES (code_inter, raison_sociale, type_inter, email, telephone, adresse, ville, taux_commission)
VALUES ('INT-001', 'Cabinet Assur Plus', 'COURTIER', 'contact@assurplus.ma', '0522112233', '15 Rue de Fès', 'Casablanca', 12.50);

INSERT INTO REF_INTERMEDIAIRES (code_inter, raison_sociale, type_inter, email, telephone, adresse, ville, taux_commission)
VALUES ('INT-002', 'Agence Nationale Assurance', 'AGENT', 'info@ana-assurance.ma', '0537445566', '78 Av Hassan II', 'Rabat', 8.00);

INSERT INTO REF_INTERMEDIAIRES (code_inter, raison_sociale, type_inter, email, telephone, adresse, ville, taux_commission)
VALUES ('INT-003', 'Direct Assur Online', 'DIRECT', 'support@directassur.ma', '0800001122', 'Web uniquement', 'Casablanca', 3.00);

-- ============================================================
-- CONTRATS
-- ============================================================
-- Client 1 : Auto Tous Risques
INSERT INTO CONTRATS (numero_contrat, id_client, id_formule, id_intermediaire, date_effet, date_expiration, prime_totale)
VALUES ('CTR-2024-00001', 1, 3, 1, DATE '2024-01-01', DATE '2025-01-01', 4500.00);

-- Client 1 : Santé Confort
INSERT INTO CONTRATS (numero_contrat, id_client, id_formule, id_intermediaire, date_effet, date_expiration, prime_totale)
VALUES ('CTR-2024-00002', 1, 7, 1, DATE '2024-02-01', DATE '2025-02-01', 2400.00);

-- Client 2 : Auto Tiers
INSERT INTO CONTRATS (numero_contrat, id_client, id_formule, id_intermediaire, date_effet, date_expiration, prime_totale)
VALUES ('CTR-2024-00003', 2, 1, 2, DATE '2024-03-15', DATE '2025-03-15', 1500.00);

-- Client 2 : Vie Premium
INSERT INTO CONTRATS (numero_contrat, id_client, id_formule, id_intermediaire, date_effet, date_expiration, prime_totale)
VALUES ('CTR-2024-00004', 2, 5, 2, DATE '2024-04-01', DATE '2025-04-01', 6000.00);

-- Client 3 : MRH Plus
INSERT INTO CONTRATS (numero_contrat, id_client, id_formule, id_intermediaire, date_effet, date_expiration, prime_totale)
VALUES ('CTR-2024-00005', 3, 9, 3, DATE '2024-05-01', DATE '2025-05-01', 1500.00);

-- Client 4 (Société) : Auto Utilitaire Tiers Étendu (on utilise formule 2)
INSERT INTO CONTRATS (numero_contrat, id_client, id_formule, id_intermediaire, date_effet, date_expiration, prime_totale, statut)
VALUES ('CTR-2024-00006', 4, 2, 1, DATE '2024-01-15', DATE '2025-01-15', 2800.00, 'EN_COURS');

-- Client 5 : Santé Économique
INSERT INTO CONTRATS (numero_contrat, id_client, id_formule, date_effet, date_expiration, prime_totale)
VALUES ('CTR-2024-00007', 5, 6, DATE '2024-06-01', DATE '2025-06-01', 1200.00);

-- ============================================================
-- SINISTRES
-- ============================================================
-- Sinistre Auto sur contrat 1 (Client 1, Tous Risques)
INSERT INTO SINISTRES (numero_sinistre, id_contrat, id_garantie, date_sinistre, description, montant_estime, montant_regle, statut)
VALUES ('SIN-2024-00001', 1, 1, DATE '2024-06-15', 'Accident de circulation sur autoroute A3 - collision arrière', 25000.00, 22000.00, 'REGLE');

-- Sinistre Vol sur contrat 1
INSERT INTO SINISTRES (numero_sinistre, id_contrat, id_garantie, date_sinistre, description, montant_estime, statut)
VALUES ('SIN-2024-00002', 1, 2, DATE '2024-09-20', 'Tentative de vol avec effraction - portière endommagée', 8000.00, 'EN_COURS');

-- Sinistre Santé sur contrat 2 (Client 1, Santé)
INSERT INTO SINISTRES (numero_sinistre, id_contrat, id_garantie, date_sinistre, description, montant_estime, montant_regle, statut)
VALUES ('SIN-2024-00003', 2, 7, DATE '2024-07-10', 'Hospitalisation chirurgie appendicite - 3 jours', 15000.00, 13500.00, 'REGLE');

-- Sinistre MRH sur contrat 5 (Client 3)
INSERT INTO SINISTRES (numero_sinistre, id_contrat, id_garantie, date_sinistre, description, montant_estime, statut)
VALUES ('SIN-2024-00004', 5, 10, DATE '2024-08-05', 'Dégât des eaux - canalisation rompue au 2ème étage', 12000.00, 'OUVERT');

-- Sinistre rejeté
INSERT INTO SINISTRES (numero_sinistre, id_contrat, id_garantie, date_sinistre, description, montant_estime, montant_regle, statut)
VALUES ('SIN-2024-00005', 3, 1, DATE '2024-10-01', 'Accident parking - pas de constat amiable fourni', 5000.00, 0, 'REJETE');

COMMIT;

PROMPT ========================================
PROMPT Données de test insérées avec succès
PROMPT - 5 branches
PROMPT - 7 produits
PROMPT - 12 garanties
PROMPT - 9 formules
PROMPT - 22 associations formule-garanties
PROMPT - 5 clients
PROMPT - 3 intermédiaires
PROMPT - 7 contrats
PROMPT - 5 sinistres
PROMPT ========================================
