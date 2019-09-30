defmodule CrawleyTest do
  use ExUnit.Case
  doctest Crawley

  test "requests the github repos" do
    # Mock request https://github.com/parroty/exvcr

    assert { 200, _, _ } = Crawley.get_repositories(
      %{
        lang: 'erlang',
        per_page: 5,
        page: 1
      }
    )
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
