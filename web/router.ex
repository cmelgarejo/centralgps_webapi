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
    post    "/:_auth_token/accounts/register", Security.Account, :register
    get     "/:_auth_token/accounts/",         Security.Account, :list_accounts
    get     "/:_auth_token/accounts/:_account_id",
                                               Security.Account, :get_account
    put     "/:_auth_token/accounts/:_account_id",
                                               Security.Account, :update_account
    delete  "/:_auth_token/accounts/:_account_id",
                                               Security.Account, :delete_account

  end
end
