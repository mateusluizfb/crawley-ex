defmodule Crawley.RepoUtils do
  def get_repositories(%{lang: lang, per_page: per_page, page: page}) do
    options = %{
      q:        "language:#{lang}",
      per_page: per_page,
      page:     page,
      sort:     "stars",
    }

    client = github_client()
    {200, _, response} = Tentacat.Search.repositories(client, options)
    response.body["items"]
  end

  def clone_repo(name, clone_url) do
    repo_folder = "./code/#{name}"
    {:ok, _} = Git.clone([clone_url, repo_folder])
  end

  def delete_repo(repo_name) do
    File.rm_rf("./code/#{repo_name}")
  end

  defp github_client() do
    Tentacat.Client.new(%{ access_token: System.get_env("GITHUB_TOKEN") })
  end
end
