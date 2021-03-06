defmodule Ebank.CustomerStore do

alias Ebank.Accounts.Account
alias Ebank.Accounts.Customer
alias Ebank.Transactions.Transaction


def list_customers_from_api do
    #{:ok, response} = HTTPoison.get "http://192.168.1.126:4007/api/customers/1" 
    {:ok, response} = HTTPoison.get "http://localhost:4007/api/customers/1"   
     Poison.decode! response.body
  end


def get_transaction_from_api(id) do
    #{:ok, response} = HTTPoison.get "http://192.168.1.126:4007/api/transactions/1" 
    {:ok, response} = HTTPoison.get ("http://localhost:4007/api/transactions/" <> to_string(id))
     %{"data" => output} = Poison.decode! response.body
     transaction = for {key, val} <- output, into: %{}, do: {String.to_atom(key), val}
     transaction
end


end



# {:ok, response} = HTTPoison.get "http://www.mocky.io/v2/5e1fd3653000002900d1ea66"