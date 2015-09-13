defmodule CentralGPS.Repo.Checkpoint.Device.Commands do

  def cmd_fn_chkapi_device_register,
    do: "SELECT * FROM checkpoint.fn_chkapi_device_register($1, $2, $3, $4, $5, $6::jsonb, $7, $8, $9::jsonb);"

  def cmd_fn_chkapi_activity_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_activity_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_reason_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_reason_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_venue_type_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_venue_type_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_venue_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_venue_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_near_venue_list,
    do: "SELECT *, st_distance(st_makepoint(lat,lon)::geography, st_makepoint($2::double precision, $3::double precision)::geography) as distance_to FROM checkpoint.fn_chkapi_venue_list($1::text) WHERE st_distance(st_makepoint(lat,lon)::geography, st_makepoint($2::double precision, $3::double precision)::geography) <= detection_radius"

  def cmd_fn_chkapi_register_position,
    do: "SELECT * FROM checkpoint.fn_chkapi_position_register($1::text,$2::text,$3::double precision,$4::bigint,$5::text,$6::double precision,$7::double precision,$8::text,$9::double precision,$10::double precision,$11::boolean,$12::timestamp without time zone,$13::bigint, $14::double precision, $15, $16::bigint, $17::jsonb);"

  def cmd_fn_chkapi_venue_create,
    do: "SELECT * FROM checkpoint.fn_api_venue_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8, $9, $10, $11, $12::double precision, $13::double precision, $14::integer, $15::boolean);"

end
