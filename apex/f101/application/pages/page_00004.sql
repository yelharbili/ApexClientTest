prompt --application/pages/page_00004
begin
--   Manifest
--     PAGE: 00004
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
 p_id=>4
,p_name=>'Premium Profile Dashboard'
,p_alias=>'PREMIUM-PROFILE-DASHBOARD'
,p_step_title=>'Premium Profile Dashboard'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
':root {',
'  /* Couleurs issues de votre charte graphique ORASS */',
'  --slate-50: #f8fafc;',
'  --slate-100: #f1f5f9;',
'  --slate-200: #e2e8f0;',
'  --slate-500: #64748b;',
'  --slate-800: #1e293b;',
'  --slate-900: #0f172a;',
'  --indigo-500: #6366f1;',
'  --indigo-600: #4f46e5;',
'  --emerald-100: #d1fae5;',
'  --emerald-700: #047857;',
'  ',
'  /* Ombres et transitions */',
'  --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);',
'  --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);',
'  --transition: box-shadow 0.2s ease-in-out;',
'}',
'',
'/* Container de la carte */',
'.card-contract {',
'  background-color: #ffffff;',
'  border-radius: 0.75rem; /* rounded-xl */',
'  border: 1px solid var(--slate-200);',
'  box-shadow: var(--shadow-sm);',
'  padding: 1.5rem; /* p-6 */',
'  transition: var(--transition);',
'  max-width: 400px; /* Optionnel : pour le test */',
'}',
'',
'.card-contract:hover {',
'  box-shadow: var(--shadow-md);',
'}',
'',
unistr('/* En-t\00EAte du contrat (Branche & Num\00E9ro) */'),
'.card-header {',
'  display: flex;',
'  justify-content: space-between;',
'  align-items: flex-start;',
'  margin-bottom: 1rem;',
'}',
'',
'.branche-label {',
'  display: block;',
'  font-size: 0.75rem;',
'  font-weight: 700;',
'  color: var(--indigo-600);',
'  text-transform: uppercase;',
'  letter-spacing: 0.05em;',
'}',
'',
'.numero-contrat {',
'  font-size: 1.125rem;',
'  font-weight: 700;',
'  color: var(--slate-800);',
'  margin: 0;',
'}',
'',
'/* Badge de Statut */',
'.badge-status {',
'  padding: 0.25rem 0.75rem;',
'  background-color: var(--emerald-100);',
'  color: var(--emerald-700);',
'  font-size: 0.75rem;',
'  font-weight: 700;',
'  border-radius: 9999px;',
'}',
'',
'/* Section Garanties */',
'.guarantee-container {',
'  display: flex;',
'  flex-direction: column;',
'  gap: 0.75rem; /* space-y-3 */',
'}',
'',
'.guarantee-info {',
'  display: flex;',
'  justify-content: space-between;',
'  font-size: 0.75rem;',
'  margin-bottom: 0.25rem;',
'}',
'',
'.guarantee-label { color: var(--slate-500); }',
'.guarantee-value { font-weight: 600; }',
'',
'/* Barre de progression */',
'.progress-bg {',
'  width: 100%;',
'  background-color: var(--slate-100);',
'  height: 0.375rem;',
'  border-radius: 9999px;',
'  overflow: hidden;',
'}',
'',
'.progress-fill {',
'  background-color: var(--indigo-500);',
'  height: 100%;',
'  border-radius: 9999px;',
'}',
'',
'/* Pied de carte (Prime) */',
'.card-footer {',
'  margin-top: 1.5rem;',
'  padding-top: 1rem;',
'  border-top: 1px solid var(--slate-50);',
'  display: flex;',
'  justify-content: space-between;',
'  align-items: center;',
'}',
'',
'.prime-label {',
'  font-size: 0.875rem;',
'  color: var(--slate-500);',
'}',
'',
'.prime-value {',
'  font-size: 1.125rem;',
'  font-weight: 900;',
'  color: var(--slate-900);',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'03'
,p_last_updated_by=>'USERADMIN'
,p_last_upd_yyyymmddhh24miss=>'20260311154947'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(4438707483467402)
,p_name=>'Profile Container'
,p_template=>wwv_flow_imp.id(3871649564836990)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_location=>'WEB_SOURCE'
,p_web_src_module_id=>wwv_flow_imp.id(4449468179651031)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select REF_CLIENTS.ID_CLIENT as ID_CLIENT,',
'    REF_CLIENTS.CODE_CLIENT as CODE_CLIENT,',
'    REF_CLIENTS.TYPE_CLIENT as TYPE_CLIENT,',
'    REF_CLIENTS.NOM as NOM,',
'    REF_CLIENTS.PRENOM as PRENOM,',
'    REF_CLIENTS.DATE_NAISSANCE as DATE_NAISSANCE,',
'    REF_CLIENTS.SEXE as SEXE,',
'    REF_CLIENTS.EMAIL as EMAIL,',
'    REF_CLIENTS.CIN as CIN,',
'    REF_CLIENTS.TELEPHONE as TELEPHONE,',
'    REF_CLIENTS.ADRESSE as ADRESSE,',
'    REF_CLIENTS.VILLE as VILLE,',
'    REF_CLIENTS.ACTIF as ACTIF,',
'    REF_CLIENTS.DATE_CREATION as DATE_CREATION,',
'    REF_CLIENTS.DATE_MAJ as DATE_MAJ ',
' from REF_CLIENTS REF_CLIENTS'))
,p_source_post_processing=>'SQL'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(4453638130858851)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_row_count_max=>1
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4441894598467433)
,p_query_column_id=>1
,p_column_alias=>'ID_CLIENT'
,p_column_display_sequence=>130
,p_column_heading=>'Id Client'
,p_use_as_row_header=>'N'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4441981329467434)
,p_query_column_id=>2
,p_column_alias=>'CODE_CLIENT'
,p_column_display_sequence=>140
,p_column_heading=>'Code Client'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4442020859467435)
,p_query_column_id=>3
,p_column_alias=>'TYPE_CLIENT'
,p_column_display_sequence=>150
,p_column_heading=>'Type Client'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4442148233467436)
,p_query_column_id=>4
,p_column_alias=>'NOM'
,p_column_display_sequence=>160
,p_column_heading=>'Nom'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4442279943467437)
,p_query_column_id=>5
,p_column_alias=>'PRENOM'
,p_column_display_sequence=>170
,p_column_heading=>'Prenom'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4442342510467438)
,p_query_column_id=>6
,p_column_alias=>'DATE_NAISSANCE'
,p_column_display_sequence=>180
,p_column_heading=>'Date Naissance'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4442461158467439)
,p_query_column_id=>7
,p_column_alias=>'SEXE'
,p_column_display_sequence=>190
,p_column_heading=>'Sexe'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4442592491467440)
,p_query_column_id=>8
,p_column_alias=>'EMAIL'
,p_column_display_sequence=>200
,p_column_heading=>'Email'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4442626890467441)
,p_query_column_id=>9
,p_column_alias=>'CIN'
,p_column_display_sequence=>210
,p_column_heading=>'Cin'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4442741561467442)
,p_query_column_id=>10
,p_column_alias=>'TELEPHONE'
,p_column_display_sequence=>220
,p_column_heading=>'Telephone'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4442847063467443)
,p_query_column_id=>11
,p_column_alias=>'ADRESSE'
,p_column_display_sequence=>230
,p_column_heading=>'Adresse'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4442918142467444)
,p_query_column_id=>12
,p_column_alias=>'VILLE'
,p_column_display_sequence=>240
,p_column_heading=>'Ville'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4443086806467445)
,p_query_column_id=>13
,p_column_alias=>'ACTIF'
,p_column_display_sequence=>250
,p_column_heading=>'Actif'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4441632300467431)
,p_query_column_id=>14
,p_column_alias=>'DATE_CREATION'
,p_column_display_sequence=>110
,p_column_heading=>'Date Creation'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4441747268467432)
,p_query_column_id=>15
,p_column_alias=>'DATE_MAJ'
,p_column_display_sequence=>120
,p_column_heading=>'Date Maj'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(4444658635566743)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(3950650434837039)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(3834904836836892)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(4013054343837100)
);
wwv_flow_imp.component_end;
end;
/
