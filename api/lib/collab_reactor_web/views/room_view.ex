defmodule CollabReactorWeb.RoomView do
  use CollabReactorWeb, :view

  def render("index.json", %{rooms: rooms}) do
    %{data: render_many(rooms, CollabReactorWeb.RoomView, "room.json")}
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, CollabReactorWeb.RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{id: room.id,
      name: room.name,
      topic: room.topic}
  end
end
