defmodule Ebank.TransactionsTest do
  use Ebank.DataCase

  alias Ebank.Transactions

  describe "transactions" do
    alias Ebank.Transactions.Transaction

    @valid_attrs %{amount: 120.5, avail_balance: 120.5, curr_balance: 120.5, debit_credit: "some debit_credit", description: "some description", r_acct_no: "some r_acct_no", r_acct_type: "some r_acct_type", r_company_name: "some r_company_name", r_firstname: "some r_firstname", r_lastname: "some r_lastname", s_acct_no: "some s_acct_no", s_acct_type: "some s_acct_type", s_company_name: "some s_company_name", s_firstname: "some s_firstname", s_lastname: "some s_lastname", status: "some status"}
    @update_attrs %{amount: 456.7, avail_balance: 456.7, curr_balance: 456.7, debit_credit: "some updated debit_credit", description: "some updated description", r_acct_no: "some updated r_acct_no", r_acct_type: "some updated r_acct_type", r_company_name: "some updated r_company_name", r_firstname: "some updated r_firstname", r_lastname: "some updated r_lastname", s_acct_no: "some updated s_acct_no", s_acct_type: "some updated s_acct_type", s_company_name: "some updated s_company_name", s_firstname: "some updated s_firstname", s_lastname: "some updated s_lastname", status: "some updated status"}
    @invalid_attrs %{amount: nil, avail_balance: nil, curr_balance: nil, debit_credit: nil, description: nil, r_acct_no: nil, r_acct_type: nil, r_company_name: nil, r_firstname: nil, r_lastname: nil, s_acct_no: nil, s_acct_type: nil, s_company_name: nil, s_firstname: nil, s_lastname: nil, status: nil}

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transactions.create_transaction()

      transaction
    end

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Transactions.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Transactions.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      assert {:ok, %Transaction{} = transaction} = Transactions.create_transaction(@valid_attrs)
      assert transaction.amount == 120.5
      assert transaction.avail_balance == 120.5
      assert transaction.curr_balance == 120.5
      assert transaction.debit_credit == "some debit_credit"
      assert transaction.description == "some description"
      assert transaction.r_acct_no == "some r_acct_no"
      assert transaction.r_acct_type == "some r_acct_type"
      assert transaction.r_company_name == "some r_company_name"
      assert transaction.r_firstname == "some r_firstname"
      assert transaction.r_lastname == "some r_lastname"
      assert transaction.s_acct_no == "some s_acct_no"
      assert transaction.s_acct_type == "some s_acct_type"
      assert transaction.s_company_name == "some s_company_name"
      assert transaction.s_firstname == "some s_firstname"
      assert transaction.s_lastname == "some s_lastname"
      assert transaction.status == "some status"
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{} = transaction} = Transactions.update_transaction(transaction, @update_attrs)
      assert transaction.amount == 456.7
      assert transaction.avail_balance == 456.7
      assert transaction.curr_balance == 456.7
      assert transaction.debit_credit == "some updated debit_credit"
      assert transaction.description == "some updated description"
      assert transaction.r_acct_no == "some updated r_acct_no"
      assert transaction.r_acct_type == "some updated r_acct_type"
      assert transaction.r_company_name == "some updated r_company_name"
      assert transaction.r_firstname == "some updated r_firstname"
      assert transaction.r_lastname == "some updated r_lastname"
      assert transaction.s_acct_no == "some updated s_acct_no"
      assert transaction.s_acct_type == "some updated s_acct_type"
      assert transaction.s_company_name == "some updated s_company_name"
      assert transaction.s_firstname == "some updated s_firstname"
      assert transaction.s_lastname == "some updated s_lastname"
      assert transaction.status == "some updated status"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_transaction(transaction, @invalid_attrs)
      assert transaction == Transactions.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Transactions.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Transactions.change_transaction(transaction)
    end
  end
end
