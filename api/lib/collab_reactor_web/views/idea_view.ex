defmodule CollabReactorWeb.IdeaView do
  use CollabReactorWeb, :view

  def render("index.json", %{ideas: ideas}) do
    %{data: render_many(ideas, CollabReactorWeb.IdeaView, "idea.json")}
  end

  def render("show.json", %{idea: idea}) do
    %{data: render_one(idea, CollabReactorWeb.IdeaView, "idea.json")}
  end

  def render("idea.json", %{idea: idea}) do
    %{id: idea.id,
      name: idea.name,
      difficulty: idea.difficulty,
      appeal: idea.appeal,
      time: idea.time}
  end
end
