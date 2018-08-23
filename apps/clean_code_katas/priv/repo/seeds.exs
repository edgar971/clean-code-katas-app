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
{:ok, challenge} =
  Katas.Challenges.create_challenge(%{
    description:
      "This challenge is to do that and this. In order to do that you need to understand this. Good luck!",
    level: "Beginner",
    title: "Naming things and other stuff"
  })

{:ok, user} =
  Katas.Accounts.create_user(%{
    name: "Edgar Pino"
  })

Katas.Repo.insert(%Katas.Challenges.Solution{
  user_id: user.id,
  challenge_id: challenge.id,
  description: "I did this because I remember this",
  code: "function hello() {\n\talert('Hello world!');\n}"
})
