defmodule Ebank.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
@derive {Jason.Encoder, only: [:id, :amount, :avail_balance,  :curr_balance,  :debit_credit, :description, :r_acct_no, :r_acct_type,  :r_company_name, :r_firstname, :r_lastname, 
     :s_acct_no, :s_acct_type, :s_company_name, :s_firstname, :s_lastname, :status,:inserted_at,]}
     
 
  schema "transactions" do
    field :amount, :string
    field :available_balance, :string
    field :current_balance, :string
    field :debit_credit, :string
    field :description, :string
    field :recipient_account_number, :string
    field :recipient_company_name, :string
    field :recipient_firstname, :string
    field :recipient_lastname, :string
    field :recipient_name, :string
    field :sender_account_number, :string
    field :sender_company_name, :string
    field :sender_firstname, :string
    field :sender_lastname, :string
    field :sender_name, :string
    field :status, :string
    field :account_id, :id

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :available_balance, :current_balance, :debit_credit, :description, :recipient_account_number, :recipient_company_name,
    :recipient_firstname, :recipient_lastname, :recipient_name, :sender_account_number, :sender_company_name,
    :sender_firstname, :sender_lastname, :sender_name, :status, :account_id ])
    |> validate_required([:amount, :available_balance, :current_balance, :debit_credit, :description, :recipient_account_number, :recipient_company_name,
    :recipient_firstname, :recipient_lastname, :recipient_name, :sender_account_number, :sender_company_name,
    :sender_firstname, :sender_lastname, :sender_name, :status, :account_id ])
  end
end
