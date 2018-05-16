defmodule YT3Test do
  use ExUnit.Case
  doctest YT3
  
  defp successful_youtube_response do
    %{
      "thumbnail_url" => "https://i.ytimg.com/vi/mSxnoJThJwk/default.jpg",
      "title" => "Alternative Rock Playlist - Best Of 90's Alternative/Rock"
    }
  end

  test "check Youtube fetcher" do
    assert YT3.Fetcher.get(:youtube, "mSxnoJThJwk") == successful_youtube_response()
  end
end
