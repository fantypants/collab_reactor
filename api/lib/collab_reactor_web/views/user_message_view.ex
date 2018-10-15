defmodule CollabReactorWeb.UserMessageView do
use CollabReactorWeb, :view


def render("index.json", %{messages: messages}) do
  %{
    data: render_many(messages, CollabReactorWeb.UserMessageView, "message.json", as: :message)
    #data: [%{id: 1, body: "NEW", group: 1},%{id: 2, body: "NEW", group: 1}]
  }
end

  def render("message.json", %{message: message}) do
    %{
      id: message.id,
      body: message.body,
      group: message.group,
      user_id: message.user_id
    }
  end
end
