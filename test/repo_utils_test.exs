defmodule Crawley.RepoUtilsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Crawley

  setup do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes")
  end

  test "returns erlang repos" do
    use_cassette "github_5_erlang_repos" do
      items = Crawley.RepoUtils.get_repositories(
        %{
          lang: 'erlang',
          per_page: 5,
          page: 1
        }
      )

      assert length(items) == 5
    end
  end
end
