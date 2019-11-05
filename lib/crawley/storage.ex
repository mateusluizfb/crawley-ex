defmodule Crawley.Storage do
  @callback upload_repo(String.t, String.t) ::  {:ok, term} | {:error, term}

  def zip_folder(repo_name) do
    files = File.ls!("./tmp/#{repo_name}") |> Enum.map(&String.to_charlist/1)
    :zip.create("./tmp/#{repo_name}/#{repo_name}.zip", files)
  end
end
