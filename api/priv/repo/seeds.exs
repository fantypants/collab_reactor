# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#



changeset = Services.CollabReactor.User.registration_changeset(%Services.CollabReactor.User{}, %{email: "admin@gmail.com", username: "matthew", password: "password"})
CollabReactor.Repo.insert(changeset)
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
