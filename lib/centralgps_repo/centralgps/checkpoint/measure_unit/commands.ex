defmodule CentralGPS.Repo.Checkpoint.MeasureUnit.Commands do
  #DB Definition: checkpoint.fn_api_measure_unit_create (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, measure_unit_configuration_id, measure_unit_name, measure_unit_notes) RETURNS common.return_type_generic
  #Input JSON: [ measure_unit_configuration_id, measure_unit_name, measure_unit_description, measure_unit_notes ]
  def cmd_fn_api_measure_unit_create,
    do: "SELECT * FROM checkpoint.fn_api_measure_unit_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8);"

  #DB Definition: checkpoint.fn_api_measure_unit_read (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, measure_unit_id) RETURNS common.return_type_generic
  #Input JSON:[ :measure_unit_id ]
  def cmd_fn_api_measure_unit_read,
    do: "SELECT * FROM checkpoint.fn_api_measure_unit_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_measure_unit_update (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, measure_unit_id, measure_unit_configuration_id, measure_unit_name, measure_unit_notes) RETURNS common.return_type_generic
  #Input JSON: [ :measure_unit_id, measure_unit_configuration_id, measure_unit_name, measure_unit_notes ]
  def cmd_fn_api_measure_unit_update,
    do: "SELECT * FROM checkpoint.fn_api_measure_unit_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8, $9);"

  #DB Definition: checkpoint.fn_api_measure_unit_delete (_auth_token, _my_auth_type, _the_app_name, _the_ip_port, _xtra_info, measure_unit_id) RETURNS common.return_type_generic
  #Input JSON: [ :measure_unit_id ]
  def cmd_fn_api_measure_unit_delete,
    do: "SELECT * FROM checkpoint.fn_api_measure_unit_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_measure_unit_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, _offset, _limit, search_column, search_phrase) RETURNS common.return_type_json_list
  def cmd_fn_api_measure_unit_list,
    do: "SELECT * FROM checkpoint.fn_api_measure_unit_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text);"

end
