prompt --application/shared_components/user_interface/templates/report/mon_template_assurance
begin
--   Manifest
--     ROW TEMPLATE: MON_TEMPLATE_ASSURANCE
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
 p_id=>wwv_flow_imp.id(4144262600191929)
,p_row_template_name=>'Mon Template Assurance'
,p_internal_name=>'MON_TEMPLATE_ASSURANCE'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ass-card">',
'  <div class="ass-card-header">',
'    <span class="ass-badge">#CODE_BRANCHE#</span>',
'    <h3>#LIBELLE#</h3>',
'  </div>',
'  <div class="ass-card-body">',
'    <p>#DESCRIPTION#</p>',
'  </div>',
'  <div class="ass-card-footer">',
unistr('    <button class="t-Button t-Button--hot t-Button--simple">D\00E9tails</button>'),
'  </div>',
'</div>'))
,p_row_template_before_rows=>' <div class="ass-cards-container">'
,p_row_template_after_rows=>' </div>'
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_theme_id=>42
,p_theme_class_id=>7
,p_translate_this_template=>'N'
);
wwv_flow_imp.component_end;
end;
/
