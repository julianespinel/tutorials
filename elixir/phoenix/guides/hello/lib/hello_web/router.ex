defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug(:accepts, ["html", "text"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_id ->
        assign(conn, :current_user, Hello.Accounts.get_user!(user_id))
    end
  end

  scope "/", HelloWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/users", UserController)
    resources("/sessions", SessionController, only: [:new, :create, :delete],
                                              singleton: true)
    # singleton: true option, which defines all the RESTful routes, but does not
    # require a resource ID to be passed along in the URL.

    get("/admin", PageController, :index_admin)

    get("/hello", HelloController, :index)
    get("/hello/:messenger", HelloController, :show)
    get("/hallo/:messenger", HelloController, :show_json)
    # Nested resources: a one-to-many relationship (user -> posts)
    resources("/users", UserController) do
      resources("/posts", PostController)
    end

    resources("/reviews", ReviewController)

    # Route for redirects
    get("/redirect_test", PageController, :redirect_test, as: :redirect_test)

    get("/test", PageController, :test)
  end

  scope "/cms", HelloWeb.CMS, as: :cms do
    pipe_through [:browser, :authenticate_user]
    
    resources("/pages", PageController)
  end

  scope "/admin", HelloWeb.Admin, as: :admin do
    pipe_through(:browser)

    resources("/reviews", ReviewController)
    resources("/images", ImageController)
    resources("/users", UserController)
  end

  scope "/api", HelloWeb.Api, as: :api do
    pipe_through(:browser)

    scope "/v1", V1, as: :v1 do
      resources("/reviews", ReviewController)
      resources("/images", ImageController)
      resources("/users", UserController)
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end
end
