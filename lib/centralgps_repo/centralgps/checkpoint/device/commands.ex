defmodule CentralGPS.Repo.Checkpoint.Device.Commands do

  def cmd_fn_chkapi_device_register,
    do: "SELECT * FROM checkpoint.fn_chkapi_device_register($1::text, $2::text, $3::text, $4::text, $5::text, $6::jsonb, $7::text, $8::text, $9::jsonb);"

  def cmd_fn_chkapi_record,
    do: "SELECT * FROM checkpoint.fn_chkapi_record($1::text, $2::double precision, $3::double precision, $4::double precision, $5::double precision, $6::double precision, $7::double precision, $8::text, $9::text, $10::text, $11::timestamp without time zone, $12::jsonb);"

  #Mark(ing) CRUDs
  def cmd_fn_chkapi_mark_insert,
    do: "SELECT * FROM checkpoint.fn_chkapi_mark_insert($1::text, $2::text, $3::bigint, $4::bigint, $5::double precision, $6::double precision, $7::double precision, $8::double precision, $9::text, $10::text, $11::timestamp without time zone, $12::timestamp without time zone, $13::timestamp without time zone);"

  def cmd_fn_chkapi_mark_update,
    do: "SELECT * FROM checkpoint.fn_chkapi_mark_update($1::text, $2::text, $3::bigint, $4::bigint, $5::double precision, $6::double precision, $7::double precision, $8::double precision, $9::text, $10::text, $11::timestamp without time zone, $12::timestamp without time zone, $13::timestamp without time zone);"

  def cmd_fn_chkapi_mark_delete,
    do: "SELECT * FROM checkpoint.fn_chkapi_mark_delete($1::text, $2::text);"

  def cmd_fn_chkapi_mark_activity_insert,
    do: "SELECT * FROM checkpoint.fn_chkapi_mark_activity_insert($1::text, $2::bigint, $4::text, $5::bigint, $6::text, $7::timestamp without time zone, $8::timestamp without time zone, $9::jsonb);"

  def cmd_fn_chkapi_mark_activity_update,
    do: "SELECT * FROM checkpoint.fn_chkapi_mark_activity_update($1::text, $2::bigint, $4::text, $5::bigint, $6::text, $7::timestamp without time zone, $8::timestamp without time zone, $9::jsonb);"

  def cmd_fn_chkapi_mark_activity_delete,
    do: "SELECT * FROM checkpoint.fn_chkapi_mark_activity_delete($1::text, $2::bigint, $3::text);"

  def cmd_fn_chkapi_mark_activity_item_insert,
    do: "SELECT * FROM checkpoint.fn_chkapi_mark_activity_item_insert($1::text, $2::bigint, $3::bigint, $4::text, $5::bigint, $6::bigint, $7::double precision);"

  def cmd_fn_chkapi_mark_activity_item_update,
    do: "SELECT * FROM checkpoint.fn_chkapi_mark_activity_item_update($1::text, $2::bigint, $3::bigint, $4::text, $5::bigint, $6::bigint, $7::double precision);"

  def cmd_fn_chkapi_mark_activity_item_delete,
    do: "SELECT * FROM checkpoint.fn_chkapi_mark_activity_item_delete($1::text, $2::bigint, $3::bigint, $4::text);"

  def cmd_fn_chkapi_mark_activity_image_insert,
    do: "SELECT * FROM checkpoint.fn_chkapi_mark_activity_image_insert($1::text, $2::bigint, $3::text, $4::text, $5::bytea, $6::timestamp without time zone);"

  def cmd_fn_chkapi_mark_activity_image_update,
    do: "SELECT * FROM checkpoint.fn_chkapi_mark_activity_image_update($1::text, $2::bigint, $3::text, $4::text, $5::bytea, $6::timestamp without time zone);"

  def cmd_fn_chkapi_mark_activity_image_delete,
    do: "SELECT * FROM checkpoint.fn_chkapi_mark_activity_image_delete($1::text, $2::bigint, $3::bigint, $4::text);"

  #Venue creative mode
  def cmd_fn_chkapi_venue_create,
    do: "SELECT * FROM checkpoint.fn_api_venue_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8, $9, $10, $11, $12::double precision, $13::double precision, $14::integer, $15::boolean);"

  #Lists
  def cmd_fn_chkapi_roadmaps,
    do: "SELECT * FROM checkpoint.fn_chkapi_roadmaps($1::text, $2::timestamp without time zone);"

  def cmd_fn_chkapi_activity_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_activity_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_form_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_form_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_form_template_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_form_template_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_venue_type_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_venue_type_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_venue_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_venue_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_item_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_item_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_measure_item_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_measure_unit_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_client_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_item_list($1::text, $2::text, $3::char);"

  def cmd_fn_chkapi_client_contact_list,
    do: "SELECT * FROM checkpoint.fn_chkapi_item_list($1::text, $2::text, $3::char);"

  #Not implemented
  def cmd_fn_chkapi_near_venue_list,
    do: "SELECT *, st_distance(st_makepoint(lat,lon)::geography, st_makepoint($2::double precision, $3::double precision)::geography) as distance_to FROM checkpoint.fn_chkapi_venue_list($1::text) WHERE st_distance(st_makepoint(lat,lon)::geography, st_makepoint($2::double precision, $3::double precision)::geography) <= detection_radius"

end
