defmodule Room.LobbyTest do
  use Room.DataCase

  alias Room.Lobby

  setup_all do
    Lobby.setup!()

    :ok
  end

  describe "shared_spaces" do
    alias Room.Lobby.SharedSpace

    import Room.LobbyFixtures

    @invalid_attrs %{name: nil}

    test "list_shared_spaces/0 returns all shared_spaces" do
      %{id: shared_space_id} = shared_space_fixture()
      assert [%{id: ^shared_space_id} | _] = Lobby.list_shared_spaces()
    end

    test "get_shared_space!/1 returns the shared_space with given id" do
      shared_space = shared_space_fixture()
      assert Lobby.get_shared_space!(shared_space.id) == shared_space
    end

    test "create_shared_space/1 with valid data creates a shared_space" do
      valid_attrs = %{name: "My shared space"}

      assert {:ok, %SharedSpace{} = shared_space} = Lobby.create_shared_space(valid_attrs)
      assert shared_space.name == "My shared space"
    end

    test "create_shared_space/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lobby.create_shared_space(@invalid_attrs)
    end

    test "update_shared_space/2 with valid data updates the shared_space" do
      shared_space = shared_space_fixture()
      update_attrs = %{name: "Updated name"}

      assert {:ok, %SharedSpace{} = shared_space} =
               Lobby.update_shared_space(shared_space, update_attrs)

      assert shared_space.name == "Updated name"
    end

    test "update_shared_space/2 with invalid data returns error changeset" do
      shared_space = shared_space_fixture()
      assert {:error, %Ecto.Changeset{}} = Lobby.update_shared_space(shared_space, @invalid_attrs)
      assert shared_space == Lobby.get_shared_space!(shared_space.id)
    end

    test "delete_shared_space/1 deletes the shared_space" do
      shared_space = shared_space_fixture()
      assert {:ok, %SharedSpace{}} = Lobby.delete_shared_space(shared_space)
      assert_raise Ecto.NoResultsError, fn -> Lobby.get_shared_space!(shared_space.id) end
    end

    test "change_shared_space/1 returns a shared_space changeset" do
      shared_space = shared_space_fixture()
      assert %Ecto.Changeset{} = Lobby.change_shared_space(shared_space)
    end
  end
end
