defmodule Crawley.Runner do
  use GenServer

  ### Client

  @spec start_link([]) :: {}
  def start_link(repo) do
    GenServer.start_link(__MODULE__, repo, [])
  end

  ### Server

  def init(repo) do
    {:ok, repo}
  end

  def handle_cast(:get_repos, repo) do
    git_clone_async(repo)
    {:noreply, repo }
  end

  @doc """
  Downloads a github repo and upload it to the S3 asynchronously.

  Returns `{:ok, pid}`.
  """
  defp git_clone_async(repo) do
    repo_id = repo["id"]
    repo_clone_url = repo["clone_url"]
    use_local_storage = System.get_env("USE_LOCAL_STORAGE")

    Crawley.RepoUtils.clone_repo(repo_id, repo_clone_url)
    storage(use_local_storage).upload_repo("crawley-repos", repo_id)
    Crawley.RepoUtils.delete_repo(repo_id)
  end

  defp storage("true"), do: Crawley.LocalStorage
  defp storage("false"), do: Crawley.S3
end
