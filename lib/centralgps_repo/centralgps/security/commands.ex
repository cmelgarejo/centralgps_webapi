defmodule CentralGPS.Repo.Security.Commands do
  # DB Definition: security.fn_api_login (IN _login_user text, IN _password text, IN _my_account_type char DEFAULT 'C', IN _session_status boolean DEFAULT true, IN _the_app_name text DEFAULT 'no_app_name_provided', IN _the_ip_port text DEFAULT 'no_ipport_provided', IN _xtra_info jsonb DEFAULT NULL) RETURNS security.record_type_login
  # Input JSON: [ "_login_user", "_password", "my_account_type", "session_status", "the_app_name", "the_ip_port", "xtra_info" ]
  def cmd_fn_api_login,
    do: "SELECT success, message, auth_token, language_code, timezone, profile_image, name, xtra_info::jsonb FROM security.fn_api_login ($1, $2, $3, $4::boolean, $5, $6, $7::jsonb);"

  #DB Definition: security.fn_api_account_active (IN _auth_token text, IN _my_account_type text, IN _the_app_name text, IN _the_ip_port text, IN _xtra_info jsonb DEFAULT NULL, IN account_id bigint DEFAULT NULL, IN account_type text DEFAULT NULL, IN set_active boolean DEFAULT false) RETURNS common.return_type_generic
  #Input JSON order: [ "_auth_token", "_my_account_type", "_the_app_name", "_the_ip_port", "_xtra_info", "account_id", "account_type", "set_active" ]
  def cmd_fn_api_account_active,
    do: "SELECT * FROM security.fn_api_account_active($1, $2, $3, $4, $5::jsonb, $6, $7, $8::boolean);"

  #DB Definition: security.fn_api_account_create (IN _auth_token text, IN _my_account_type text, IN _the_app_name text, IN _the_ip_port text, IN _xtra_info jsonb DEFAULT NULL, IN account_type text DEFAULT NULL, IN user__login_name text DEFAULT NULL, IN user__login_password text DEFAULT NULL, IN user_dob date DEFAULT NULL, IN user_identity_document text DEFAULT NULL, IN user_info_emails text DEFAULT NULL, IN user_info_phones text DEFAULT NULL, IN user_language_template_id bigint DEFAULT NULL, IN user_name text DEFAULT NULL, IN user_profile_image text DEFAULT NULL, IN user_timezone real DEFAULT NULL, IN user_xtra_info jsonb DEFAULT NULL)	RETURNS common.return_type_generic
  # Input JSON: [ "_auth_token", "_my_account_type", "_the_app_name", "_the_ip_port", "_xtra_info",  "account_type", "user__login_name", "user__login_password", "user_dob", "user_identity_document", "user_info_emails", "user_info_phones", "user_language_template_id", "user_name", "user_profile_image", "user_timezone", "user_xtra_info" ]
  def cmd_fn_api_account_create,
    do: "SELECT * FROM security.fn_api_account_create($1, $2, $3, $4, $5::jsonb, $6, $7, $8, $9::date, $10, $11, $12, $13, $14, $15, $16::real, $17::jsonb);"

  #DB Definition: security.fn_api_account_read (IN _auth_token text, IN _my_account_type text, IN _the_app_name text, IN _the_ip_port text, IN _xtra_info jsonb DEFAULT NULL, IN account_id bigint DEFAULT NULL, IN account_type text DEFAULT NULL) RETURNS common.return_type_json_list
  #Input JSON: [ "_auth_token", "_my_account_type", "_the_app_name", "_the_ip_port", "_xtra_info", "account_id", "account_type" ]
  def cmd_fn_api_account_read,
    do: "SELECT * FROM security.fn_api_account_read($1, $2, $3, $4, $5::jsonb, $6::bigint, $7);"

  #DB Definition: security.fn_api_account_update (IN _auth_token text, IN _my_account_type text, IN _the_app_name text, IN _the_ip_port text, IN _xtra_info jsonb DEFAULT NULL, IN account_id bigint DEFAULT NULL, IN account_type text DEFAULT NULL, IN user__login_password text DEFAULT NULL, IN user_dob date DEFAULT NULL, IN user_identity_document text DEFAULT NULL, IN user_info_emails text DEFAULT NULL, IN user_info_phones text DEFAULT NULL, IN user_language_template_id bigint DEFAULT NULL, IN user_name text DEFAULT NULL, IN user_profile_image text DEFAULT NULL, IN user_timezone real DEFAULT NULL, IN user_xtra_info jsonb DEFAULT NULL) RETURNS common.return_type_generic
  # Input JSON: [ "_auth_token", "_my_account_type", "_the_app_name", "_the_ip_port", "_xtra_info", "account_id", "account_type", "user__login_password", "user_dob", "user_identity_document", "user_info_emails", "user_info_phones", "user_language_template_id", "user_name", "user_profile_image", "user_timezone", "user_xtra_info" ]
  def cmd_fn_api_account_update,
    do: "SELECT * FROM security.fn_api_account_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8, $9::date, $10, $11, $12, $13::bigint, $14, $15, $16::real, $17::jsonb);"

  #DB Definition: security.fn_api_account_delete (IN _auth_token text, IN _my_account_type text, IN _the_app_name text, IN _the_ip_port text, IN _xtra_info jsonb DEFAULT NULL, IN account_id bigint DEFAULT NULL, IN account_type text DEFAULT NULL) RETURNS common.return_type_generic
  #Input JSON: [ "_auth_token", "_my_account_type", "_the_app_name", "_the_ip_port", "_xtra_info", "account_id", "account_type" ]
  def cmd_fn_api_account_delete,
    do: "SELECT * FROM security.fn_api_account_delete($1, $2, $3, $4, $5::jsonb, $6::bigint, $7);"

  #DB Definition: security.fn_api_account_list (IN _auth_token text, IN _my_account_type text, IN _the_account_type text, IN _the_app_name text, IN _the_ip_port text, IN _xtra_info jsonb DEFAULT NULL) RETURNS common.return_type_json_list
  #Input JSON: [ "_auth_token", "_my_account_type", "_the_account_type", "_the_app_name", "_the_ip_port", "_xtra_info" ]
  def cmd_fn_api_account_list,
    do: "SELECT * FROM security.fn_api_account_list($1, $2, $3, $4, $5::jsonb);"

end
