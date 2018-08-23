# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Katas.Repo.insert!(%Katas.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Katas.Challenges.create_challenge(%{
  description:
    "This challenge is to do that and this. In order to do that you need to understand this. Good luck!",
  level: "Beginner",
  title: "Naming things and other stuff"
})
