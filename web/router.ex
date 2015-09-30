defmodule CentralGPSWebAPI.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json", "html"]
  end

  #A resource of security (an auth_token of a existing account) that has
  # permissions can do activities on accounts (client and entity, typed C/E)
  scope "/api/v1/security/", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/login/:auth_type", Security.Login, :login
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

  scope "/api/v1/client/asset", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/:asset_id/roadmap/create",      Client.AssetRoadmap, :create
    get     "/:asset_id/roadmap/:roadmap_id", Client.AssetRoadmap, :read
    put     "/:asset_id/roadmap/:roadmap_id", Client.AssetRoadmap, :update
    delete  "/:asset_id/roadmap/:roadmap_id", Client.AssetRoadmap, :delete
    get     "/:asset_id/roadmap",             Client.AssetRoadmap, :list
    get     "/roadmap",                       Client.AssetRoadmap, :all_list
  end

  scope "/api/v1/client/roadmaps", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/create",       Client.Roadmap, :create
    get     "/:roadmap_id",  Client.Roadmap, :read
    put     "/:roadmap_id",  Client.Roadmap, :update
    delete  "/:roadmap_id",  Client.Roadmap, :delete
    get     "/",             Client.Roadmap, :list
  end

  scope "/api/v1/client/roadmaps/:roadmap_id/points", CentralGPSWebAPI.Controllers do
    pipe_through :api

    post    "/create",             Client.RoadmapPoint, :create
    get     "/:roadmap_point_id",  Client.RoadmapPoint, :read
    put     "/:roadmap_point_id",  Client.RoadmapPoint, :update
    delete  "/:roadmap_point_id",  Client.RoadmapPoint, :delete
    get     "/",                   Client.RoadmapPoint, :list
  end

  scope "/api/v1/monitor", CentralGPSWebAPI.Controllers do
    pipe_through :api

    get "/client",         Client.Asset, :asset_list
    get "/client/record",  Client.Asset, :record_list
    get "/client/roadmap", Client.Asset, :roadmap_list

  end

  scope "/api/v1/checkpoint", CentralGPSWebAPI.Controllers do
    pipe_through :api
    if CentralGPSWebAPI.app_config(:checkpoint_enabled) do
      #Device
      post    "/device/register",            Device.Register, :register
      post    "/device/record",              Device.Record,   :record
      post    "/device/venues/create",       Device.Venues,   :venue_create
      post    "/device/mark",                Device.Marks,    :register_mark
      post    "/device/mark_activity",       Device.Marks,    :register_mark_activity
      post    "/device/mark_activity_item",  Device.Marks,    :register_mark_activity_item
      post    "/device/mark_activity_image", Device.Marks,    :register_mark_activity_image
      put     "/device/mark",                Device.Marks,    :update_mark
      put     "/device/mark_activity",       Device.Marks,    :update_mark_activity
      put     "/device/mark_activity_item",  Device.Marks,    :update_mark_activity_item
      put     "/device/mark_activity_image", Device.Marks,    :update_mark_activity_image
      #Lists
      get     "/device/forms",                       Device.Forms,          :forms
      get     "/device/forms/:_sync_token",          Device.Forms,          :forms_update
      get     "/device/activities",                  Device.Activities,     :activities
      get     "/device/activities/:_sync_token",     Device.Activities,     :activities_update
      get     "/device/items",                       Device.Items,          :items
      get     "/device/items/:_sync_token",          Device.Items,          :items_update
      get     "/device/measure_unit",                Device.MeasureUnit,    :measure_units
      get     "/device/measure_unit/:_sync_token",   Device.MeasureUnit,    :measure_units_update
      get     "/device/client",                      Device.Clients,        :clients
      get     "/device/client/:_sync_token",         Device.Clients,        :clients_update
      get     "/device/client_contact",              Device.ClientContacts, :client_contacts
      get     "/device/client_contact/:_sync_token", Device.ClientContacts, :client_contacts_update
      get     "/device/venue_types",                 Device.Venues,         :venue_types
      get     "/device/venue_types/:_sync_token",    Device.Venues,         :venue_types_update
      get     "/device/venues",                      Device.Venues,         :venues
      get     "/device/venues/:_sync_token",         Device.Venues,         :venues_update
      get     "/device/venues/near",                 Device.Venues,         :venues_near
      #Form
      post    "/form/create",      Checkpoint.Form, :create
      get     "/form/:form_id",    Checkpoint.Form, :read
      put     "/form/:form_id",    Checkpoint.Form, :update
      delete  "/form/:form_id",    Checkpoint.Form, :delete
      get     "/form/",            Checkpoint.Form, :list
      #Activities
      post    "/activity/create",        Checkpoint.Activity, :create
      get     "/activity/:activity_id",  Checkpoint.Activity, :read
      put     "/activity/:activity_id",  Checkpoint.Activity, :update
      delete  "/activity/:activity_id",  Checkpoint.Activity, :delete
      get     "/activity/",              Checkpoint.Activity, :list
      #Venues
      post    "/venues/create",     Checkpoint.Venue, :create
      get     "/venues/:venue_id",  Checkpoint.Venue, :read
      put     "/venues/:venue_id",  Checkpoint.Venue, :update
      delete  "/venues/:venue_id",  Checkpoint.Venue, :delete
      get     "/venues/",           Checkpoint.Venue, :list
      #Venue types
      post    "/venue_types/create",          Checkpoint.VenueType, :create
      get     "/venue_types/:venue_type_id",  Checkpoint.VenueType, :read
      put     "/venue_types/:venue_type_id",  Checkpoint.VenueType, :update
      delete  "/venue_types/:venue_type_id",  Checkpoint.VenueType, :delete
      get     "/venue_types/",                Checkpoint.VenueType, :list
      #Marks
      get     "marks/", Checkpoint.Mark, :mark_list
      #Roadmap point <-> venue association
      post    "/roadmap_point_venue", Checkpoint.RoadmapPointVenue, :create
      delete  "/roadmap_point_venue/:roadmap_point_id", Checkpoint.RoadmapPointVenue, :delete
    end
  end
end
