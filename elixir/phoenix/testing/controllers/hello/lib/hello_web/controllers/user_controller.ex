defmodule HelloWeb.UserController do
  use HelloWeb, :controller

  alias Hello.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    # The exclamation indicates the function will
    # throw an error with the user is not found.
    case Accounts.get_user(id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> render("error.json", message: "User not found")
      user ->
        render(conn, "show.json", user: user)
    end
  end

end
