defmodule CollabReactorWeb.GroupView do
  use CollabReactorWeb, :view

  def render("index.json", %{groups: groups}) do
    %{data: render_many(groups, CollabReactorWeb.GroupView, "group.json")}
  end

  def render("user_index.json", %{groups: groups}) do
    %{data: render_many(groups, CollabReactorWeb.GroupView, "user_group.json")}
  end

  def render("group_index.json", %{users: users}) do
    %{data: render_many(users, CollabReactorWeb.GroupView, "users.json")}
  end

  def render("show.json", %{group: group}) do
    %{data: render_one(group, CollabReactorWeb.GroupView, "group.json")}
  end

  def render("group.json", %{group: group}) do
    %{id: group.id,
      title: group.title}
  end

  def render("users.json", %{user: user}) do
    %{username: user.username,
      profession: user.profession}
  end

  def render("user_group.json", %{group: group}) do
    %{id: group.id,
      group: group.group_id}
  end
end
