defmodule CentralGPS.Repo.Security.Commands do
  # DB defined as:
  #   fn_login security.fn_login
  #   (IN _login_user text, IN _password text, IN _type char DEFAULT 'C',
  #    IN _session_status boolean DEFAULT false, IN _ip_port text DEFAULT 'IP',
  #    IN _app_name text DEFAULT 'APP', IN _xtra_info jsonb DEFAULT null::jsonb)
  # In Elixir list, the json comes as:
  # ["_login_user","_password","app_name","ip_port","status","type","xtra_info"]
  def cmd_fn_login,
    do: "SELECT success, auth_token, language_code, timezone, profile_image, name, xtra_info::jsonb FROM security.fn_login ($1, $2, $6, $5::boolean, $4, $3, $7::jsonb);"

  def cmd_fn_create_login_account,
    do: "SELECT * FROM security.fn_login ($1, $2, $3, $4, $5::jsonb, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15::jsonb);"

end
