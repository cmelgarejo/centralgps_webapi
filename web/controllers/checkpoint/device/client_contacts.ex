defmodule CentralGPSWebAPI.Controllers.Device.ClientContacts do
  use CentralGPSWebAPI.Web, :controller
  import CentralGPS.Repo.Utilities
  import CentralGPS.Repo.Checkpoint.Device.Functions

  def client_contacts(conn, params) do
    try do
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params)
      {row_count, result} = params
        |> Map.values #trim just the value we want from the request (auth_token)
        |> Enum.concat([ nil, "A"]) #The form to sync is ALL, and no sync_token
        |> fn_chkapi_client_contact_list
      if row_count < 1, do: {conn, result} = {(conn |> put_status 204), []}
      json conn, result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def client_contacts_update(conn, params) do
    try do
      keys = [ :sync_token ]
      {_, params} = checkpoint_auth_proc_headers_and_params(conn.req_headers, params, keys)
      {row_count, result} = params
        |> Map.values #get: auth and sync tokens
        |> Enum.concat(["U"]) #and UPDATE form
        |> fn_chkapi_client_contact_list
      if row_count < 1, do: {conn, result} = {(conn |> put_status 204), []}
      json conn, result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

  def creative_mode_create(conn, params) do
    try do
      keys = [ :client_id, :name, :identity_document, :notes, :emails, :phones, :notify, :image_path, :image_bin ]
      {_, params} = auth_proc_headers_and_params(conn.req_headers, params, keys)
      params = params
        |> Map.update(:client_id, nil, &(parse_int(&1)))
        |> Map.update(:notify,    nil, &(parse_boolean(&1)))
        |> Map.update(:image_bin, nil, &(if (&1 != nil), do: Base.url_decode64!(&1), else: nil))
      {_, result} = fn_chkapi_client_contact_create((Map.drop(params, keys) |> Map.values) ++
        [ params.client_id, params.name, params.notes, params.identity_document, params.emails, params.phones, params.notify, params.image_path, params.image_bin ])
      {response_code, result} = (if result.status, do: {201, result},
                                 else: {200, result |> Map.take [:status, :msg]})
      if (response_code == 201 && Map.has_key?(params, :image_bin) && params.image_bin != nil), do:
        save_image(params.image_path, params.image_bin)
      json (conn |> put_status response_code), result
    rescue
      e in ArgumentError -> json (conn |> put_status 400), %{status: false, msg: e.message}
      e in Exception -> json (conn |> put_status 500), %{status: false, msg: e.message}
    end
  end

end
