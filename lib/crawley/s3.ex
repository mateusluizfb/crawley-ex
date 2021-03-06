defmodule Crawley.S3 do
  @behaviour Crawley.Storage

  @impl Crawley.Storage
  def upload_repo(bucket_name, repo_name) do
    Crawley.Storage.zip_folder(repo_name)

    "./code/#{repo_name}/#{repo_name}.zip"
      |> ExAws.S3.Upload.stream_file
      |> ExAws.S3.upload(bucket_name, "#{repo_name}.zip", [timeout: 600_000])
      |> ExAws.request(region: "sa-east-1")
  end
end
