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
    path = "./tmp/#{name}"
    {:ok, repo} = Git.clone [clone_url. path]
  end

  def upload_repo(bucket_name, repo_name) do
    "./tmp/#{repo_name}"
      |> ExAws.S3.stream_file
      |> ExAws.S3.upload(bucket_name, repo_name)
      |> ExAws.request!
  end
end
