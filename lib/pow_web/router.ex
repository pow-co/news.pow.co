defmodule PowWeb.Router do
  use PowWeb, :router

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

  pipeline :auth do
    plug PowWeb.Plugs.AuthPipeline
  end

  pipeline :maybe_auth do
    plug PowWeb.Plugs.MaybeAuthPipeline
  end

  scope "/", PowWeb do
    pipe_through [:browser, :auth]

    resources "/posts", PostController, only: [:new, :create] do
      resources "/comments", CommentController, only: [:create]
    end

    get "/logout", UserController, :logout
  end

  scope "/", PowWeb do
    pipe_through [:browser, :maybe_auth]

    get "/", FeedController, :index
    get "/login", UserController, :login
    get "/handcash/callback", UserController, :handcash_callback
    get "/posts/:id", PostController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", PowWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PowWeb.Telemetry
    end
  end
end
