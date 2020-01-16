defmodule Ebank.CustomerStore do

def list_customers_from_api do
    # {:ok, response} = HTTPoison.get "http://192.168.1.126:4007/api/customers/1" 
     {:ok, response} = HTTPoison.get "http://www.mocky.io/v2/5e1fd3653000002900d1ea66"
     Poison.decode! response.body
  end


end