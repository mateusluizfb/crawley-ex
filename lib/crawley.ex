defmodule Crawley do
  def run(%{lang: lang, per_page: per_page, page: page}) do
    Crawley.Supervisor.start_link({})

    repos = Crawley.RepoUtils.get_repositories(%{
      lang: lang,
      per_page: per_page,
      page: page
    })

    download_repos(repos)
  end

  defp download_repos(repos) do
    IO.puts "downloading repos"
    # Task.Supervisor.async(Crawley.Supervisor, fn ->
    # end)
    repos
      |> Enum.filter(fn repo -> not Enum.member?(urls_ignored(), repo["clone_url"]) end)
      |> Enum.map(&start_server/1)
  end

  def start_server(repo) do
    {:ok, runner} = Crawley.Runner.start_link(repo)
    GenServer.cast(runner, :get_repos)
  end

  defp urls_ignored do
    [
      "https://github.com/erlang/otp.git"
    ]
  end
end
