defmodule CentralGPS.Repo.Checkpoint.Item.Commands do
  #DB Definition: checkpoint.fn_api_item_create (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, item_configuration_id, item_name, item_description, item_notes, item_stock) RETURNS common.return_type_generic
  #Input JSON: [ item_configuration_id, item_name, item_description, item_xtra_info ]
  def cmd_fn_api_item_create,
    do: "SELECT * FROM checkpoint.fn_api_item_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8, $9, $10, $11::double precision, $12::double precision, $13::double precision, $14::jsonb);"

  #DB Definition: checkpoint.fn_api_item_read (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, item_id) RETURNS common.return_type_generic
  #Input JSON:[ :item_id ]
  def cmd_fn_api_item_read,
    do: "SELECT * FROM checkpoint.fn_api_item_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_item_update (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, item_configuration_id, item_name, item_description, item_notes, item_stock) RETURNS common.return_type_generic
  #Input JSON: [ :item_id, item_configuration_id, item_name, item_description, item_xtra_info ]
  def cmd_fn_api_item_update,
    do: "SELECT * FROM checkpoint.fn_api_item_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8, $9, $10, $11, $12::double precision, $13::double precision, $14::double precision, $15::jsonb);"

  #DB Definition: checkpoint.fn_api_item_delete (_auth_token, _my_auth_type, _the_app_name, _the_ip_port, _xtra_info, item_id) RETURNS common.return_type_generic
  #Input JSON: [ :item_id ]
  def cmd_fn_api_item_delete,
    do: "SELECT * FROM checkpoint.fn_api_item_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_item_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, _offset, _limit, search_column, search_phrase) RETURNS common.return_type_json_list
  def cmd_fn_api_item_list,
    do: "SELECT * FROM checkpoint.fn_api_item_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text);"

end
