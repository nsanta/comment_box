defmodule CommentBoxWeb.Router do
  use CommentBoxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  scope "/", CommentBoxWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end
  
  scope "/api/v1", CommentBoxWeb.Api.V1 do
    pipe_through :api
    
    post "/sessions", SessionsController, :create
    post "/registrations", RegistrationsController, :create
    delete "/sessions", SessionsController, :delete
  end

end
