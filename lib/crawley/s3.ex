defmodule Crawley.S3 do
  def upload_repo(bucket_name, repo_name) do
    Crawley.Storage.zip_folder(repo_name)

    "./tmp/#{repo_name}/#{repo_name}.zip"
      |> ExAws.S3.Upload.stream_file
      |> ExAws.S3.upload(bucket_name, "#{repo_name}.zip")
      |> ExAws.request(region: "sa-east-1")
  end
end
