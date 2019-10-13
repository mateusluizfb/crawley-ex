defmodule Crawley.LocalStorage do
  @behaviour Crawley.Storage

  @impl Crawley.Storage
  def upload_repo(remote_folder_name, repo_name) do
    zip_folder(repo_name)

    File.rename(
      "./tmp/#{repo_name}/#{repo_name}.zip",
      "./tmp/buckets/#{remote_folder_name}/#{repo_name}.zip"
    )
  end

  defp zip_folder(repo_name) do
    files = File.ls!("./tmp/#{repo_name}") |> Enum.map(&String.to_charlist/1)
    :zip.create("./tmp/#{repo_name}/#{repo_name}.zip", files)
  end
end
