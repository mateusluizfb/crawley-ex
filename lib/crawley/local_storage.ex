defmodule Crawley.LocalStorage do
  @behaviour Crawley.Storage

  @impl Crawley.Storage
  def upload_repo(remote_folder_name, repo_name) do
    Crawley.Storage.zip_folder(repo_name)

    File.rename(
      "./code/#{repo_name}/#{repo_name}.zip",
      "./code/#{repo_name}.zip"
    )
  end
end
