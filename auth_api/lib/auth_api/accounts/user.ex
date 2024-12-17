defmodule AuthApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :unique, :string
    field :username, :string
    field :password, :string
    field :firstname, :string
    field :lastname, :string
    field :email, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :username, :unique, :password])
    |> validate_required([:firstname, :lastname, :email, :username, :unique, :password])
    |> unique_constraint(:email)
  end
end
