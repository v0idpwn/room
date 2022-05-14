defmodule RoomWeb.SpaceListLive do
  use Phoenix.LiveView

  alias Room.Lobby

  @impl true
  def mount(_params, _session, socket) do
    request_tick()
    {:ok, assign(socket, shared_spaces: Lobby.list_shared_spaces())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div class="row">
        <div class="column">
          <h3 class="h3">Available rooms:</h3>
        </div>
        <div class="column">
          <div class="clearfix">
            <button phx-click="create-space" class="button-large button float-right">+</button>
          </div>
        </div>
      </div>
      <%= if @shared_spaces == [] do %>
        No spaces yet. Try creating one.
      <% else %>
        <%= for shared_space <- @shared_spaces do %>
          <div class="row">
            <div class="column">
              <button phx-click="go-to-space" phx-value-space-id={shared_space.id} class="w-100 button-large button button-outline"><%= shared_space.name %></button>
            </div>
          </div>
        <% end %>
      <% end %>
    </div>
    """
  end

  @impl true
  def handle_event("go-to-space", %{"space-id" => id}, socket) do
    IO.inspect(id, label: :clicked_id)
    {:noreply, socket}
  end

  @impl true
  def handle_event("create-space", _params, socket) do
    {:ok, created_space} = Lobby.create_shared_space()
    {:noreply, assign(socket, shared_spaces: [created_space | socket.assigns.spaces])}
  end

  @impl true
  def handle_info(:tick, socket) do
    request_tick()
    {:noreply, assign(socket, shared_spaces: Lobby.list_shared_spaces())}
  end

  defp request_tick(), do: :erlang.send_after(5000, self(), :tick)
end
