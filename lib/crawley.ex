defmodule Crawley do
  defp github_client() do
    Tentacat.Client.new(%{ access_token: System.get_env("GITHUB_TOKEN") })
  end

  def get_repositories(%{lang: lang, per_page: per_page, page: page}) do
    options = %{
      q:        "language:#{lang}",
      per_page: per_page,
      page:     page,
      sort:     "stars",
    }

    client = github_client()
    Tentacat.Search.repositories(client, options)
  end

  def clone_project(name, clone_url) do
    repo_folder = "./tmp/#{name}"
    {:ok, _} = Git.clone([clone_url, repo_folder])
  end

  def upload_repo(bucket_name, repo_name) do
    "./tmp/#{repo_name}/#{repo_name}.zip"
      |> ExAws.S3.Upload.stream_file
      |> ExAws.S3.upload(bucket_name, "#{repo_name}.zip")
      |> ExAws.request(region: "sa-east-1")
  end

  def zip_folder(repo_name) do
    files = File.ls!("./tmp/#{repo_name}") |> Enum.map(&String.to_charlist/1)
    :zip.create("./tmp/#{repo_name}/#{repo_name}.zip", files)
  end
end
