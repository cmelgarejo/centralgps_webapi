defmodule CentralGPS.Repo.Client.Roadmap.Commands do
  #DB Definition: FUNCTION client.fn_api_roadmap_create (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,
  #roadmap_name, roadmap_description, roadmap_notes, roadmap_one_time_date, roadmap_interval, roadmap_days_of_week,
  #roadmap_months_of_year, roadmap_days_of_month, roadmap_recurs_every, roadmap_start_time time, roadmap_end_time time,
  #roadmap_public, roadmap_active, roadmap_xtra_info)
  def cmd_fn_api_roadmap_create,
    do: "SELECT * FROM client.fn_api_roadmap_create($1, $2, $3, $4, $5::jsonb, $6, $7, $8, $9::timestamp without time zone, $10::char, $11::integer[], $12::integer[], $13::integer[], $14::integer, $15::time, $16::time, $17::jsonb);"

  #DB Definition: FUNCTION client.fn_api_roadmap_read (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,
  # roadmap_id)
  def cmd_fn_api_roadmap_read,
    do: "SELECT * FROM client.fn_api_roadmap_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: FUNCTION client.fn_api_roadmap_create (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,
  #roadmap_id, roadmap_name, roadmap_description, roadmap_notes, roadmap_one_time_date, roadmap_interval, roadmap_days_of_week,
  #roadmap_months_of_year, roadmap_days_of_month, roadmap_recurs_every, roadmap_start_time time, roadmap_end_time time,
  #roadmap_public, roadmap_active, roadmap_xtra_info)
  def cmd_fn_api_roadmap_update,
    do: "SELECT * FROM client.fn_api_roadmap_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8, $9, $10::timestamp without time zone, $11::char, $12::integer[], $13::integer[], $14::integer[], $15::integer, $16::time, $17::time, $18::jsonb);"

  #DB Definition: FUNCTION client.fn_api_roadmap_delete (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, roadmap_id)
  def cmd_fn_api_roadmap_delete,
    do: "SELECT * FROM client.fn_api_roadmap_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: FUNCTION client.fn_api_roadmap_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,
  # _limit, _offset, _search_column, _search_phrase, _sort_column, _sort_order)
  def cmd_fn_api_roadmap_list,
    do: "SELECT * FROM client.fn_api_roadmap_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8, $9, $10, $11);"

end
