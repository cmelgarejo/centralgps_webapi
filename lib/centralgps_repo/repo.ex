defmodule CentralGPS.Repo do
  use Ecto.Repo, otp_app: :centralgps_webapi
  import CentralGPS.Repo.Utilities

  @doc """
  Executes a Ecto.Adapters.SQL, gets results and makes LIST of MAP with atomic
  keys for each row returned

  Parameters:

  cmd   : The command text to execute
  params: A List [] of parameters to be used by the cmd
  filter: (optional) see docs of objectify_map
  keys  : (optional) see docs of objectify_map

  returns tuple: {:row_count, :list_of_objects }
  """
  def query(cmd, params, filter \\ []) do
    #try do
      table_to_map Ecto.Adapters.SQL.query(CentralGPS.Repo, cmd, params), filter
    #rescue
    #  e in _ ->
    #    vars = %{cmd: cmd, params: params, filter: filter}
    #    error_logger e, __ENV__, vars
    #    raise e
    #end
  end

end
