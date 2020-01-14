defmodule Ebank.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
@derive {Jason.Encoder, only: [:id, :assignee, :ref_no, :subject, :email,:status, :inserted_at,]}
  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :phone_number, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password_hash, :phone_number])
    |> validate_required([:first_name, :last_name, :email, :password_hash, :phone_number])
  end
end
