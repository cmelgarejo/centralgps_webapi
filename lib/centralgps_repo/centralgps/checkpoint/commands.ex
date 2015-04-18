defmodule CentralGPS.Repo.Checkpoint.Commands do

  def cmd_fn_register_device,
    do: "SELECT * FROM checkpoint.fn_register_device ($1, $2, $3, $4, $5, $6::jsonb, $7, $8, $9::jsonb);"

  def cmd_fn_get_actions_by_auth_token,
    do: "SELECT * FROM checkpoint.fn_get_actions_by_auth_token($1::text, $2::text, $3::char);"

  def cmd_fn_get_reasons_by_auth_token,
    do: "SELECT * FROM checkpoint.fn_get_reasons_by_auth_token($1::text, $2::text, $3::char);"

  def cmd_fn_get_venue_types_by_auth_token,
    do: "SELECT * FROM checkpoint.fn_get_venue_types_by_auth_token($1::text, $2::text, $3::char);"

  def cmd_fn_get_all_venues_by_auth_token,
    do: "SELECT * FROM checkpoint.fn_get_venues_by_auth_token($1::text, $2::text, $3::char);"

  def cmd_fn_get_near_venues_by_auth_token,
    do: "SELECT *, st_distance(st_makepoint(lat,lon)::geography, st_makepoint($2::numeric(18,15), $3::numeric(18,15))::geography) as distance_to FROM checkpoint.fn_get_venues_by_auth_token($1::text) WHERE st_distance(st_makepoint(lat,lon)::geography, st_makepoint($2::numeric(18,15), $3::numeric(18,15))::geography) <= detection_radius"

  def cmd_fn_register_position,
    do: "SELECT * FROM checkpoint.fn_register_position($1::text,$2::text,$3::double precision,$4::bigint,$5::text,$6::double precision,$7::double precision,$8::text,$9::numeric(18,15),$10::numeric(18,15),$11::boolean,$12::timestamp without time zone,$13::bigint,$14::double precision, $15::bigint,$16::jsonb);"

end
