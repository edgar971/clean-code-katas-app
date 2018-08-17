defmodule KatasWeb.Factory do
  use ExMachina.Ecto, repo: Katas.Repo

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
end
