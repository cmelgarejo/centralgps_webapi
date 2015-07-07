defmodule CentralGPSWebAPI.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json", "html"]
  end

  scope "/api/v1/security/login", CentralGPSWebAPI.Controllers do
    pipe_through :api
    post    "/:auth_type", Security.Login, :login
  end

  #A resource of security (an auth_token of a existing account) that has
  # permissions can do actions on accounts (client and entity, typed C/E)
  scope "/api/v1/security/", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/logout/:account_type", Security.Login, :logout

    put     "/accounts/activate/:account_type/:account_id", Security.Account, :activate
    post    "/accounts/create/:account_type",               Security.Account, :create
    get     "/accounts/:account_type/:account_id",          Security.Account, :read
    put     "/accounts/:account_type/:account_id",          Security.Account, :update
    delete  "/accounts/:account_type/:account_id",          Security.Account, :delete
    get     "/accounts",                                    Security.Account, :list

    post    "/accounts/:account_type/:account_id/roles/create/:role_id",  Security.Account.Role, :create
    delete  "/accounts/:account_type/:account_id/roles/:role_id",         Security.Account.Role, :delete

    post    "/accounts/:account_type/:account_id/permissions/create/:permission_id",  Security.Account.Permission, :create
    delete  "/accounts/:account_type/:account_id/permissions/:permission_id",         Security.Account.Permission, :delete
    get     "/accounts/:account_type/:feature_code/:code", Security.Account.Permission, :check

  end

  scope "/api/v1/checkpoint/actions", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/create",      Checkpoint.Action, :create
    get     "/:action_id",  Checkpoint.Action, :read
    put     "/:action_id",  Checkpoint.Action, :update
    delete  "/:action_id",  Checkpoint.Action, :delete
    get     "/",            Checkpoint.Action, :list
  end

  scope "/api/v1/checkpoint/reasons", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/create",      Checkpoint.Reason, :create
    get     "/:reason_id",  Checkpoint.Reason, :read
    put     "/:reason_id",  Checkpoint.Reason, :update
    delete  "/:reason_id",  Checkpoint.Reason, :delete
    get     "/",            Checkpoint.Reason, :list
  end

  scope "/api/v1/checkpoint/venues", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/create",     Checkpoint.Venue, :create
    get     "/:venue_id",  Checkpoint.Venue, :read
    put     "/:venue_id",  Checkpoint.Venue, :update
    delete  "/:venue_id",  Checkpoint.Venue, :delete
    get     "/",           Checkpoint.Venue, :list
  end

  scope "/api/v1/checkpoint/venue_types", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/create",          Checkpoint.VenueType, :create
    get     "/:venue_type_id",  Checkpoint.VenueType, :read
    put     "/:venue_type_id",  Checkpoint.VenueType, :update
    delete  "/:venue_type_id",  Checkpoint.VenueType, :delete
    get     "/",                Checkpoint.VenueType, :list
  end

  scope "/api/v1/checkpoint/marks", CentralGPSWebAPI.Controllers do
    pipe_through :api

    get "/", Checkpoint.Mark, :mark_list

  end

  scope "/api/v1/client/roadmap", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/create",       Client.Roadmap, :create
    get     "/:roadmap_id",  Client.Roadmap, :read
    put     "/:roadmap_id",  Client.Roadmap, :update
    delete  "/:roadmap_id",  Client.Roadmap, :delete
    get     "/",             Client.Roadmap, :list
  end

  scope "/api/v1/client/roadmap/:roadmap_id/point", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/create",             Client.RoadmapPoint, :create
    get     "/:roadmap_point_id",  Client.RoadmapPoint, :read
    put     "/:roadmap_point_id",  Client.RoadmapPoint, :update
    delete  "/:roadmap_point_id",  Client.RoadmapPoint, :delete
    get     "/",                   Client.RoadmapPoint, :list
  end

  scope "/api/v1/monitor", CentralGPSWebAPI.Controllers do
    pipe_through :api

    get "/client",        Client.Asset, :asset_list
    get "/client/record", Client.Asset, :record_list

  end
end
