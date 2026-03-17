SET PAGESIZE 100
SET LINESIZE 200
COL OBJECT_TYPE FORMAT A20
COL STATUS FORMAT A10

PROMPT ========================================
PROMPT SYNTHESE DES OBJETS DANS LE SCHEMA ORASSADM
PROMPT ========================================

SELECT object_type, status, COUNT(*) as TOTAL
FROM user_objects
GROUP BY object_type, status
ORDER BY object_type;

PROMPT ========================================
PROMPT DETAIL DES OBJETS INVALIDES (SI EXISTANTS)
PROMPT ========================================

SELECT object_name, object_type, status
FROM user_objects
WHERE status = 'INVALID';

EXIT;
