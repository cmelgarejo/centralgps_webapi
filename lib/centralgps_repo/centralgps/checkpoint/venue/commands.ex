defmodule CentralGPS.Repo.Checkpoint.Venue.Commands do
  #DB Definition: checkpoint.fn_api_venue_create (text,text,text,text,jsonb,bigint,bigint,bigint,text,text,text,text,text,bytea,double precision,double precision,integer,boolean,jsonb)
  #Input JSON: [ :configuration_id, :venue_type_id, :name, :code, :description, :image, :lat, :lon, :detection_radius, :active = TRUE /*always*/, :xtra_info ]
  def cmd_fn_api_venue_create,
    do: "SELECT * FROM checkpoint.fn_api_venue_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::bigint, $9, $10, $11, $12, $13, $14::bytea, $15::double precision, $16::double precision, $17::integer, $18::boolean, $19::jsonb);"

  #DB Definition: checkpoint.fn_api_venue_read (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, venue_type_id) RETURNS common.return_type_generic
  #Input JSON:[ "venue_type_id", "account_type"]
  def cmd_fn_api_venue_read,
    do: "SELECT * FROM checkpoint.fn_api_venue_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_venue_update (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, venue_code, venue_configuration_id, venue_description, venue_detection_radius, venue_id, venue_image, venue_lat, venue_lon, venue_name, venue_type_id, venue_xtra_info)
  #Input JSON: [ :venue_id, :configuration_id, :venue_type_id, :name, :code, :description, :image, :lat, :lon, :detection_radius, :xtra_info ]
  def cmd_fn_api_venue_update,
    do: "SELECT * FROM checkpoint.fn_api_venue_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::bigint, $9:bigint, $10, $11, $12, $13, $14, $15::bytea, $16::double precision, $17::double precision, $18::integer, $19::boolean, $20::jsonb);"

  #DB Definition: checkpoint.fn_api_venue_delete (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, venue_type_id) RETURNS common.return_type_generic
  #Input JSON: [ "venue_type_id" ]
  def cmd_fn_api_venue_delete,
    do: "SELECT * FROM checkpoint.fn_api_venue_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  #DB Definition: checkpoint.fn_api_venue_list (_auth_token, _auth_type, _the_app_name, _the_ip_port, _xtra_info, _offset, _limit, search_column, search_phrase) RETURNS common.return_type_json_list
  #Input JSON: [ :_auth_type ]
  def cmd_fn_api_venue_list,
    do: "SELECT * FROM checkpoint.fn_api_venue_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8, $9, $10, $11);"

end
