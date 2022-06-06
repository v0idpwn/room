defmodule Room.Lobby do
  @moduledoc """
  The Lobby context.
  """

  alias Room.Repo

  alias Room.Lobby.SharedSpace
  alias Room.Lobby.SpaceList

  @doc """
  Creates the default space list if it doens't exist
  """
  def setup!() do
    SpaceList.default_space_list_query()
    |> Repo.one()
    |> case do
      nil ->
        SpaceList.default_space_list_changeset()
        |> Repo.insert!()

      _ ->
        :ok
    end

    :ok
  end

  @doc """
  Returns the list of shared_spaces.

  ## Examples

      iex> list_shared_spaces()
      [%SharedSpace{}, ...]

  """
  def list_shared_spaces do
    SpaceList.default_space_list_query()
    |> Repo.one!()
    |> Map.fetch!(:spaces)
    |> Enum.to_list()
    |> SharedSpace.query_many()
    |> Repo.all()
  end

  @doc """
  Gets a single shared_space.

  Raises `Ecto.NoResultsError` if the Shared space does not exist.

  ## Examples

      iex> get_shared_space!(123)
      %SharedSpace{}

      iex> get_shared_space!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shared_space!(id), do: Repo.get!(SharedSpace, id)

  @doc """
  Reloads a shared space
  """
  def reload_shared_space!(shared_space), do: Repo.reload!(shared_space)

  @doc """
  Creates a shared_space.

  ## Examples

      iex> create_shared_space(%{field: value})
      {:ok, %SharedSpace{}}

      iex> create_shared_space(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shared_space(attrs \\ %{}) do
    # TODO: transaction
    with changeset = SharedSpace.changeset(%SharedSpace{}, attrs),
         {:ok, shared_space} <- Repo.insert(changeset),
         {:ok, _space_list} <- insert_space_in_space_list(shared_space) do
      {:ok, shared_space}
    end
  end

  def insert_space_in_space_list(%SharedSpace{id: shared_space_id}) do
    SpaceList.default_space_list_query()
    |> Repo.one!()
    |> SpaceList.put_shared_space_change(shared_space_id)
    |> Repo.update()
  end

  def update_shared_space(%Ecto.Changeset{data: %SharedSpace{}} = changeset) do
    Repo.update(changeset)
  end

  @doc """
  Updates a shared_space.

  ## Examples

      iex> update_shared_space(shared_space, %{field: new_value})
      {:ok, %SharedSpace{}}

      iex> update_shared_space(shared_space, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shared_space(%SharedSpace{} = shared_space, attrs) do
    shared_space
    |> SharedSpace.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shared_space.

  ## Examples

      iex> delete_shared_space(shared_space)
      {:ok, %SharedSpace{}}

      iex> delete_shared_space(shared_space)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shared_space(%SharedSpace{} = shared_space) do
    Repo.delete(shared_space)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shared_space changes.

  ## Examples

      iex> change_shared_space(shared_space)
      %Ecto.Changeset{data: %SharedSpace{}}

  """
  def change_shared_space(%SharedSpace{} = shared_space, attrs \\ %{}) do
    SharedSpace.changeset(shared_space, attrs)
  end
end
