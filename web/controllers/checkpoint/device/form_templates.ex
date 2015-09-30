defmodule CentralGPSWebAPI.Controllers.Device.FormTemplates do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Checkpoint.Device.Functions

  def form_templates(conn, params) do
    try do
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params)
      {row_count, result} = params
      |> Map.values #trim just the value we want from the request (auth_token)
      |> Enum.concat([ nil, "A"]) #The form to sync is ALL, and no sync_token
      |> fn_chkapi_form_template_list
      if row_count < 1, do: {conn, result} = {(conn |> put_status 204), []}
      json conn, result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def form_templates_update(conn, params) do
    try do
      _k = [ :_sync_token ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, _k)
      {row_count, result} = params
      |> Map.values #get: auth and sync tokens
      |> Enum.concat(["U"]) #and UPDATE form
      |> fn_chkapi_form_template_list
      if row_count < 1, do: {conn, result} = {(conn |> put_status 204), []}
      json conn, result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

end
