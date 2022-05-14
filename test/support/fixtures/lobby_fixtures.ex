defmodule Room.LobbyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Room.Lobby` context.
  """

  @doc """
  Generate a shared_space.
  """
  def shared_space_fixture(attrs \\ %{}) do
    {:ok, shared_space} =
      attrs
      |> Enum.into(%{name: "Default name"})
      |> Room.Lobby.create_shared_space()

    shared_space
  end
end
