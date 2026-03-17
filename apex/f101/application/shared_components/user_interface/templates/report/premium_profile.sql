prompt --application/shared_components/user_interface/templates/report/premium_profile
begin
--   Manifest
--     ROW TEMPLATE: PREMIUM_PROFILE
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
 p_id=>wwv_flow_imp.id(4428722637200450)
,p_row_template_name=>'Premium Profile'
,p_internal_name=>'PREMIUM_PROFILE'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="bg-white rounded-xl border border-slate-200 shadow-sm hover:shadow-md transition-shadow p-6">',
'  <div class="flex justify-between items-start mb-4">',
'    <div>',
'      <span class="text-xs font-bold text-indigo-600 uppercase tracking-wider">Auto Tous Risques</span>',
'      <h3 class="text-lg font-bold text-slate-800">CTR-2024-00001</h3>',
'    </div>',
'    <span class="px-3 py-1 bg-emerald-100 text-emerald-700 text-xs font-bold rounded-full">ACTIF</span>',
'  </div>',
'  ',
'  <div class="space-y-3">',
'    <div>',
'      <div class="flex justify-between text-xs mb-1">',
unistr('        <span class="text-slate-500">Responsabilit\00E9 Civile</span>'),
'        <span class="font-semibold">100%</span>',
'      </div>',
'      <div class="w-full bg-slate-100 h-1.5 rounded-full">',
'        <div class="bg-indigo-500 h-1.5 rounded-full" style="width: 100%"></div>',
'      </div>',
'    </div>',
'  </div>',
'',
'  <div class="mt-6 pt-4 border-t border-slate-50 flex justify-between items-center">',
'    <span class="text-sm text-slate-500">Prime Annuelle</span>',
'    <span class="text-lg font-black text-slate-900">4 500,00 MAD</span>',
'  </div>',
'</div>'))
,p_row_template_before_rows=>'<div class="premium-dashboard-split">'
,p_row_template_after_rows=>'</div>'
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
