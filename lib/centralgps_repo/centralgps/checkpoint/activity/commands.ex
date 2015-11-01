defmodule CentralGPS.Repo.Checkpoint.Activity.Commands do
  #DB Definition: checkpoint.fn_api_activity_create (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, activity_configuration_id, activity_description) RETURNS common.return_type_generic
  #Input JSON: [ :configuration_id, :description ]
  def cmd_fn_api_activity_create,
    do: "SELECT * FROM checkpoint.fn_api_activity_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8);"

  #DB Definition: checkpoint.fn_api_activity_read (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, activity_id) RETURNS common.return_type_generic
  #Input JSON:[ :activity_id ]
  def cmd_fn_api_activity_read,
    do: "SELECT * FROM checkpoint.fn_api_activity_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_activity_update (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, activity_id, activity_configuration_id, activity_description) RETURNS common.return_type_generic
  #Input JSON: [ :activity_id, :configuration_id, :description ]
  def cmd_fn_api_activity_update,
    do: "SELECT * FROM checkpoint.fn_api_activity_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8);"

  #DB Definition: checkpoint.fn_api_activity_delete (_auth_token text, _my_auth_type, _the_app_name text, _the_ip_port text, _xtra_info, activity_id) RETURNS common.return_type_generic
  #Input JSON: [ :activity_id, :activity_description ]
  def cmd_fn_api_activity_delete,
    do: "SELECT * FROM checkpoint.fn_api_activity_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_activity_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, _offset, _limit, search_column, search_phrase) RETURNS common.return_type_json_list
  def cmd_fn_api_activity_list,
    do: "SELECT * FROM checkpoint.fn_api_activity_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text);"

end
