defmodule CentralGPS.Repo.Checkpoint.FormTemplate.Commands do
  #DB Definition: checkpoint.fn_api_form_template_create (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, template_form_id, template_activity_id, template_item_id, template_measure_unit_id) RETURNS common.return_type_generic
  #Input JSON: [ :template_form_id, :template_activity_id, :template_item_id, :template_measure_unit_id ]
  def cmd_fn_api_form_template_create,
    do: "SELECT * FROM checkpoint.fn_api_form_template_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::bigint, $9::bigint);"

  #DB Definition: checkpoint.fn_api_form_template_read (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, form_template_id) RETURNS common.return_type_generic
  #Input JSON:[ :form_template_id ]
  def cmd_fn_api_form_template_read,
    do: "SELECT * FROM checkpoint.fn_api_form_template_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_form_template_update (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, form_template_id, template_form_id, template_activity_id, template_item_id, template_measure_unit_id) RETURNS common.return_type_generic
  #Input JSON: [ :form_template_id, :template_form_id, :template_activity_id, :template_item_id, :template_measure_unit_id ]
  def cmd_fn_api_form_template_update,
    do: "SELECT * FROM checkpoint.fn_api_form_template_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::bigint, $9::bigint, $10::bigint);"

  #DB Definition: checkpoint.fn_api_form_template_delete (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, form_template_id, form_template_remove_item) RETURNS common.return_type_generic
  #Input JSON: [ :form_template_id,]
  def cmd_fn_api_form_template_delete,
    do: "SELECT * FROM checkpoint.fn_api_form_template_delete($1, $2, $3, $4, $5::jsonb, $6::bigint, $6::boolean);"

  #DB Definition: checkpoint.fn_api_form_template_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, _offset, _limit, search_column, search_phrase) RETURNS common.return_type_json_list
  #Input JSON: [ :_auth_type ]
  def cmd_fn_api_form_template_list,
    do: "SELECT * FROM checkpoint.fn_api_form_template_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text);"

  def cmd_fn_api_form_template_list_items,
    do: "SELECT * FROM checkpoint.fn_api_form_template_list_items($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text, $12::bigint, $13::bigint);"

end
