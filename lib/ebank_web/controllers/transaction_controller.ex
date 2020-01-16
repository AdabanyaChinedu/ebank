defmodule EbankWeb.TransactionController do
  use EbankWeb, :controller

  alias Ebank.Transactions
  alias Ebank.Transactions.Transaction
  alias Ebank.CustomerStore

  def index(conn, _params) do
    #transactions = Transactions.list_transactions()
    #render(conn, "index.html", transactions: transactions)
    render(conn, "index.html")
  end

 def index_api(conn, params) do                      
       json(conn, CustomerStore.list_customers_from_api)
  end
  


  def new(conn, _params) do
    # changeset = Transactions.change_transaction(%Transaction{})
    # render(conn, "new.html", changeset: changeset)
     render(conn, "new.html")
  end

  def create(conn, %{"transaction" => transaction_params}) do
    case Transactions.create_transaction(transaction_params) do
      {:ok, transaction} ->
        conn
        |> put_flash(:info, "Transaction created successfully.")
        |> redirect(to: Routes.transaction_path(conn, :show, transaction))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    # transaction = Transactions.get_transaction!(id)
    # render(conn, "show.html", transaction: transaction)
    render(conn, "show.html")
  end

  def edit(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)
    changeset = Transactions.change_transaction(transaction)
    render(conn, "edit.html", transaction: transaction, changeset: changeset)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Transactions.get_transaction!(id)

    case Transactions.update_transaction(transaction, transaction_params) do
      {:ok, transaction} ->
        conn
        |> put_flash(:info, "Transaction updated successfully.")
        |> redirect(to: Routes.transaction_path(conn, :show, transaction))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", transaction: transaction, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)
    {:ok, _transaction} = Transactions.delete_transaction(transaction)

    conn
    |> put_flash(:info, "Transaction deleted successfully.")
    |> redirect(to: Routes.transaction_path(conn, :index))
  end
end
