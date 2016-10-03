defmodule MyAppTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts MyRouter.init([])

  test "returns hello world" do
    # Create a connection
    conn = conn(:get, "/hello")
    # Invoke the plug (the router plug?)
    conn = MyRouter.call(conn, @opts)
    # Test
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "world"
  end
end
