defmodule Skrap.Fetchers.Client do
  @moduledoc """
  A behavior module for defining Skrap Clients.

  A client is responsible for retrieving raw data from a host, all content resources
  on a host must be accessed through a client which always returns a `Tesla.Env.result()`.
  """

  @callback manga(binary()) :: Tesla.Env.result()

  defmacro __using__(opts \\ []) do
    hostname = Keyword.get(opts, :hostname)

    quote do
      use Tesla

      @hostname unquote(hostname)

      plug Tesla.Middleware.BaseUrl, @hostname

      @behaviour Skrap.Fetchers.Client

      def hostname, do: @hostname
    end
  end
end
