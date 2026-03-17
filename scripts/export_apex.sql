-- =============================================================
-- export_apex.sql - Export Application APEX 101 en mode "split"
-- Utiliser avec SQLcl uniquement
-- =============================================================
-- Exécution : 
--   cd D:\Apex\Travail\testApex\scripts
--   sql ORASSADM/ORASSADM@192.168.108.145:1521/ORASSUITPDB @export_apex.sql
-- =============================================================

cd ..
apex export -applicationid 101 -dir apex -split
exit
