defmodule CollabReactorWeb.DirectMessageController do
  use CollabReactorWeb, :controller
  alias CollabReactor.Repo
  alias CollabReactor.Services.UserMessage
  import Ecto.Query

  def format_and_insert(list) do
    list |> Enum.map(fn user ->
      map = %{"user_id" => user.user_id,
        "group" => user.group_id,
        "body" => "You've been selected to join the group"
      }
      create_private_message(map)
    end)
  end

  defp create_private_message(params) do
    changeset = UserMessage.changeset(%UserMessage{}, params)

    case Repo.insert(changeset) do
      {:ok, message} ->
      {:ok, message}
      {:error, changeset} ->
        IO.inspect changeset
      {:error, changeset}
    end
  end

end
