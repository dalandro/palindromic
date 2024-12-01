defmodule PalindromicWeb.GameLive do
  use PalindromicWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :arrows, [])}
  end

  def handle_event("keydown", %{"key" => key}, socket) do
    # Update game state based on the key pressed
    new_arrows = update_arrows(socket.assigns.arrows, key)
    {:noreply, assign(socket, :arrows, new_arrows)}
  end

  defp update_arrows(arrows, key) do
    case key do
      "ArrowUp" -> [%{type: "up", id: UUID.uuid4()} | arrows]
      "ArrowDown" -> [%{type: "down", id: UUID.uuid4()} | arrows]
      _ -> arrows
    end
  end
end
