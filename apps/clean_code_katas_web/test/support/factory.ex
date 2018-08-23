defmodule KatasWeb.Factory do
  use ExMachina.Ecto, repo: Katas.Repo

  def challenge_factory do
    %Katas.Challenges.Challenge{
      description:
        "This challenge is to do that and this. In order to do that you need to understand this. Good luck!",
      level: "Beginner",
      title: "Some cool challenge"
    }
  end

  def solution_factory do
    %Katas.Challenges.Solution{
      description:
        "I did this because I thought it was cool",
      code: "function hello() {\n\talert('Hello world!');\n}",
      user: build(:user),
      challenge: build(:challenge)
    }
  end

  def credential_factory do
    %Katas.Accounts.Credential{
      email: "tony@stark.com",
      token: "kdkd0dhdhd",
      provider: "github"
    }
  end

  def user_factory do
    %Katas.Accounts.User{
      name: "Tony Stark",
      credential: build(:credential)
    }
  end

  def solutions_factory do
    %Katas.Challenges.Solution{}
  end
end
