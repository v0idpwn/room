defmodule Room.Lobby.SpaceList do
  use Vax.Schema
  import Ecto.Changeset
  import Ecto.Query

  @default_space_list_id "default_space_listt"

  # TODO: first off, sets, and then, associations
  schema "space_lists" do
    field :spaces, Vax.Types.Set, type: :string

    timestamps()
  end

  @doc false
  def changeset(space_list, attrs) do
    space_list
    |> cast(attrs, [:spaces])
    |> validate_required([:spaces])
  end

  def put_shared_space_change(space_list, space_id) do
    change(space_list, spaces: MapSet.put(space_list.spaces, space_id))
  end

  def default_space_list_changeset() do
    changeset(%__MODULE__{id: @default_space_list_id}, %{spaces: []})
  end

  def default_space_list_query() do
    from(__MODULE__, where: [id: @default_space_list_id])
  end
end
