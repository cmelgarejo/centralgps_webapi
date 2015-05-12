defmodule CentralGPS.Repo.Checkpoint.Action.Commands do
  #DB Definition: checkpoint.fn_api_action_create (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, action_configuration_id, action_description) RETURNS common.return_type_generic
  #Input JSON: [ :configuration_id, :description ]
  def cmd_fn_api_action_create,
    do: "SELECT * FROM checkpoint.fn_api_action_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7);"

  #DB Definition: checkpoint.fn_api_action_read (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, action_id) RETURNS common.return_type_generic
  #Input JSON:[ "action_id" ]
  def cmd_fn_api_action_read,
    do: "SELECT * FROM checkpoint.fn_api_action_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_action_create (_auth_token text, _auth_type, _the_app_name, _the_ip_port, _xtra_info, action_id, action_description) RETURNS common.return_type_generic
  #Input JSON: [ :action_id ]
  def cmd_fn_api_action_update,
    do: "SELECT * FROM checkpoint.fn_api_action_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7);"

  #DB Definition: checkpoint.fn_api_action_delete (_auth_token text, _auth_type, _the_app_name text, _the_ip_port text, _xtra_info, action_id) RETURNS common.return_type_generic
  #Input JSON: [ :action_id,]
  def cmd_fn_api_action_delete,
    do: "SELECT * FROM checkpoint.fn_api_action_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_action_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, _offset, _limit) RETURNS common.return_type_json_list
  #Input JSON: [ "_auth_type" ]
  def cmd_fn_api_action_list,
    do: "SELECT * FROM checkpoint.fn_api_action_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint);"

end
