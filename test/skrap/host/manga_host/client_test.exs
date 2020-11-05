defmodule Skrap.Host.MangaHost.ClientTest do
  use ExUnit.Case, async: true

  import Tesla.Mock

  alias Skrap.Host.MangaHost.Client
  alias Tesla.Env

  @hostname Client.hostname()

  describe "manga/1" do
    setup do
      mock(fn
        %{method: :get, url: url = "#{@hostname}/manga/manga_id"} ->
          %Env{body: "manga info content", method: :get, status: 200, url: url}
      end)

      :ok
    end

    test "returns a ok with a response" do
      assert {:ok, %Env{} = env} = Client.manga("manga_id")

      assert env.body == "manga info content"
      assert env.status == 200
      assert env.url =~ "/manga/manga_id"
    end
  end
end
