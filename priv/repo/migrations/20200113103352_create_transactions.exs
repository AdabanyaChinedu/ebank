defmodule Ebank.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :description, :text
      add :debit_credit, :string
      add :avail_balance, :float
      add :curr_balance, :float
      add :status, :string
      add :amount, :float
      add :s_acct_no, :string
      add :s_acct_type, :string
      add :s_firstname, :string
      add :s_lastname, :string
      add :s_company_name, :string
      add :r_acct_no, :string
      add :r_acct_type, :string
      add :r_firstname, :string
      add :r_lastname, :string
      add :r_company_name, :string
      add :customer_id, references(:customers, on_delete: :nothing)

      timestamps()
    end

    create index(:transactions, [:customer_id])
  end
end
