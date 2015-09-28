defmodule CentralGPS.Repo.Checkpoint.Form.Commands do
  #DB Definition: checkpoint.fn_api_form_create (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, form_configuration_id, form_description) RETURNS common.return_type_generic
  #Input JSON: [ :configuration_id, :description ]
  def cmd_fn_api_form_create,
    do: "SELECT * FROM checkpoint.fn_api_form_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7);"

  #DB Definition: checkpoint.fn_api_form_read (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, form_id) RETURNS common.return_type_generic
  #Input JSON:[ :form_id ]
  def cmd_fn_api_form_read,
    do: "SELECT * FROM checkpoint.fn_api_form_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_form_create (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, form_id, form_configuration_id, form_description) RETURNS common.return_type_generic
  #Input JSON: [ :form_id, :configuration_id, :description ]
  def cmd_fn_api_form_update,
    do: "SELECT * FROM checkpoint.fn_api_form_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8);"

  #DB Definition: checkpoint.fn_api_form_delete (_auth_token text, _auth_type, _the_app_name text, _the_ip_port text, _xtra_info, form_id) RETURNS common.return_type_generic
  #Input JSON: [ :form_id,]
  def cmd_fn_api_form_delete,
    do: "SELECT * FROM checkpoint.fn_api_form_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_form_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, _offset, _limit, search_column, search_phrase) RETURNS common.return_type_json_list
  #Input JSON: [ :_auth_type ]
  def cmd_fn_api_form_list,
    do: "SELECT * FROM checkpoint.fn_api_form_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text);"

end
