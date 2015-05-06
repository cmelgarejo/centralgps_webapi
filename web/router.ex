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
  scope "/api/security/:_my_account_type/:_auth_token", CentralGPSWebAPI.Controllers do
    pipe_through :api

    put     "/accounts/activate/:id",      Security.Account, :account_activate
    post    "/accounts/create",            Security.Account, :account_create
    get     "/accounts/:account_type/:account_id",
                                           Security.Account, :account_read
    put     "/accounts/:account_type/:account_id",
                                           Security.Account, :account_update
    delete  "/accounts/:account_type/:account_id",
                                           Security.Account, :account_delete
    get     "/accounts/",                  Security.Account, :account_list

  end

  scope "/api/checkpoint/actions/:_auth_token", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/create", Checkpoint.Action, :action_create
    get     "/:__id",  Checkpoint.Action, :action_read
    put     "/:__id",  Checkpoint.Action, :action_update
    delete  "/:__id",  Checkpoint.Action, :action_delete
    get     "/",       Checkpoint.Action, :action_list
  end

  scope "/api/checkpoint/reasons/:_auth_token", CentralGPSWebAPI.Controllers do
    pipe_through :api

    get     "/",       Checkpoint.Reason, :reason_list
    get     "/:__id",  Checkpoint.Reason, :reason_read
    post    "/create", Checkpoint.Reason, :reason_create
    put     "/:__id",  Checkpoint.Reason, :reason_update
    delete  "/:__id",  Checkpoint.Reason, :reason_delete
  end

  scope "/api/checkpoint/venues/:_auth_token", CentralGPSWebAPI.Controllers do
    pipe_through :api

    get     "/",       Checkpoint.Venue, :venue_list
    get     "/:__id",  Checkpoint.Venue, :venue_read
    post    "/create", Checkpoint.Venue, :venue_create
    put     "/:__id",  Checkpoint.Venue, :venue_update
    delete  "/:__id",  Checkpoint.Venue, :venue_delete
  end

  scope "/api/checkpoint/venue_types/:_auth_token", CentralGPSWebAPI.Controllers do
    pipe_through :api

    get     "/",       Checkpoint.VenueType, :venue_type_list
    get     "/:__id",  Checkpoint.VenueType, :venue_type_read
    post    "/create", Checkpoint.VenueType, :venue_type_create
    put     "/:__id",  Checkpoint.VenueType, :venue_type_update
    delete  "/:__id",  Checkpoint.VenueType, :venue_type_delete
  end

  scope "/api/monitor/:_auth_token", CentralGPSWebAPI.Controllers do
    pipe_through :api

    get "/assets", Client.Asset, :list_assets

  end
end
