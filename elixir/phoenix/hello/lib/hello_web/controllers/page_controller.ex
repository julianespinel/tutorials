defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  # Call this action like:
  # 1. http://localhost:4000
  # 2. http://localhost:4000/?_format=text&message=CrazyTown
  def index(conn, params) do
    # conn
    # |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    # |> put_flash(:error, "Let's pretend we have an error.")
    # |> render(:index, message: params["message"])

    # conn
    # |> put_layout(false)
    # |> render("index.html")

    # conn
    # |> put_status(202)
    # |> render(:index)

    # conn
    # |> put_status(:not_found)
    # |> put_view(HelloWeb.ErrorView)
    # |> render("404.html")

    # How to redirect:
    # redirect(conn, to: "/redirect_test")
    # redirect(conn, to: redirect_test_path(conn, :redirect_test))
    # redirect(conn, external: "http://google.com")

    pages = [%{title: "foo"}, %{title: "bar"}]
    render(conn, "index.json", pages: pages)
  end

  # Use action fallback to handle errors: https://hexdocs.pm/phoenix/controllers.html#action-fallback

  def redirect_test(conn, _params) do
    text(conn, "Redirect!")
  end

  def index_admin(conn, _params) do
    conn
    |> put_layout("admin.html")
    |> render("index.html")
  end

  def show(conn, _params) do
    page = %{title: "foo"}
    render(conn, "show.json", page: page)
  end

  def test(conn, _params) do
    render(conn, "test.html")
  end
end
