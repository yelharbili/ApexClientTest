prompt --application/shared_components/web_sources/api_branches
begin
--   Manifest
--     WEB SOURCE: API_BRANCHES
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_release=>'23.2.0'
,p_default_workspace_id=>3628745592366285
,p_default_application_id=>101
,p_default_id_offset=>0
,p_default_owner=>'ORASSADM'
);
wwv_flow_imp_shared.create_web_source_module(
 p_id=>wwv_flow_imp.id(4140854248023350)
,p_name=>'API_BRANCHES'
,p_static_id=>'api_branches'
,p_web_source_type=>'NATIVE_HTTP'
,p_data_profile_id=>wwv_flow_imp.id(4138898640023329)
,p_remote_server_id=>wwv_flow_imp.id(4138601984023321)
,p_url_path_prefix=>'/orassadm/referentiel/branches/'
,p_attribute_05=>'1'
,p_attribute_08=>'OFFSET'
,p_attribute_10=>'EQUALS'
,p_attribute_11=>'true'
);
wwv_flow_imp_shared.create_web_source_operation(
 p_id=>wwv_flow_imp.id(4141087240023379)
,p_web_src_module_id=>wwv_flow_imp.id(4140854248023350)
,p_operation=>'GET'
,p_database_operation=>'FETCH_COLLECTION'
,p_url_pattern=>'.'
,p_force_error_for_http_404=>false
,p_allow_fetch_all_rows=>false
);
wwv_flow_imp.component_end;
end;
/
