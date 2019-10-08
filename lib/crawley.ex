defmodule Crawley do
  def run(%{lang: lang, per_page: per_page, page: page}) do
    repos = Crawley.RepoUtils.get_repositories(%{
      lang: lang,
      per_page: per_page,
      page: page
    })

    download_repos(repos)
  end

  defp download_repos(repos), do: Enum.map(repos, &git_clone_async/1)

  defp git_clone_async(repo) do
    repo_id = repo["id"]
    repo_clone_url = repo["clone_url"]

    {:ok, _} = Task.start_link fn ->
      Crawley.RepoUtils.clone_repo(repo_id, repo_clone_url)
      Crawley.S3.upload_repo("crawley-repos", repo_id)
      Crawley.RepoUtils.delete_repo(repo_id)
    end
  end
end
