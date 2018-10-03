defmodule Katas.AccountsTest do
  use Katas.DataCase

  alias Katas.Accounts
  alias Katas.Repo

  describe "users" do
    alias Katas.Accounts.User

    @valid_attrs %{name: "Edgar Pino"}
    @valid_with_credentials_attrs %{
      name: "Edgar Pino",
      credential: %{email: "test@me.com", token: "12345678910", provider: "github"}
    }
    @update_attrs %{name: "Edgar Beltran"}
    @invalid_attrs %{name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user |> Repo.preload(:credential)
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture(@valid_attrs)
      assert Accounts.get_user!(user.id) == user
    end

    test "get_user!/1 returns the user and credentials with given id" do
      user = user_fixture(@valid_with_credentials_attrs)

      user_account = Accounts.get_user!(user.id)
      assert user_account.name == "Edgar Pino"
      assert user_account.credential.email == @valid_with_credentials_attrs.credential.email
      assert user_account.credential.token == @valid_with_credentials_attrs.credential.token
      assert user_account.credential.provider == @valid_with_credentials_attrs.credential.provider
    end

    test "get_user_by_email/1 returns the user given an email" do
      existing_user = user_fixture(@valid_with_credentials_attrs)

      assert %User{} = user = Accounts.get_user_by_email(existing_user.credential.email)
      assert user.credential.email == existing_user.credential.email
      assert user.credential.token == existing_user.credential.token
      assert user.credential.provider == existing_user.credential.provider
    end

    test "get_user_by_email/1 returns nil given non-existing email" do
      assert Accounts.get_user_by_email("test@me.com") == nil
    end

    test "create_or_update_user/1 with valid data and credentials for new user" do
      assert {:ok, %User{} = user} = Accounts.create_or_update_user(@valid_with_credentials_attrs)
      assert user.credential.email == @valid_with_credentials_attrs.credential.email
      assert user.credential.token == @valid_with_credentials_attrs.credential.token
      assert user.credential.provider == @valid_with_credentials_attrs.credential.provider
    end

    test "create_or_update_user/1 with valid data and credentials for existing user" do
      existing_user = user_fixture(@valid_with_credentials_attrs)

      updated_user = %{
        @valid_with_credentials_attrs
        | credential: %{@valid_with_credentials_attrs.credential | token: "sometoken"}
      }

      assert {:ok, %User{} = user} = Accounts.create_or_update_user(updated_user)

      assert user.id == existing_user.id
      assert user.credential.email == @valid_with_credentials_attrs.credential.email
      assert user.credential.token == updated_user.credential.token
      assert user.credential.provider == @valid_with_credentials_attrs.credential.provider
    end

    test "create_user/1 with valid data and credentials" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_with_credentials_attrs)
      assert user.name == "Edgar Pino"
      assert user.credential.email == @valid_with_credentials_attrs.credential.email
      assert user.credential.token == @valid_with_credentials_attrs.credential.token
      assert user.credential.provider == @valid_with_credentials_attrs.credential.provider
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.name == "Edgar Beltran"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "credentials" do
    alias Katas.Accounts.Credential

    @valid_attrs %{email: "test@me.com", token: "dfdfdfdfd", provider: "github"}
    @update_attrs %{email: "b@test.com", token: "dfldodie3s", provider: "github"}
    @invalid_attrs %{email: nil, token: nil, provider: nil}

    def credential_fixture(attrs \\ %{}) do
      {:ok, credential} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_credential()

      credential
    end

    def credentials_with_user() do
      %{user: %{name: "Edgar Pino"}}
      |> Enum.into(@valid_attrs)
    end

    test "create_credential/1 with valid data creates a credential" do
      assert {:ok, %Credential{} = credential} =
               Accounts.create_credential(credentials_with_user())

      assert credential.email == "test@me.com"
      assert credential.token == @valid_attrs.token
      assert credential.provider == @valid_attrs.provider
    end

    test "create_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_credential(@invalid_attrs)
    end

    test "update_credential/2 with valid data updates the credential" do
      credential = credentials_with_user() |> credential_fixture()
      assert {:ok, credential} = Accounts.update_credential(credential, @update_attrs)
      assert %Credential{} = credential
      assert credential.email == "b@test.com"
      assert credential.token == @update_attrs.token
      assert credential.provider == @update_attrs.provider
    end

    test "update_credential/2 with invalid data returns error changeset" do
      credential = credentials_with_user() |> credential_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_credential(credential, @invalid_attrs)

      credentials_record = Accounts.get_credential!(credential.id)
      assert credential.email == credentials_record.email
      assert credential.token == credentials_record.token
    end

    test "delete_credential/1 deletes the credential" do
      credential = credentials_with_user() |> credential_fixture()
      assert {:ok, %Credential{}} = Accounts.delete_credential(credential)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_credential!(credential.id) end
    end

    test "change_credential/1 returns a credential changeset" do
      credential = credentials_with_user() |> credential_fixture()
      assert %Ecto.Changeset{} = Accounts.change_credential(credential)
    end
  end
end
