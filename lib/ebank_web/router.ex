defmodule EbankWeb.Router do
  use EbankWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EbankWeb do
    pipe_through :browser

    get "/", TransactionController, :index
    resources "/transactions", TransactionController
  end

  #Other scopes may use custom stacks.
  scope "/api", EbankWeb do
    pipe_through :api

  get "/transactions", TransactionController, :index_api

  end
end
