set linesize 200
set pagesize 100
col session_id format a15
col username format a20
col status format a10
col program format a30
col sql_text format a50

PROMPT ========================================
PROMPT SESSIONS BLOQUANTES OU ACTIVES
PROMPT ========================================
SELECT 
    s.sid || ',' || s.serial# AS session_id,
    s.username,
    s.status,
    s.program,
    q.sql_text
FROM v$session s
LEFT JOIN v$sql q ON s.sql_id = q.sql_id
WHERE s.username = 'ORASSADM'
  AND s.status = 'ACTIVE';

PROMPT ========================================
PROMPT OBJETS INVALIDES DE ORASSADM
PROMPT ========================================
SELECT object_name, object_type, status 
FROM user_objects 
WHERE status = 'INVALID';

EXIT;
