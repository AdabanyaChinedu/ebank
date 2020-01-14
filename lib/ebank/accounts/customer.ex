defmodule Ebank.Accounts.Customer do
  use Ecto.Schema
  import Ecto.Changeset
@derive {Jason.Encoder, only: [:id, :assignee, :ref_no, :subject, :email,:status, :inserted_at,]}
  schema "customers" do
    field :a_balance, :float
    field :account_type, :string
    field :c_balance, :float
    field :first_name, :string
    field :last_name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:first_name, :last_name, :account_type, :c_balance, :a_balance])
    |> validate_required([:first_name, :last_name, :account_type, :c_balance, :a_balance])
  end
end
