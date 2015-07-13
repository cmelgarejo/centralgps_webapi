defmodule CentralGPS.Repo.Client.RoadmapPointVenue.Commands do
  #DB Definition:
  def cmd_fn_api_roadmap_point_venue_create,
    do: "SELECT * FROM client.fn_api_roadmap_point_venue_create($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint, $8::bigint);"

  #DB Definition:
  def cmd_fn_api_roadmap_point_venue_delete,
    do: "SELECT * FROM client.fn_api_roadmap_point_venue_delete($1, $2, $3, $4, $5::jsonb, $6::bigint, $7::bigint);"

end
