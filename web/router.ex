defmodule CentralGPSWebAPI.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/security/login", CentralGPSWebAPI.Controllers do
    pipe_through :api
    post    "/:my_account_type", Security.Login, :login
  end

  #A resource of security (an auth_token of a existing account) that has
  # permissions can do actions on accounts (client and entity, typed C/E)
  scope "/api/:_my_account_type/:_auth_token/security/", CentralGPSWebAPI.Controllers do
    pipe_through :api

    put     "/accounts/activate/:account_type/:account_id", Security.Account, :account_activate
    post    "/accounts/create/:account_type",               Security.Account, :account_create
    get     "/accounts/:account_type/:account_id",          Security.Account, :account_read
    put     "/accounts/:account_type/:account_id",          Security.Account, :account_update
    delete  "/accounts/:account_type/:account_id",          Security.Account, :account_delete
    get     "/accounts",                                    Security.Account, :account_list

    post    "/accounts/:account_type/:account_id/roles/create/:role_id",  Security.Account, :account_role_create
    delete  "/accounts/:account_type/:account_id/roles/:role_id",         Security.Account, :account_role_delete
    get     "/accounts/:account_type/:account_id/roles",                  Security.Account, :account_role_list

    post    "/accounts/:account_type/:account_id/permissions/create/:permission_id",  Security.Account, :account_permission_create
    delete  "/accounts/:account_type/:account_id/permissions/:permission_id",         Security.Account, :account_permission_delete
    get     "/accounts/:account_type/:account_id/permissions",                        Security.Account, :account_permission_list
  end

  scope "/api/:_my_account_type/:_auth_token/checkpoint/actions", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/create",      Checkpoint.Action, :action_create
    get     "/:action_id",  Checkpoint.Action, :action_read
    put     "/:action_id",  Checkpoint.Action, :action_update
    delete  "/:action_id",  Checkpoint.Action, :action_delete
    get     "/",            Checkpoint.Action, :action_list
  end

  scope "/api/:_my_account_type/:_auth_token/checkpoint/reasons", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/create",      Checkpoint.Reason, :reason_create
    get     "/:reason_id",  Checkpoint.Reason, :reason_read
    put     "/:reason_id",  Checkpoint.Reason, :reason_update
    delete  "/:reason_id",  Checkpoint.Reason, :reason_delete
    get     "/",            Checkpoint.Reason, :reason_list
  end

  scope "/api/:_my_account_type/:_auth_token/checkpoint/venues", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/create",     Checkpoint.Venue, :venue_create
    get     "/:venue_id",  Checkpoint.Venue, :venue_read
    put     "/:venue_id",  Checkpoint.Venue, :venue_update
    delete  "/:venue_id",  Checkpoint.Venue, :venue_delete
    get     "/",           Checkpoint.Venue, :venue_list
  end

  scope "/api/:_my_account_type/:_auth_token/checkpoint/venue_types", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/create",          Checkpoint.VenueType, :venue_type_create
    get     "/:venue_type_id",  Checkpoint.VenueType, :venue_type_read
    put     "/:venue_type_id",  Checkpoint.VenueType, :venue_type_update
    delete  "/:venue_type_id",  Checkpoint.VenueType, :venue_type_delete
    get     "/",                Checkpoint.VenueType, :venue_type_list
  end

  scope "/api/:_my_account_type/:_auth_token/monitor", CentralGPSWebAPI.Controllers do
    pipe_through :api

    get "/assets", Client.Asset, :asset_list

  end
end
