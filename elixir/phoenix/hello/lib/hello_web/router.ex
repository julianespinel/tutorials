defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", HelloWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/hello", HelloController, :index)
    get("/hello/:messenger", HelloController, :show)
    # Nested resources: a one-to-many relationship (user -> posts)
    resources("/users", UserController) do
      resources("/posts", PostController)
    end

    resources("/reviews", ReviewController)
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
