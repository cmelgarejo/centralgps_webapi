defmodule CentralGPS.Repo.Checkpoint.ClientContact.Commands do
  #DB Definition: checkpoint.fn_api_client_contact_create (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info jsonb, client_contact_client_id, client_contact_name, client_contact_notes, client_contact_emails, client_contact_phones, client_contact_notify) RETURNS common.return_type_generic
  #Input JSON: [ client_contact_client_id, client_contact_name, client_contact_notes, client_contact_emails, client_contact_phones, client_contact_notify ]
  def cmd_fn_api_client_contact_create,
    do: "SELECT * FROM checkpoint.fn_api_client_contact_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8, $9, $10, $11, $12::boolean, $13, $14::bytea);"

  #DB Definition: checkpoint.fn_api_client_contact_read (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, client_contact_id) RETURNS common.return_type_generic
  #Input JSON:[ :client_contact_id ]
  def cmd_fn_api_client_contact_read,
    do: "SELECT * FROM checkpoint.fn_api_client_contact_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_client_contact_update (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info jsonb, client_contact_client_id, client_contact_name, client_contact_notes, client_contact_emails, client_contact_phones, client_contact_notify) RETURNS common.return_type_generic
  #Input JSON: [ client_contact_client_id, client_contact_name, client_contact_notes, client_contact_emails, client_contact_phones, client_contact_notify ]
  def cmd_fn_api_client_contact_update,
    do: "SELECT * FROM checkpoint.fn_api_client_contact_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8, $9, $10, $11, $12, $13::boolean, $14, $15::bytea);"

  #DB Definition: checkpoint.fn_api_client_contact_delete (_auth_token, _my_auth_type, _the_app_name, _the_ip_port, _xtra_info, client_contact_id) RETURNS common.return_type_generic
  #Input JSON: [ :client_contact_id ]
  def cmd_fn_api_client_contact_delete,
    do: "SELECT * FROM checkpoint.fn_api_client_contact_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_client_contact_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, _offset, _limit, search_column, search_phrase, client_contact_client_id) RETURNS common.return_type_json_list
  def cmd_fn_api_client_contact_list,
    do: "SELECT * FROM checkpoint.fn_api_client_contact_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text, $12::bigint);"

end
