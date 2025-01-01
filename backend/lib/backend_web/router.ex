defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

pipeline :authenticated do
  plug Guardian.Plug.EnsureAuthenticated
end

  scope "/api", BackendWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit] do
      # pipe_through :authenticated
      resources "/record", RecordController, only: [:create, :index]

      scope "/image" do
        put "/", UserController, :change_image
        get "/", UserController, :show_image
        delete "/", UserController, :delete_image
      end
    end

    post "/login", LoginController, :login
    # patch "/users/:id/record", UserController, :update_record
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:backend, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BackendWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
