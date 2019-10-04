defmodule Crawley.RepoUtilsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Crawley

  setup do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes")
  end

  test "requests the github repos" do
    use_cassette "github_5_erlang_repos" do
      assert { 200, _, _ } = Crawley.RepoUtils.get_repositories(
        %{
          lang: 'erlang',
          per_page: 5,
          page: 1
        }
      )
    end
  end

  test "returns erlang repos" do
    use_cassette "github_5_erlang_repos" do
      {_, _, http_res} = Crawley.RepoUtils.get_repositories(
        %{
          lang: 'erlang',
          per_page: 5,
          page: 1
        }
      )

      assert length(http_res.body["items"]) == 5
    end
  end
end
