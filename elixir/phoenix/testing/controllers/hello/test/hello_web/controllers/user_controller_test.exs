defmodule HelloWeb.UserControllerTest do
  use HelloWeb.ConnCase

  alias Hello.Accounts

  @create_attrs %{name: "John", email: "john@example.com", password: "john pass"}

  defp create_user(_) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    {:ok, user: user}
  end

  test "index/2 responds with all users", %{conn: conn} do
    users = [
      %{name: "John", email: "john@example.com", password: "john pass"},
      %{name: "Jane", email: "jane@example.com", password: "jane pass"}
    ]

    # Create users local to this database connection and test
    [{:ok, user1}, {:ok, user2}] = Enum.map(users, &Accounts.create_user(&1))

    response =
      conn
      |> get(user_path(conn, :index))
      |> json_response(:ok)

    expected = %{
      "data" => [
        %{ "name" => user1.name, "email" => user1.email },
        %{ "name" => user2.name, "email" => user2.email }
      ]
    }

    assert response == expected
  end

  describe "create/2" do
    test "Creates and responds with a newly created user if attributes are valid"
    test "Returns an error and does not create a user if attributes are invalid"
  end

  describe "show/2" do
    setup [:create_user]

    test "Responds with user info if user if found", %{conn: conn, user: user} do
      response =
        conn
        |> get(user_path(conn, :show, user.id))
        |> json_response(:ok)

      expected = %{"data" => %{"name" => user.name, "email" => user.email}}

      assert response == expected
    end

    test "Responds with a message indicating user not found", %{conn: conn} do
      fake_user_id = 123

      response =
        conn
        |> get(user_path(conn, :show, fake_user_id))
        |> json_response(:not_found)

      expected = %{"message" => "User not found"}

      assert response == expected
    end
  end

  describe "update/2" do
    test "Edits and responds with the user if attributes are valid"
    test "Returns and error and does not edit the user attributes are invalid"
  end

  test "delete/2 and responds with :ok if user was deleted"

end
