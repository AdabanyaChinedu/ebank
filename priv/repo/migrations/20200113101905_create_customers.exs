defmodule Ebank.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :first_name, :string
      add :last_name, :string
      add :account_type, :string
      add :c_balance, :float
      add :a_balance, :float
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:customers, [:user_id])
  end
end
