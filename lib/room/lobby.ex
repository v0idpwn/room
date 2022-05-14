defmodule Room.Lobby do
  @moduledoc """
  The Lobby context.
  """

  alias Room.Repo

  alias Room.Lobby.SharedSpace

  @doc """
  Returns the list of shared_spaces.

  ## Examples

      iex> list_shared_spaces()
      [%SharedSpace{}, ...]

  """
  def list_shared_spaces do
    Repo.all(SharedSpace)
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
  Creates a shared_space.

  ## Examples

      iex> create_shared_space(%{field: value})
      {:ok, %SharedSpace{}}

      iex> create_shared_space(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shared_space(attrs \\ %{}) do
    %SharedSpace{}
    |> SharedSpace.changeset(attrs)
    |> Repo.insert()
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
