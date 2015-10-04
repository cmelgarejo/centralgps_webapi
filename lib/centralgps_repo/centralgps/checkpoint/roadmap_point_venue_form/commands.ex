defmodule CentralGPS.Repo.Checkpoint.RoadmapPointVenueForm.Commands do
  #DB Definition:
  def cmd_fn_api_roadmap_point_venue_form_create,
    do: "SELECT * FROM checkpoint.fn_api_roadmap_point_venue_form_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::bigint, $9::bigint);"

  def cmd_fn_api_roadmap_point_venue_form_read,
    do: "SELECT * FROM checkpoint.fn_api_roadmap_point_venue_form_read($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  def cmd_fn_api_roadmap_point_venue_form_update,
      do: "SELECT * FROM checkpoint.fn_api_roadmap_point_venue_form_update($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::bigint, $9::bigint, $10::bigint);"

  #DB Definition:
  def cmd_fn_api_roadmap_point_venue_form_delete,
    do: "SELECT * FROM checkpoint.fn_api_roadmap_point_venue_form_delete($1, $2, $3, $4, $5::jsonb, $6::bigint);"

  def cmd_fn_api_roadmap_point_venue_form_list,
    do: "SELECT * FROM checkpoint.fn_api_roadmap_point_venue_form_list($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::text, $9::text, $10::text, $11::text);"

end
