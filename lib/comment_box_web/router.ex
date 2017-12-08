defmodule CommentBoxWeb.Router do
  use CommentBoxWeb, :router

  pipeline :auth do
    plug CommentBox.Auth.Pipeline
  end
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  scope "/", CommentBoxWeb do
    pipe_through [:browser, :auth] # Use the default browser stack

    get "/", PageController, :index
    get "/embed/box", BoxesController, :show
  end
  
  scope "/api/v1", CommentBoxWeb.Api.V1 do
    pipe_through [:api]

    post "/sessions", SessionsController, :create
    post "/registrations", RegistrationsController, :create 
    resources "/boxes/:box_id/comments", CommentsController, only: [:index]
  end
  
  scope "/api/v1", CommentBoxWeb.Api.V1 do
    pipe_through [:api, :auth, :ensure_auth]
     
    delete "/sessions", SessionsController, :delete
    resources "/boxes/:box_id/comments", CommentsController, only: [:create]    
  end

end
