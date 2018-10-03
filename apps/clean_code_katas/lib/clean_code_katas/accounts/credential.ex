defmodule Katas.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Katas.Accounts.User

  schema "credentials" do
    field(:email, :string)
    field(:token, :string)
    field(:provider, :string)
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :token, :provider])
    |> cast_assoc(:user)
    |> validate_required([:email, :token, :provider])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
