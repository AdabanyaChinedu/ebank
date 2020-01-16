defmodule Ebank.Accounts.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :company_name, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    has_many :accounts, Account
    has_many :transactions, through: [:accounts, :transactions]


    timestamps()
  end


  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:first_name, :last_name, :phone_number, :email, :company_name, :accounts, :transactions])
    |> validate_required([:first_name, :last_name, :phone_number, :email, :company_name, :accounts, :transactions])
  end
end
