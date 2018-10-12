defmodule CollabReactorWeb.Channels.RoomChannel do
  use CollabReactorWeb, :channel
  alias CollabReactor.Repo
  import Ecto.Query

  def join("rooms:" <> room_id, _params, socket) do
    room = Repo.get!(CollabReactor.Services.Room, room_id)

    page =
      CollabReactor.Services.Message
      |> where([m], m.room_id == ^room.id)
      |> order_by([desc: :inserted_at, desc: :id])
      |> preload(:user)
      |> CollabReactor.Repo.paginate()

    response = %{
      room: Phoenix.View.render_one(room, CollabReactorWeb.RoomView, "room.json"),
      messages: Phoenix.View.render_many(page.entries, CollabReactorWeb.MessageView, "message.json"),
      pagination: CollabReactorWeb.PaginationHelpers.pagination(page)
    }

    {:ok, response, assign(socket, :room, room)}
  end

  def handle_in("new_message", params, socket) do
    changeset =
      socket.assigns.room
      |> Ecto.build_assoc(:messages, user_id: socket.assigns.current_user.id)
      |> CollabReactor.Services.Message.changeset(params)

    case Repo.insert(changeset) do
      {:ok, message} ->
        broadcast_message(socket, message)
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, {:error, Phoenix.View.render(CollabReactorWeb.ChangesetView, "error.json", changeset: changeset)}, socket}
    end
  end

  def handle_info(:after_join, socket) do
    CollabReactorWeb.Presence.track(socket, socket.assigns.current_user.id, %{
      user: Phoenix.View.render_one(socket.assigns.current_user, CollabReactorWeb.UserView, "user.json")
    })
    push(socket, "presence_state", Sling.Presence.list(socket))
    {:noreply, socket}
  end

  def terminate(_reason, socket) do
    {:ok, socket}
  end

  defp broadcast_message(socket, message) do
    message = Repo.preload(message, :user)
    rendered_message = Phoenix.View.render_one(message, CollabReactorWeb.MessageView, "message.json")
    broadcast!(socket, "message_created", rendered_message)
  end
end
