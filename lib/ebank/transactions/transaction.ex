defmodule Ebank.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
@derive {Jason.Encoder, only: [:id, :amount, :avail_balance,  :curr_balance,  :debit_credit, :description, :r_acct_no, :r_acct_type,  :r_company_name, :r_firstname, :r_lastname, 
     :s_acct_no, :s_acct_type, :s_company_name, :s_firstname, :s_lastname, :status,:inserted_at,]}
     
 
  schema "transactions" do
    field :amount, :float
    field :avail_balance, :float
    field :curr_balance, :float
    field :debit_credit, :string
    field :description, :string
    field :r_acct_no, :string
    field :r_acct_type, :string
    field :r_company_name, :string
    field :r_firstname, :string
    field :r_lastname, :string
    field :s_acct_no, :string
    field :s_acct_type, :string
    field :s_company_name, :string
    field :s_firstname, :string
    field :s_lastname, :string
    field :status, :string
    field :customer_id, :id
  
    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:description, :debit_credit, :avail_balance, :curr_balance, :status, :amount, :s_acct_no, :s_acct_type, :s_firstname, :s_lastname, :s_company_name, :r_acct_no, :r_acct_type, :r_firstname, :r_lastname, :r_company_name])
    |> validate_required([:description, :debit_credit, :avail_balance, :curr_balance, :status, :amount, :s_acct_no, :s_acct_type, :s_firstname, :s_lastname, :s_company_name, :r_acct_no, :r_acct_type, :r_firstname, :r_lastname, :r_company_name])
  end
end
