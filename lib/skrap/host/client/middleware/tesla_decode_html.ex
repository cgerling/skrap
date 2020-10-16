defmodule Tesla.Middleware.DecodeHTML do
  @behaviour Tesla.Middleware

  alias Tesla.Env

  @accepted_content_types ["text/html"]

  def call(%Env{} = env, next, _) do
    with {:ok, %Env{} = env} <- Tesla.run(env, next),
         {:ok, parsed_body} <- parse(env) do
      {:ok, %Env{env | body: parsed_body}}
    end
  end

  defp parse(%Env{} = env) do
    with true <- is_parseable?(env),
         {:ok, document} <- Floki.parse_document(env.body) do
      {:ok, document}
    else
      false -> {:ok, env.body}
      error -> error
    end
  end

  defp is_parseable?(%Env{} = env),
    do: is_content_type_accepted?(env) and is_body_parseable?(env)

  defp is_content_type_accepted?(%Env{} = env) do
    case Tesla.get_header(env, "content-type") do
      nil -> false
      content_type -> Enum.any?(@accepted_content_types, &String.starts_with?(content_type, &1))
    end
  end

  defp is_body_parseable?(%Env{body: body}) when is_binary(body) and body != "", do: true
  defp is_body_parseable?(_), do: false
end
