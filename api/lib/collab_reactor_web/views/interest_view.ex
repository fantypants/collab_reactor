defmodule CollabReactorWeb.InterestView do
  use CollabReactorWeb, :view

  def render("index.json", %{interests: interests}) do
    %{data: render_many(interests, CollabReactorWeb.InterestView, "interest.json")}
  end

  def render("show.json", %{interest: interest}) do
    %{data: render_one(interest, CollabReactorWeb.InterestView, "interest.json")}
  end

  def render("user_interest_show.json", %{interest: interest}) do
    %{data: render_one(interest, CollabReactorWeb.InterestView, "user_interest.json")}
  end

  def render("interest.json", %{interest: interest}) do
    %{id: interest.id,
      title: interest.title}
  end

  def render("user_interest.json", %{interest: interest}) do
    %{id: interest.id}
  end
end
