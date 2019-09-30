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
end
