defmodule CollabReactorWeb.UserView do
  use CollabReactorWeb, :view
  alias CollabReactorWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
    }
  end

  def render("users_group.json", %{users: users}) do
    %{data: render_many(users, CollabReactorWeb.UserView, "users.json")}
  end

  def render("users.json", %{user: user}) do
    %{username: user.username,
      profession: user.profession}
  end


end
