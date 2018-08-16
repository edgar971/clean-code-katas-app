defmodule Katas.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Katas.Accounts.User

  @comeonin Application.get_env(:clean_code_katas, :comeonin)

  schema "credentials" do
    field(:email, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 10, max: 25)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, @comeonin.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
