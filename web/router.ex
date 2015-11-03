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
    #if CentralGPSWebAPI.api_config(:checkpoint_enabled) do
      #Device register
      post    "/device/register",            Device.Register, :register
      #Device record (history)
      post    "/device/record",              Device.Record,   :record
      #Venue creative mode
      post    "/device/venues/create",       Device.Venues,   :venue_create
      #Mark CRUDs
      post    "/device/mark",                Device.Marks,    :register_mark
      post    "/device/mark_activity",       Device.Marks,    :register_mark_activity
      post    "/device/mark_activity_item",  Device.Marks,    :register_mark_activity_item
      post    "/device/mark_activity_image", Device.Marks,    :register_mark_activity_image
      put     "/device/mark",                Device.Marks,    :update_mark
      put     "/device/mark_activity",       Device.Marks,    :update_mark_activity
      put     "/device/mark_activity_item",  Device.Marks,    :update_mark_activity_item
      delete  "/device/mark/:mark_token",                Device.Marks,    :delete_mark
      delete  "/device/mark_activity/:mark_token/:id",   Device.Marks,    :delete_mark_activity
      delete  "/device/mark_activity_item/:mark_token/:mark_activity_id/:id",  Device.Marks, :delete_mark_activity_item
      delete  "/device/mark_activity_image/:mark_token/:mark_activity_id/:id", Device.Marks, :delete_mark_activity_image
      #Lists
      get     "/device/roadmaps/:day",               Device.Roadmaps,       :roadmaps
      get     "/device/forms",                       Device.Forms,          :forms
      get     "/device/forms/:sync_token",           Device.Forms,          :forms_update
      get     "/device/form_templates",              Device.FormTemplates,  :form_templates
      get     "/device/form_templates/:sync_token",  Device.FormTemplates,  :form_templates_update
      get     "/device/activities",                  Device.Activities,     :activities
      get     "/device/activities/:sync_token",      Device.Activities,     :activities_update
      get     "/device/items",                       Device.Items,          :items
      get     "/device/items/:sync_token",           Device.Items,          :items_update
      get     "/device/measure_units",               Device.MeasureUnits,   :measure_units
      get     "/device/measure_units/:sync_token",   Device.MeasureUnits,   :measure_units_update
      get     "/device/clients",                     Device.Clients,        :clients
      get     "/device/clients/:sync_token",         Device.Clients,        :clients_update
      get     "/device/client_contacts",             Device.ClientContacts, :client_contacts
      get     "/device/client_contacts/:sync_token", Device.ClientContacts, :client_contacts_update
      get     "/device/venue_types",                 Device.Venues,         :venue_types
      get     "/device/venue_types/:sync_token",     Device.Venues,         :venue_types_update
      get     "/device/venues",                      Device.Venues,         :venues
      get     "/device/venues/:sync_token",          Device.Venues,         :venues_update
      get     "/device/venues/near",                 Device.Venues,         :venues_near
      #Client
      post    "/client/create",        Checkpoint.Client, :create
      get     "/client/:client_id",    Checkpoint.Client, :read
      put     "/client/:client_id",    Checkpoint.Client, :update
      delete  "/client/:client_id",    Checkpoint.Client, :delete
      get     "/client/",              Checkpoint.Client, :list
      #Client Contact
      post    "/client/:client_id/contact/create",                Checkpoint.ClientContact, :create
      get     "/client/:client_id/contact/:client_contact_id",    Checkpoint.ClientContact, :read
      put     "/client/:client_id/contact/:client_contact_id",    Checkpoint.ClientContact, :update
      delete  "/client/:client_id/contact/:client_contact_id",    Checkpoint.ClientContact, :delete
      get     "/client/:client_id/contact/",                      Checkpoint.ClientContact, :list
      #Form
      post    "/form/create",      Checkpoint.Form, :create
      get     "/form/:form_id",    Checkpoint.Form, :read
      put     "/form/:form_id",    Checkpoint.Form, :update
      delete  "/form/:form_id",    Checkpoint.Form, :delete
      get     "/form/",            Checkpoint.Form, :list
      #Form Templates
      post    "/form_template/create",                Checkpoint.FormTemplate, :create
      get     "/form_template/:form_id",              Checkpoint.FormTemplate, :read
      put     "/form_template/:form_id",              Checkpoint.FormTemplate, :update
      delete  "/form_template/:form_id",              Checkpoint.FormTemplate, :delete
      get     "/form_template/",                      Checkpoint.FormTemplate, :list
      get     "/form_template/:form_id/:activity_id", Checkpoint.FormTemplate, :list_items
      #Activities
      post    "/activity/create",        Checkpoint.Activity, :create
      get     "/activity/:activity_id",  Checkpoint.Activity, :read
      put     "/activity/:activity_id",  Checkpoint.Activity, :update
      delete  "/activity/:activity_id",  Checkpoint.Activity, :delete
      get     "/activity/",              Checkpoint.Activity, :list
      #Items
      post    "/item/create",      Checkpoint.Item, :create
      get     "/item/:item_id",    Checkpoint.Item, :read
      put     "/item/:item_id",    Checkpoint.Item, :update
      delete  "/item/:item_id",    Checkpoint.Item, :delete
      get     "/item/",            Checkpoint.Item, :list
      #Form
      post    "/measure_unit/create",      Checkpoint.MeasureUnit, :create
      get     "/measure_unit/:measure_unit_id",    Checkpoint.MeasureUnit, :read
      put     "/measure_unit/:measure_unit_id",    Checkpoint.MeasureUnit, :update
      delete  "/measure_unit/:measure_unit_id",    Checkpoint.MeasureUnit, :delete
      get     "/measure_unit/",            Checkpoint.MeasureUnit, :list
      #Venues
      post    "/venue/create",     Checkpoint.Venue, :create
      get     "/venue/:venue_id",  Checkpoint.Venue, :read
      put     "/venue/:venue_id",  Checkpoint.Venue, :update
      delete  "/venue/:venue_id",  Checkpoint.Venue, :delete
      get     "/venue/",           Checkpoint.Venue, :list
      #Venue types
      post    "/venue_type/create",          Checkpoint.VenueType, :create
      get     "/venue_type/:venue_type_id",  Checkpoint.VenueType, :read
      put     "/venue_type/:venue_type_id",  Checkpoint.VenueType, :update
      delete  "/venue_type/:venue_type_id",  Checkpoint.VenueType, :delete
      get     "/venue_type/",                Checkpoint.VenueType, :list
      #Marks
      get     "/mark/", Checkpoint.Mark, :mark_list
      #Roadmap point <-> venue association
      post    "/roadmap_point_venue_form",                              Checkpoint.RoadmapPointVenueForm, :create
      get     "/roadmap_point_venue_form/:roadmap_point_venue_form_id", Checkpoint.RoadmapPointVenueForm, :read
      put     "/roadmap_point_venue_form/:roadmap_point_venue_form_id", Checkpoint.RoadmapPointVenueForm, :update
      delete  "/roadmap_point_venue_form/:roadmap_point_venue_form_id", Checkpoint.RoadmapPointVenueForm, :delete
    #end
  end
end
