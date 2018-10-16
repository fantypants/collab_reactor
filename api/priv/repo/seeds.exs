# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#



changeset1 = Services.CollabReactor.User.registration_changeset(%Services.CollabReactor.User{}, %{email: "admin@gmail.com", username: "matthew", password: "password", profession: "Software Engineer"})
changeset2 = Services.CollabReactor.User.registration_changeset(%Services.CollabReactor.User{}, %{email: "tom@gmail.com", username: "tom", password: "password", profession: "Designer"})
changeset3 = Services.CollabReactor.User.registration_changeset(%Services.CollabReactor.User{}, %{email: "nick@gmail.com", username: "nick", password: "password", profession: "Growth Hacker"})
CollabReactor.Repo.insert(changeset1)
CollabReactor.Repo.insert(changeset2)
CollabReactor.Repo.insert(changeset3)
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
changeset = CollabReactor.Services.Interest.changeset(%CollabReactor.Services.Interest{}, %{"title" => "Technology & Sports"})
CollabReactor.Repo.insert!(changeset)

changeset_interest1 = CollabReactor.Services.UserInterest.changeset(
  %CollabReactor.Services.UserInterest{},
  %{user_id: 1, interest_id: 1}
)
changeset_interest2 = CollabReactor.Services.UserInterest.changeset(
  %CollabReactor.Services.UserInterest{},
  %{user_id: 2, interest_id: 1}
)
changeset_interest3 = CollabReactor.Services.UserInterest.changeset(
  %CollabReactor.Services.UserInterest{},
  %{user_id: 3, interest_id: 1}
)
CollabReactor.Repo.insert!(changeset_interest1)
CollabReactor.Repo.insert!(changeset_interest2)
CollabReactor.Repo.insert!(changeset_interest3)
