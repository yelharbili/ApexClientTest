prompt --application/shared_components/user_interface/themes
begin
--   Manifest
--     THEME: 101
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_release=>'23.2.0'
,p_default_workspace_id=>3628745592366285
,p_default_application_id=>101
,p_default_id_offset=>0
,p_default_owner=>'ORASSADM'
);
wwv_flow_imp_shared.create_theme(
 p_id=>wwv_flow_imp.id(4101474745837421)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_imp.id(3861556433836971)
,p_default_dialog_template=>wwv_flow_imp.id(3856342674836968)
,p_error_template=>wwv_flow_imp.id(3846312898836964)
,p_printer_friendly_template=>wwv_flow_imp.id(3861556433836971)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_imp.id(3846312898836964)
,p_default_button_template=>wwv_flow_imp.id(4011471907837096)
,p_default_region_template=>wwv_flow_imp.id(3938280450837031)
,p_default_chart_template=>wwv_flow_imp.id(3938280450837031)
,p_default_form_template=>wwv_flow_imp.id(3938280450837031)
,p_default_reportr_template=>wwv_flow_imp.id(3938280450837031)
,p_default_tabform_template=>wwv_flow_imp.id(3938280450837031)
,p_default_wizard_template=>wwv_flow_imp.id(3938280450837031)
,p_default_menur_template=>wwv_flow_imp.id(3950650434837039)
,p_default_listr_template=>wwv_flow_imp.id(3938280450837031)
,p_default_irr_template=>wwv_flow_imp.id(3928403755837028)
,p_default_report_template=>wwv_flow_imp.id(3976446795837060)
,p_default_label_template=>wwv_flow_imp.id(4008956668837089)
,p_default_menu_template=>wwv_flow_imp.id(4013054343837100)
,p_default_calendar_template=>wwv_flow_imp.id(4013122150837104)
,p_default_list_template=>wwv_flow_imp.id(3992839019837075)
,p_default_nav_list_template=>wwv_flow_imp.id(4004650957837084)
,p_default_top_nav_list_temp=>wwv_flow_imp.id(4004650957837084)
,p_default_side_nav_list_temp=>wwv_flow_imp.id(3999290732837081)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_imp.id(3874444911836992)
,p_default_dialogr_template=>wwv_flow_imp.id(3871649564836990)
,p_default_option_label=>wwv_flow_imp.id(4008956668837089)
,p_default_required_label=>wwv_flow_imp.id(4010287614837092)
,p_default_navbar_list_template=>wwv_flow_imp.id(3998893121837079)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#APEX_FILES#themes/theme_42/23.2/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_FILES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_FILES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
wwv_flow_imp.component_end;
end;
/
