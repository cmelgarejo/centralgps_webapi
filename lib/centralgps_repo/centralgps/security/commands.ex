defmodule CentralGPS.Repo.Security.Commands do
  #DB Definition: security.fn_api_login (_login_user text, _password text, _auth_type char, _session_status boolean, _the_app_name text, _the_ip_port text, _xtra_info jsonb) RETURNS security.record_type_login
  #Input JSON: _k = [ :_login_user, :_password, :auth_type, :session_status ]
  def cmd_fn_api_login,
    do: "SELECT status, msg, res FROM security.fn_api_login ($1, $2, $3, $4::boolean, $5, $6, $7::jsonb);"

  #DB Definition: security.fn_api_account_active (_auth_token text, _auth_type, _the_app_name text, _the_ip_port text, _xtra_info jsonb account_id bigint account_type text set_active boolean) RETURNS common.return_type_generic
  #Input JSON order: [ "_auth_token", "_auth_type", "_the_app_name", "_the_ip_port", "_xtra_info", "account_id", "account_type", "set_active" ]
  def cmd_fn_api_account_active,
    do: "SELECT * FROM security.fn_api_account_active($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8::boolean);"

  #DB Definition: security.fn_api_account_create (_auth_token text, _auth_type, _the_app_name text, _the_ip_port text, _xtra_info jsonb account_type text user__login_name text user__login_password text user_dob date user_identity_document text user_info_emails text user_info_phones text user_language_template_id bigint user_name text user_profile_image text user_timezone real user_xtra_info jsonb)	RETURNS common.return_type_generic
  #Input JSON: [ "_auth_token", "_auth_type", "account_type", "client_id", "user__login_name", "user__login_password", "user_dob", "user_identity_document", "user_info_emails", "user_info_phones", "user_language_template_id", "user_name", "user_profile_image", "user_timezone", "user_xtra_info" ]
  def cmd_fn_api_account_create,
    do: "SELECT * FROM security.fn_api_account_create($1, $2, $3, $4, $5::jsonb, $6, $7::bigint, $8, $9, $10::date, $11, $12, $13, $14::bigint, $15, $16, $17::real, $18::jsonb);"

  #DB Definition: security.fn_api_account_read (_auth_token text, _auth_type, _the_app_name text, _the_ip_port text, _xtra_info jsonb account_id bigint account_type text) RETURNS common.return_type_json_result
  #Input JSON:["_auth_token", "_auth_type", "account_id", "account_type"]
  def cmd_fn_api_account_read,
    do: "SELECT * FROM security.fn_api_account_read($1, $2, $3, $4, $5::jsonb, $6::bigint, $7);"

  #DB Definition: security.fn_api_account_update (_auth_token text, _auth_type, _the_app_name text, _the_ip_port text, _xtra_info jsonb account_id bigint account_type text user__login_password text user_dob date user_identity_document text user_info_emails text user_info_phones text user_language_template_id bigint user_name text user_profile_image text user_timezone real user_xtra_info jsonb) RETURNS common.return_type_generic
  #Input JSON: [ "_auth_token", "_auth_type", "_the_app_name", "_the_ip_port", "_xtra_info", "account_id", "account_type", "user__login_password", "user_dob", "user_identity_document", "user_info_emails", "user_info_phones", "user_language_template_id", "user_name", "user_profile_image", "user_timezone", "user_xtra_info" ]
  def cmd_fn_api_account_update,
    do: "SELECT * FROM security.fn_api_account_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8, $9::date, $10, $11, $12, $13::bigint, $14, $15, $16::real, $17::jsonb);"

  #DB Definition: security.fn_api_account_delete (_auth_token text, _auth_type, _the_app_name text, _the_ip_port text, _xtra_info jsonb account_id bigint account_type text) RETURNS common.return_type_generic
  #Input JSON: [ "_auth_token", "_auth_type", "account_id", "account_type" ]
  def cmd_fn_api_account_delete,
    do: "SELECT * FROM security.fn_api_account_delete($1, $2, $3, $4, $5::jsonb, $6::bigint, $7);"

  #DB Definition: security.fn_api_account_list (_auth_token text, _auth_type, _the_account_type text, _the_app_name text, _the_ip_port text, _xtra_info jsonb) RETURNS common.return_type_json_list
  #Input JSON: [ "_auth_token", "_auth_type", "_the_account_type" ]
  def cmd_fn_api_account_list,
    do: "SELECT * FROM security.fn_api_account_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint);"

  #DB Definition: security.fn_api_account_role_create (_auth_token text, _auth_type, _the_app_name text, _the_ip_port text, _xtra_info jsonb account_id bigint account_type text role_id bigint) RETURNS common.return_type_generic
  #Input JSON: [ "_auth_token", "_auth_type", "account_id", "account_type", "role_id" ]
  def cmd_fn_api_account_role_create,
    do: "SELECT * FROM security.fn_api_account_role_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8::bigint);"

  #DB Definition: security.fn_api_account_role_delete (_auth_token text, _auth_type, _the_app_name text, _the_ip_port text, _xtra_info jsonb account_id bigint account_type text role_id bigint) RETURNS common.return_type_generic
  #Input JSON: [ "_auth_token", "_auth_type", "account_id", "account_type", "role_id" ]
  def cmd_fn_api_account_role_delete,
    do: "SELECT * FROM security.fn_api_account_role_delete($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8::bigint);"

  #DB Definition: security.fn_api_account_permission_create (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,ar_account_id, ar_account_type, ar_permission_code) RETURNS common.return_type_generic
  #Input JSON: [ "_auth_token", "_auth_type", "account_id", "account_type", "code" ]
  def cmd_fn_api_account_permission_create,
    do: "SELECT * FROM security.fn_api_account_permission_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8);"

  #DB Definition: security.fn_api_account_permission_delete (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, ar_account_id, ar_account_type, ar_permission_code) RETURNS common.return_type_generic
  #Input JSON: [ "_auth_token", "_auth_type", "account_id", "account_type", "code" ]
  def cmd_fn_api_account_permission_delete,
    do: "SELECT * FROM security.fn_api_account_permission_delete($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8);"

end
