defmodule CentralGPS.Repo.Checkpoint.Device.Commands do

  def cmd_fn_chkapi_device_register,
    do: "SELECT * FROM checkpoint.fn_chkapi_device_register ($1, $2, $3, $4, $5, $6::jsonb, $7, $8, $9::jsonb);"

  def cmd_fn_chkapi_action_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_action_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_reason_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_reason_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_venue_type_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_venue_type_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_venue_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_venue_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_near_venue_list,
    do: "SELECT *, st_distance(st_makepoint(lat,lon)::geography, st_makepoint($2::numeric(18,15), $3::numeric(18,15))::geography) as distance_to FROM checkpoint.fn_chkapi_venue_list($1::text) WHERE st_distance(st_makepoint(lat,lon)::geography, st_makepoint($2::numeric(18,15), $3::numeric(18,15))::geography) <= detection_radius"

  def cmd_fn_chkapi_register_position,
    do: "SELECT * FROM checkpoint.fn_chkapi_position_register($1::text,$2::text,$3::double precision,$4::bigint,$5::text,$6::double precision,$7::double precision,$8::text,$9::numeric(18,15),$10::numeric(18,15),$11::boolean,$12::timestamp without time zone,$13::bigint,$14::double precision, $15::bigint,$16::jsonb);"

end
