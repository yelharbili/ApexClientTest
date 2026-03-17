-- =============================================================
-- import_apex.sql - Import Application APEX 101 depuis export split
-- Utiliser avec SQLcl uniquement
-- =============================================================
-- Exécution :
--   cd D:\Apex\Travail\testApex\scripts
--   sql ORASSADM/ORASSADM@192.168.108.145:1521/ORASSUITPDB @import_apex.sql
-- =============================================================

cd ..
@apex/f101/install.sql
exit
