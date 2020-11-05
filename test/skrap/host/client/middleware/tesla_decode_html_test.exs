defmodule Tesla.Middleware.DecodeHTLMTest do
  use ExUnit.Case, async: true

  alias Tesla.Env

  defmodule Client do
    use Tesla

    alias Tesla.Env

    plug Tesla.Middleware.DecodeHTML

    adapter fn %Env{} = env ->
      {status, headers, body} = return_response(env.url)

      {:ok, %{env | status: status, headers: headers, body: body}}
    end

    defp return_response("/html") do
      html_content =
        "<html><head><title>HTML</title></head><body><h1>Valid HTML Response</h1></body></html>"

      {200, [{"content-type", "text/html"}], html_content}
    end

    defp return_response("/invalid-content-type"),
      do: {200, [{"content-type", "text/plain"}], "plain text"}

    defp return_response("/empty-response"),
      do: {200, [{"content-type", "text/html"}], nil}

    defp return_response("/empty-string"),
      do: {200, [{"content-type", "text/html"}], ""}
  end

  describe "call/3" do
    test "returns ok with body content parsed" do
      assert {:ok, %Env{body: body}} = Client.get("/html")

      assert body == [
               {"html", [],
                [
                  {"head", [], [{"title", [], ["HTML"]}]},
                  {"body", [], [{"h1", [], ["Valid HTML Response"]}]}
                ]}
             ]
    end

    test "returns ok with body content unchanged when it is not parseable" do
      unparseable_responses = [
        {"/invalid-content-type", "plain text"},
        {"/empty-response", nil},
        {"/empty-string", ""}
      ]

      Enum.each(unparseable_responses, fn {endpoint, expected_body} ->
        assert {:ok, %Env{body: body}} = Client.get(endpoint)
        assert body == expected_body
      end)
    end
  end
end
