defmodule CentralGPS.Repo.Checkpoint.Client.Commands do
  #DB Definition: checkpoint.fn_api_client_create (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, client_configuration_id, client_name, client_description, client_xtra_info) RETURNS common.return_type_generic
  #Input JSON: [ client_configuration_id, client_name, client_description, client_xtra_info ]
  def cmd_fn_api_client_create,
    do: "SELECT * FROM checkpoint.fn_api_client_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8, $9::jsonb);"

  #DB Definition: checkpoint.fn_api_client_read (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, client_id) RETURNS common.return_type_generic
  #Input JSON:[ :client_id ]
  def cmd_fn_api_client_read,
    do: "SELECT * FROM checkpoint.fn_api_client_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_client_update (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, client_id,  client_configuration_id, client_name, client_description, client_xtra_info) RETURNS common.return_type_generic
  #Input JSON: [ :client_id, client_configuration_id, client_name, client_description, client_xtra_info ]
  def cmd_fn_api_client_update,
    do: "SELECT * FROM checkpoint.fn_api_client_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8, $9, $10::jsonb);"

  #DB Definition: checkpoint.fn_api_client_delete (_auth_token, _my_auth_type, _the_app_name, _the_ip_port, _xtra_info, client_id) RETURNS common.return_type_generic
  #Input JSON: [ :client_id ]
  def cmd_fn_api_client_delete,
    do: "SELECT * FROM checkpoint.fn_api_client_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_client_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, _offset, _limit, search_column, search_phrase) RETURNS common.return_type_json_list
  def cmd_fn_api_client_list,
    do: "SELECT * FROM checkpoint.fn_api_client_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text);"

end
