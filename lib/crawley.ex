defmodule Crawley do
  def get_repositories(%{lang: lang, per_page: per_page, page: page}) do
    options = %{
      q:        "language:#{lang}",
      per_page: per_page,
      page:     page,
      sort:     "stars",
    }

    Tentacat.Search.repositories(options)
  end
end
