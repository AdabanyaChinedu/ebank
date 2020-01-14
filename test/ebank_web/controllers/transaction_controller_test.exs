defmodule EbankWeb.TransactionControllerTest do
  use EbankWeb.ConnCase

  alias Ebank.Transactions

  @create_attrs %{amount: 120.5, avail_balance: 120.5, curr_balance: 120.5, debit_credit: "some debit_credit", description: "some description", r_acct_no: "some r_acct_no", r_acct_type: "some r_acct_type", r_company_name: "some r_company_name", r_firstname: "some r_firstname", r_lastname: "some r_lastname", s_acct_no: "some s_acct_no", s_acct_type: "some s_acct_type", s_company_name: "some s_company_name", s_firstname: "some s_firstname", s_lastname: "some s_lastname", status: "some status"}
  @update_attrs %{amount: 456.7, avail_balance: 456.7, curr_balance: 456.7, debit_credit: "some updated debit_credit", description: "some updated description", r_acct_no: "some updated r_acct_no", r_acct_type: "some updated r_acct_type", r_company_name: "some updated r_company_name", r_firstname: "some updated r_firstname", r_lastname: "some updated r_lastname", s_acct_no: "some updated s_acct_no", s_acct_type: "some updated s_acct_type", s_company_name: "some updated s_company_name", s_firstname: "some updated s_firstname", s_lastname: "some updated s_lastname", status: "some updated status"}
  @invalid_attrs %{amount: nil, avail_balance: nil, curr_balance: nil, debit_credit: nil, description: nil, r_acct_no: nil, r_acct_type: nil, r_company_name: nil, r_firstname: nil, r_lastname: nil, s_acct_no: nil, s_acct_type: nil, s_company_name: nil, s_firstname: nil, s_lastname: nil, status: nil}

  def fixture(:transaction) do
    {:ok, transaction} = Transactions.create_transaction(@create_attrs)
    transaction
  end

  describe "index" do
    test "lists all transactions", %{conn: conn} do
      conn = get(conn, Routes.transaction_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Transactions"
    end
  end

  describe "new transaction" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.transaction_path(conn, :new))
      assert html_response(conn, 200) =~ "New Transaction"
    end
  end

  describe "create transaction" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.transaction_path(conn, :create), transaction: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.transaction_path(conn, :show, id)

      conn = get(conn, Routes.transaction_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Transaction"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.transaction_path(conn, :create), transaction: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Transaction"
    end
  end

  describe "edit transaction" do
    setup [:create_transaction]

    test "renders form for editing chosen transaction", %{conn: conn, transaction: transaction} do
      conn = get(conn, Routes.transaction_path(conn, :edit, transaction))
      assert html_response(conn, 200) =~ "Edit Transaction"
    end
  end

  describe "update transaction" do
    setup [:create_transaction]

    test "redirects when data is valid", %{conn: conn, transaction: transaction} do
      conn = put(conn, Routes.transaction_path(conn, :update, transaction), transaction: @update_attrs)
      assert redirected_to(conn) == Routes.transaction_path(conn, :show, transaction)

      conn = get(conn, Routes.transaction_path(conn, :show, transaction))
      assert html_response(conn, 200) =~ "some updated debit_credit"
    end

    test "renders errors when data is invalid", %{conn: conn, transaction: transaction} do
      conn = put(conn, Routes.transaction_path(conn, :update, transaction), transaction: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Transaction"
    end
  end

  describe "delete transaction" do
    setup [:create_transaction]

    test "deletes chosen transaction", %{conn: conn, transaction: transaction} do
      conn = delete(conn, Routes.transaction_path(conn, :delete, transaction))
      assert redirected_to(conn) == Routes.transaction_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.transaction_path(conn, :show, transaction))
      end
    end
  end

  defp create_transaction(_) do
    transaction = fixture(:transaction)
    {:ok, transaction: transaction}
  end
end
