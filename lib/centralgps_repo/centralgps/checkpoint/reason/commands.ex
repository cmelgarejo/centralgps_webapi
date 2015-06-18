defmodule CentralGPS.Repo.Checkpoint.Reason.Commands do
  #DB Definition: checkpoint.fn_api_reason_create (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, reason_configuration_id, reason_description) RETURNS common.return_type_generic
  #Input JSON: [ :configuration_id, :description ]
  def cmd_fn_api_reason_create,
    do: "SELECT * FROM checkpoint.fn_api_reason_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8);"

  #DB Definition: checkpoint.fn_api_reason_read (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, reason_id) RETURNS common.return_type_generic
  #Input JSON:[ :reason_id ]
  def cmd_fn_api_reason_read,
    do: "SELECT * FROM checkpoint.fn_api_reason_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_reason_create (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, reason_id, reason_description) RETURNS common.return_type_generic
  #Input JSON: [ :reason_id ]
  def cmd_fn_api_reason_update,
    do: "SELECT * FROM checkpoint.fn_api_reason_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8);"

  #DB Definition: checkpoint.fn_api_reason_delete (_auth_token text, _my_auth_type, _the_app_name text, _the_ip_port text, _xtra_info, reason_id) RETURNS common.return_type_generic
  #Input JSON: [ :reason_id, :reason_description ]
  def cmd_fn_api_reason_delete,
    do: "SELECT * FROM checkpoint.fn_api_reason_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_reason_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, _offset, _limit, search_column, search_phrase) RETURNS common.return_type_json_list
  def cmd_fn_api_reason_list,
    do: "SELECT * FROM checkpoint.fn_api_reason_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text);"

end
