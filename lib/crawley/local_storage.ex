defmodule Crawley.LocalStorage do
  @behaviour Crawley.Storage

  @impl Crawley.Storage
  def upload_repo(remote_folder_name, repo_name) do
    Crawley.Storage.zip_folder(repo_name)

    File.rename(
      "./tmp/#{repo_name}/#{repo_name}.zip",
      "./tmp/buckets/#{remote_folder_name}/#{repo_name}.zip"
    )
  end
end
