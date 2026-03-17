prompt --application/shared_components/user_interface/templates/report/executive_overview
begin
--   Manifest
--     ROW TEMPLATE: EXECUTIVE_OVERVIEW
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_release=>'23.2.0'
,p_default_workspace_id=>3628745592366285
,p_default_application_id=>101
,p_default_id_offset=>0
,p_default_owner=>'ORASSADM'
);
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(4429834259281784)
,p_row_template_name=>'Executive Overview 827'
,p_internal_name=>'EXECUTIVE_OVERVIEW'
,p_row_template_before_rows=>' '
,p_row_template_after_rows=>' '
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_theme_id=>42
,p_theme_class_id=>8
,p_translate_this_template=>'N'
);
wwv_flow_imp.component_end;
end;
/
