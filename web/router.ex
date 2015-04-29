defmodule CentralGPSWebAPI.Router do
  use Phoenix.Router

  #pipeline :browser do
  #  plug :accepts, ["html"]
  #  plug :fetch_session
  #  plug :fetch_flash
  #  plug :protect_from_forgery
  #end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/security", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post "/login", Security.Login, :login
    #A resource of security (an auth_token of a existing account) that has
    # permissions can do actions on accounts (client and entity, typed C/E)
    get     "/:_auth_token/accounts/",      Security.Account, :account_list
    get     "/:_auth_token/accounts/:__id",
                                            Security.Account, :account_read
    post    "/:_auth_token/accounts/create",
                                            Security.Account, :account_create
    put     "/:_auth_token/accounts/:__id",
                                            Security.Account, :account_update
    put     "/:_auth_token/accounts/:__id",
                                            Security.Account, :account_activate
    delete  "/:_auth_token/accounts/:__id",
                                            Security.Account, :account_delete
  end

  scope "/api/checkpoint/actions/:_auth_token", CentralGPSWebAPI.Controllers do
    pipe_through :api

    get     "/",       Checkpoint.Action, :action_list
    get     "/:__id",  Checkpoint.Action, :action_read
    post    "/create", Checkpoint.Action, :action_create
    put     "/:__id",  Checkpoint.Action, :action_update
    delete  "/:__id",  Checkpoint.Action, :action_delete
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
