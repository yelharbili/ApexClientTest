prompt --workspace/remote_servers/192_168_108_138_ords_orassuitpdb
begin
--   Manifest
--     REMOTE SERVER: 192-168-108-138-ords-orassuitpdb
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_release=>'23.2.0'
,p_default_workspace_id=>3628745592366285
,p_default_application_id=>101
,p_default_id_offset=>0
,p_default_owner=>'ORASSADM'
);
wwv_imp_workspace.create_remote_server(
 p_id=>wwv_flow_imp.id(4446348821650859)
,p_name=>'192-168-108-138-ords-orassuitpdb'
,p_static_id=>'192_168_108_138_ords_orassuitpdb'
,p_base_url=>nvl(wwv_flow_application_install.get_remote_server_base_url('192_168_108_138_ords_orassuitpdb'),'http://192.168.108.145:8181/ords/orassuitpdb/')
,p_https_host=>nvl(wwv_flow_application_install.get_remote_server_https_host('192_168_108_138_ords_orassuitpdb'),'')
,p_server_type=>'WEB_SERVICE'
,p_ords_timezone=>nvl(wwv_flow_application_install.get_remote_server_ords_tz('192_168_108_138_ords_orassuitpdb'),'')
,p_remote_sql_default_schema=>nvl(wwv_flow_application_install.get_remote_server_default_db('192_168_108_138_ords_orassuitpdb'),'')
,p_mysql_sql_modes=>nvl(wwv_flow_application_install.get_remote_server_sql_mode('192_168_108_138_ords_orassuitpdb'),'')
,p_prompt_on_install=>false
);
wwv_flow_imp.component_end;
end;
/
