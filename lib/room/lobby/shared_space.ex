defmodule Room.Lobby.SharedSpace do
  use Vax.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "shared_spaces" do
    field :name, :string
    field :clickable_counter, Vax.Types.Counter
    field :present_users, Vax.Types.Counter

    timestamps()
  end

  def changeset(struct, attrs) do
    struct
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def query_many(shared_space_ids) do
    from(__MODULE__)
    |> where([ss], ss.id in ^shared_space_ids)
  end
end
