defmodule CentralGPS.Repo.Client.RoadmapPoint.Commands do
  #DB Definition: client.fn_api_roadmap_point_create (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,
  # roadmap_point_roadmap_id, roadmap_point_name, roadmap_point_description, roadmap_point_notes, roadmap_point_lat, roadmap_point_lon,
  # roadmap_point_order, roadmap_point_mean_arrival_time time, roadmap_point_mean_leave_time time,
  # roadmap_point_detection_radius, roadmap_point_active boolean, roadmap_point_xtra_info)
  def cmd_fn_api_roadmap_point_create,
    do: "SELECT * FROM client.fn_api_roadmap_point_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7, $8, $9, $10::double precision, $11::double precision, $12::integer, $13::time, $14::time, $15::integer, $16::boolean, $17::jsonb, $18::bigint, $19::bigint);"

  #DB Definition: FUNCTION client.fn_api_roadmap_point_read (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,
  # roadmap_point_id, roadmap_point_roadmap_id)
  def cmd_fn_api_roadmap_point_read,
    do: "SELECT * FROM client.fn_api_roadmap_point_read($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint);"

  #DB Definition: FUNCTION client.fn_api_roadmap_point_update (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,
  # roadmap_point_id, roadmap_point_roadmap_id, roadmap_point_name, roadmap_point_description, roadmap_point_notes, roadmap_point_lat, roadmap_point_lon,
  # roadmap_point_order, roadmap_point_mean_arrival_time time, roadmap_point_mean_leave_time time,
  # roadmap_point_detection_radius, roadmap_point_active boolean, roadmap_point_xtra_info)
  def cmd_fn_api_roadmap_point_update,
    do: "SELECT * FROM client.fn_api_roadmap_point_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8, $9, $10, $11::double precision, $12::double precision, $13::integer, $14::time, $15::time, $16::integer, $17::boolean, $18::jsonb, $19::bigint, $20::bigint, $21::bigint);"

  def cmd_fn_api_roadmap_point_update_point_order,
    do: "SELECT * FROM client.fn_api_roadmap_point_update_point_order($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::boolean);"

  #DB Definition: FUNCTION client.fn_api_roadmap_point_delete (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,
  # roadmap_point_id, roadmap_point_roadmap_id)
  def cmd_fn_api_roadmap_point_delete,
    do: "SELECT * FROM client.fn_api_roadmap_point_delete($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint);"

  #DB Definition: FUNCTION client.fn_api_roadmap_point_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info,
  # _limit, _offset, _search_column, _search_phrase, _sort_column, _sort_order, roadmap_point_roadmap_id)
  def cmd_fn_api_roadmap_point_list,
    do: "SELECT * FROM client.fn_api_roadmap_point_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8, $9, $10, $11, $12::bigint);"

end
