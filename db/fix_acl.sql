BEGIN
  -- Nettoyage de l'ancienne règle si elle existe
  BEGIN
    DBMS_NETWORK_ACL_ADMIN.drop_acl ( 
      acl => 'apex_ords_access.xml'
    );
  EXCEPTION WHEN OTHERS THEN NULL;
  END;

  -- Création d'une nouvelle règle formelle (ACL File)
  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => 'apex_ords_access.xml', 
    description  => 'Acces HTTP pour APEX vers ORDS',
    principal    => 'APEX_230200',
    is_grant     => TRUE, 
    privilege    => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);

  -- Ajout du privilège resolve pour APEX
  DBMS_NETWORK_ACL_ADMIN.add_privilege ( 
    acl         => 'apex_ords_access.xml', 
    principal   => 'APEX_230200',
    is_grant    => TRUE, 
    privilege   => 'resolve');

  -- Ajout des mêmes privilèges pour ORASSADM
  DBMS_NETWORK_ACL_ADMIN.add_privilege ( 
    acl         => 'apex_ords_access.xml', 
    principal   => 'ORASSADM',
    is_grant    => TRUE, 
    privilege   => 'connect');

  DBMS_NETWORK_ACL_ADMIN.add_privilege ( 
    acl         => 'apex_ords_access.xml', 
    principal   => 'ORASSADM',
    is_grant    => TRUE, 
    privilege   => 'resolve');

  -- Affectation explicite de l'ACL à toutes les adresses IP (*) sans restriction de port
  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => 'apex_ords_access.xml',
    host        => '*');

  COMMIT;
END;
/
EXIT;
