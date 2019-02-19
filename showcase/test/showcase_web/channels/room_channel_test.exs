defmodule ShowcaseWeb.RoomChannelTest do
  use ShowcaseWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      socket(ShowcaseWeb.UserSocket, "user_id", %{current_user: "bar"})
      |> subscribe_and_join(ShowcaseWeb.RoomChannel, "room:lobby")

    {:ok, socket: socket}
  end

  test "new_msg broadcasts to room:lobby", %{socket: socket} do
    push socket, "new_msg", %{"body" => "foo"}
    assert_broadcast "new_msg", %{body: "foo"}
  end

end
