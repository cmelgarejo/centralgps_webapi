defmodule CentralGPS.Repo do
  use Ecto.Repo, otp_app: :central_g_p_s_web_a_p_i
  import CentralGPS.Repo.Utilities

  @doc """
  Executes a Ecto.Adapters.SQL, gets results and makes LIST of MAP with atomic
  keys for each row returned

  Parameters:

  cmd   : The command text to execute
  _params: A List [] of parameters to be used by the cmd
  filter: (optional) see docs of objectify_map
  keys  : (optional) see docs of objectify_map

  returns tuple: {:row_count, :list_of_objects }
  """
  def query(cmd, _params, filter \\ []) do
    try do
      table_to_map Ecto.Adapters.SQL.query(CentralGPS.Repo, cmd, _params), filter
    rescue
      e in _ ->
        vars = %{cmd: cmd, _params: _params, filter: filter}
        error_logger e, __ENV__, vars
        raise e
    end
  end

end
