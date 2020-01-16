defmodule Ebank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ebank.Accounts.Transaction

  schema "accounts" do
    field :account_name, :string
    field :account_number, :string
    field :account_type, :string
    field :available_balance, :string
    field :current_balance, :string
    field :customer_id, :id
    has_many :transactions, Transaction

    timestamps()
  end


  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:account_name, :account_number, :account_type, :current_balance, :available_balance])
    |> validate_required([:account_name, :account_number, :account_type, :current_balance, :available_balance])
  end
end
