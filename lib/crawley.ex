defmodule Crawley do
  @use_local_storage System.get_env("USE_LOCAL_STORAGE")

  def run(%{lang: lang, per_page: per_page, page: page}) do
    repos = Crawley.RepoUtils.get_repositories(%{
      lang: lang,
      per_page: per_page,
      page: page
    })

    download_repos(repos)
  end


  @doc """
  Downloads multiple github repos and upload them to the S3 asynchronously.

  Returns an list of tuples like `{:ok, pid}`.
  """
  defp download_repos(repos) do
    repos
      |> Enum.filter(fn repo -> not Enum.member?(urls_ignored(), repo["clone_url"]) end)
      |> Enum.map(&git_clone_async/1)
  end

  @doc """
  Downloads a github repo and upload it to the S3 asynchronously.

  Returns `{:ok, pid}`.
  """
  defp git_clone_async(repo) do
    repo_id = repo["id"]
    repo_clone_url = repo["clone_url"]

    Task.start_link fn ->
      Crawley.RepoUtils.clone_repo(repo_id, repo_clone_url)
      storage(@use_local_storage).upload_repo("crawley-repos", repo_id)
      Crawley.RepoUtils.delete_repo(repo_id)
    end
  end

  defp urls_ignored do
    [
      "https://github.com/erlang/otp.git"
    ]
  end

  defp storage("true"), do: Crawley.LocalStorage
  defp storage("false"), do: Crawley.S3
end
