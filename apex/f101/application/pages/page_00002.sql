prompt --application/pages/page_00002
begin
--   Manifest
--     PAGE: 00002
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_release=>'23.2.0'
,p_default_workspace_id=>3628745592366285
,p_default_application_id=>101
,p_default_id_offset=>0
,p_default_owner=>'ORASSADM'
);
wwv_flow_imp_page.create_page(
 p_id=>2
,p_name=>'Recherche Branches'
,p_alias=>'RECHERCHE-BRANCHES'
,p_step_title=>'Recherche Branches'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.ass-cards-container {',
'    display: grid;',
'    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));',
'    gap: 20px;',
'    padding: 20px;',
'    background-color: #f8f9fa;',
'}',
'.ass-card {',
'    background: #fff;',
'    border-radius: 12px;',
'    box-shadow: 0 4px 6px rgba(0,0,0,0.05);',
'    border: 1px solid #eaedf1;',
'    transition: transform 0.2s, box-shadow 0.2s;',
'    display: flex;',
'    flex-direction: column;',
'}',
'.ass-card:hover {',
'    transform: translateY(-5px);',
'    box-shadow: 0 10px 20px rgba(0,0,0,0.1);',
'}',
'.ass-card-header {',
'    padding: 15px 20px;',
'    border-bottom: 1px solid #f0f0f0;',
'    display: flex;',
'    align-items: center;',
'    gap: 10px;',
'}',
'.ass-badge {',
'    background: #0052cc;',
'    color: white;',
'    padding: 4px 10px;',
'    border-radius: 20px;',
'    font-size: 11px;',
'    font-weight: 700;',
'}',
'.ass-card-header h3 {',
'    margin: 0;',
'    font-size: 16px;',
'    font-weight: 600;',
'    color: #172b4d;',
'}',
'.ass-card-body {',
'    padding: 20px;',
'    flex-grow: 1;',
'    color: #5e6c84;',
'    font-size: 14px;',
'    line-height: 1.5;',
'}',
'.ass-card-footer {',
'    padding: 15px 20px;',
'    background: #fafbfc;',
'    border-radius: 0 0 12px 12px;',
'    text-align: right;',
'    border-top: 1px solid #f0f0f0;',
'}',
''))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'03'
,p_last_updated_by=>'USERADMIN'
,p_last_upd_yyyymmddhh24miss=>'20260303052939'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(4142126085116646)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(3950650434837039)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_06'
,p_menu_id=>wwv_flow_imp.id(3834904836836892)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(4013054343837100)
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(4142866471116656)
,p_name=>'Recherche Branches'
,p_template=>wwv_flow_imp.id(3878717126836993)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_location=>'WEB_SOURCE'
,p_web_src_module_id=>wwv_flow_imp.id(4140854248023350)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id_branche AS ID_BRANCHE,',
'  code_branche AS CODE_BRANCHE,',
'  libelle AS LIBELLE,',
'  description AS DESCRIPTION',
'  from #APEX$SOURCE_DATA#'))
,p_source_post_processing=>'SQL'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(3976446795837060)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4145087078263303)
,p_query_column_id=>1
,p_column_alias=>'ID_BRANCHE'
,p_column_display_sequence=>30
,p_column_heading=>'Id Branche'
,p_use_as_row_header=>'N'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4145265000263305)
,p_query_column_id=>2
,p_column_alias=>'CODE_BRANCHE'
,p_column_display_sequence=>50
,p_column_heading=>'Code Branche'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4144988719263302)
,p_query_column_id=>3
,p_column_alias=>'LIBELLE'
,p_column_display_sequence=>20
,p_column_heading=>'Libelle'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4145159192263304)
,p_query_column_id=>4
,p_column_alias=>'DESCRIPTION'
,p_column_display_sequence=>40
,p_column_heading=>'Description'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp.component_end;
end;
/
