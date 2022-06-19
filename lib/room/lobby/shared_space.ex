defmodule Room.Lobby.SharedSpace do
  use Vax.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "shared_spaces" do
    field :name, :string
    field :clickable_counter, Vax.Types.Counter, default: 0
    field :present_users, Vax.Types.Counter, default: 0
    field :tags, Vax.Types.Set, type: :string

    timestamps()
  end

  def changeset(struct, attrs) do
    struct
    |> cast(attrs, [:name, :tags])
    |> put_new_name()
  end

  # TODO: autogenerate
  defp put_new_name(changeset) do
    case get_field(changeset, :name) do
      nil -> put_change(changeset, :name, FriendlyID.generate(4, separator: "-"))
      _name -> changeset
    end
  end

  def query_many(shared_space_ids) do
    from(__MODULE__)
    |> where([ss], ss.id in ^shared_space_ids)
  end
end
