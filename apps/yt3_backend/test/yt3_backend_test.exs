defmodule YT3Test do
  use ExUnit.Case
  doctest YT3

  test "check Youtube fetcher" do
    assert YT3.Fetcher.get(:youtube, "mSxnoJThJwk") == "mSxnoJThJwk"
  end
end
