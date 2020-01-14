defmodule EbankWeb.CustomerControllerTest do
  use EbankWeb.ConnCase

  alias Ebank.Accounts

  @create_attrs %{a_balance: "some a_balance", account_type: "some account_type", c_balance: "some c_balance", first_name: "some first_name", last_name: "some last_name"}
  @update_attrs %{a_balance: "some updated a_balance", account_type: "some updated account_type", c_balance: "some updated c_balance", first_name: "some updated first_name", last_name: "some updated last_name"}
  @invalid_attrs %{a_balance: nil, account_type: nil, c_balance: nil, first_name: nil, last_name: nil}

  def fixture(:customer) do
    {:ok, customer} = Accounts.create_customer(@create_attrs)
    customer
  end

  describe "index" do
    test "lists all customers", %{conn: conn} do
      conn = get(conn, Routes.customer_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Customers"
    end
  end

  describe "new customer" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.customer_path(conn, :new))
      assert html_response(conn, 200) =~ "New Customer"
    end
  end

  describe "create customer" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.customer_path(conn, :create), customer: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.customer_path(conn, :show, id)

      conn = get(conn, Routes.customer_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Customer"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.customer_path(conn, :create), customer: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Customer"
    end
  end

  describe "edit customer" do
    setup [:create_customer]

    test "renders form for editing chosen customer", %{conn: conn, customer: customer} do
      conn = get(conn, Routes.customer_path(conn, :edit, customer))
      assert html_response(conn, 200) =~ "Edit Customer"
    end
  end

  describe "update customer" do
    setup [:create_customer]

    test "redirects when data is valid", %{conn: conn, customer: customer} do
      conn = put(conn, Routes.customer_path(conn, :update, customer), customer: @update_attrs)
      assert redirected_to(conn) == Routes.customer_path(conn, :show, customer)

      conn = get(conn, Routes.customer_path(conn, :show, customer))
      assert html_response(conn, 200) =~ "some updated a_balance"
    end

    test "renders errors when data is invalid", %{conn: conn, customer: customer} do
      conn = put(conn, Routes.customer_path(conn, :update, customer), customer: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Customer"
    end
  end

  describe "delete customer" do
    setup [:create_customer]

    test "deletes chosen customer", %{conn: conn, customer: customer} do
      conn = delete(conn, Routes.customer_path(conn, :delete, customer))
      assert redirected_to(conn) == Routes.customer_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.customer_path(conn, :show, customer))
      end
    end
  end

  defp create_customer(_) do
    customer = fixture(:customer)
    {:ok, customer: customer}
  end
end
