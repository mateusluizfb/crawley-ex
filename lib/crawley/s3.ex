defmodule Crawley.S3 do
  def upload_repo(bucket_name, repo_name) do
    zip_folder(repo_name)

    "./tmp/#{repo_name}/#{repo_name}.zip"
      |> ExAws.S3.Upload.stream_file
      |> ExAws.S3.upload(bucket_name, "#{repo_name}.zip")
      |> ExAws.request(region: "sa-east-1")
  end

  defp zip_folder(repo_name) do
    files = File.ls!("./tmp/#{repo_name}") |> Enum.map(&String.to_charlist/1)
    :zip.create("./tmp/#{repo_name}/#{repo_name}.zip", files)
  end
end
