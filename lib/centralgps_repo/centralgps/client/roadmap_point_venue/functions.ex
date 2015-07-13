defmodule CentralGPS.Repo.Client.RoadmapPointVenue.Functions do
  import CentralGPS.Repo
    import CentralGPS.Repo.Client.RoadmapPointVenue.Commands
  require Logger

  def fn_api_roadmap_point_venue_create(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_point_venue_create, _params, filter_keys)
    {row_count, hd(result)}
  end

  def fn_api_roadmap_point_venue_delete(_params, filter_keys \\ []) do
    {row_count, result} = query(cmd_fn_api_roadmap_point_venue_delete, _params, filter_keys)
    {row_count, hd(result)}
  end

end
