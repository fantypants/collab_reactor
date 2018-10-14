defmodule Services.CollabReactor.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
   field :username, :string
   field :profession, :string
   field :email, :string
   field :password, :string, virtual: true
   field :password_hash, :string
   field :interest, :string

   many_to_many :rooms, CollabReactor.Services.Room, join_through: "user_rooms"
   many_to_many :interests, CollabReactor.Services.Interest, join_through: "user_interests"
   many_to_many :groups, CollabReactor.Services.Group, join_through: "user_groups"
   has_many :messages, CollabReactor.Services.Message

   timestamps()
 end

 def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :profession, :interest])
    |> cast_assoc(:messages)
    |> validate_required([:username, :email, :profession])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast_assoc(:messages)
    |> cast(params, [:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
