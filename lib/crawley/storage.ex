defmodule Crawley.Storage do
  @callback upload_repo(String.t, String.t) ::  {:ok, term} | {:error, term}
end
