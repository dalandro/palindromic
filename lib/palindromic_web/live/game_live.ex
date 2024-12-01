defmodule PalindromicWeb.GameLive do
  use PalindromicWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :game_state, %{x: 0, y: 0})}
  end

  def handle_event("keydown", %{"key" => key}, socket) do
    # Update game state based on the key pressed
    new_game_state = update_game_state(socket.assigns.game_state, key)
    {:noreply, assign(socket, :game_state, new_game_state)}
  end

  defp update_game_state(game_state, key) do
    case key do
      "ArrowUp" -> Map.update(game_state, :y, 0, &(&1 - 1))
      "ArrowDown" -> Map.update(game_state, :y, 0, &(&1 + 1))
      "ArrowLeft" -> Map.update(game_state, :x, 0, &(&1 - 1))
      "ArrowRight" -> Map.update(game_state, :x, 0, &(&1 + 1))
      _ -> game_state
    end
  end
end
