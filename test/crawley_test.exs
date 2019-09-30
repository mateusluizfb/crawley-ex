defmodule CrawleyTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Crawley

  setup_all do
    HTTPoison.start
  end

  test "requests the github repos" do
    use_cassette "github_5_erlang_repos" do
      assert { 200, _, _ } = Crawley.get_repositories(
        %{
          lang: 'erlang',
          per_page: 5,
          page: 1
        }
      )
    end
  end

  # test "returns erlang repos" do
  #   {200, _, http_res} = Crawley.get_repositories(
  #   lang: 'erlang',
  #   per_page: 5,
  #   page: 1
  #   )
  #
  #   assert length(http_res.body["items"]) == 20
  # end
end
