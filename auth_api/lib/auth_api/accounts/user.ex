defmodule AuthApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
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
    |> cast(attrs, [:firstname, :lastname, :email, :username,  :password])
    |> validate_required([:firstname, :lastname, :email, :username,  :password])
    |> unique_constraint(:email)
  end


  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :username, :password])
    |> validate_required([:firstname, :lastname, :email, :username, :password])
    |> unique_constraint(:email)
    |> hash_password()
  end


  defp hash_password(user) do
    with password <- fetch_field!(user, :password) do
      encrypted_password = Bcrypt.Base.hash_password(password, Bcrypt.gen_salt(12,true))
      put_change(user,:password, encrypted_password)
    end
  end
end
