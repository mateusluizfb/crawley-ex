defmodule Crawley.Storage do
  @callback upload_repo(String.t, String.t) ::  {:ok, term} | {:error, term}

  def zip_folder(repo_name) do
    path = "./tmp/#{repo_name}"
    files = File.ls!(path)
            |> Enum.map(fn filename -> Path.join(path, filename) end)
            |> Enum.map(&String.to_charlist/1)

    :zip.create("./tmp/#{repo_name}/#{repo_name}.zip", files)
  end
end
