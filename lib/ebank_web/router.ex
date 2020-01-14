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

    get "/", PageController, :index
    resources "/customers", CustomerController
    resources "/users", UserController
    resources "/transactions", TransactionController
    resources "/transactionns", TransactionnController
  end

  #Other scopes may use custom stacks.
  scope "/api", EbankWeb do
    pipe_through :api

  get "/transactionns", TransactionnController, :index_api
  end
end
