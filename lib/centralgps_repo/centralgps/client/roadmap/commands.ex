defmodule CentralGPS.Repo.Client.Roadmap.Commands do
  #DB Definition: FUNCTION client.fn_api_roadmap_create (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,
  # roadmap_name, roadmap_description, roadmap_days_of_week, roadmap_repetition, roadmap_one_time_date,
  # roadmap_start_time, roadmap_end_time, roadmap_public, roadmap_active, roadmap_xtra_info)
  def cmd_fn_api_roadmap_create,
    do: "SELECT * FROM client.fn_api_roadmap_create($1, $2, $3, $4, $5::jsonb, $6, $7, $8::integer[], $9::integer, $10::date, $11::time, $12::time, $13::boolean, $14::boolean, $15::jsonb);"

  #DB Definition: FUNCTION client.fn_api_roadmap_read (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,
  # roadmap_id)
  def cmd_fn_api_roadmap_read,
    do: "SELECT * FROM client.fn_api_roadmap_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: FUNCTION client.fn_api_roadmap_update (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,
  # roadmap_id, roadmap_name, roadmap_description, roadmap_days_of_week, roadmap_repetition, roadmap_one_time_date,
  # roadmap_start_time, roadmap_end_time, roadmap_active, roadmap_xtra_info)
  def cmd_fn_api_roadmap_update,
    do: "SELECT * FROM client.fn_api_roadmap_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8, $9::integer[], $10::integer, $11::date, $12::time, $13::time, $14::boolean, $15::boolean, $16::jsonb);"

  #DB Definition: FUNCTION client.fn_api_roadmap_delete (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, roadmap_id)
  def cmd_fn_api_roadmap_delete,
    do: "SELECT * FROM client.fn_api_roadmap_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: FUNCTION client.fn_api_roadmap_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,
  # _limit, _offset, _search_column, _search_phrase, _sort_column, _sort_order)
  def cmd_fn_api_roadmap_list,
    do: "SELECT * FROM client.fn_api_roadmap_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8, $9, $10, $11);"

end
