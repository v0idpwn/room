defmodule RoomWeb.SpaceLive do
  use RoomWeb, :live_view

  alias Room.Lobby
  alias Vax.Types.Counter

  @impl true
  def mount(%{"shared_space_id" => id}, _session, socket) do
    request_tick()

    if connected?(socket) do
      {:ok, shared_space} =
        id
        |> Lobby.get_shared_space!()
        |> Counter.cast_increment(:present_users, 1)
        |> Lobby.update_shared_space()

      Process.flag(:trap_exit, true)

      {:ok, assign(socket, shared_space: shared_space)}
    else
      {:ok, assign(socket, shared_space: Lobby.get_shared_space!(id))}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <h3 class="h3"><%= @shared_space.name %></h3>
      <div class="row">
        <div class="column">
          Counter: <%= @shared_space.clickable_counter %>
        </div>
        <div class="column">
          <button phx-click="increment" class="button">+</button>
          <button phx-click="decrement" class="button">-</button>
        </div>
      </div>
      <div class="row">
        <div class="column">
          People on this space: <%= @shared_space.present_users %>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("increment", _params, socket) do
    {:ok, shared_space} =
      socket.assigns.shared_space
      |> Counter.cast_increment(:clickable_counter, 1)
      |> Lobby.update_shared_space()

    {:noreply, assign(socket, shared_space: shared_space)}
  end

  @impl true
  def handle_event("decrement", _params, socket) do
    {:ok, shared_space} =
      socket.assigns.shared_space
      |> Counter.cast_decrement(:clickable_counter, 1)
      |> Lobby.update_shared_space()

    {:noreply, assign(socket, shared_space: shared_space)}
  end

  @impl true
  def handle_info(:tick, socket) do
    request_tick()
    {:noreply, update(socket, :shared_space, &Lobby.reload_shared_space!/1)}
  end

  @impl true
  def terminate(_reason, socket) do
    socket.assigns.shared_space
    |> Counter.cast_decrement(:present_users, 1)
    |> Lobby.update_shared_space()

    :ok
  end

  defp request_tick(), do: :erlang.send_after(5000, self(), :tick)
end
