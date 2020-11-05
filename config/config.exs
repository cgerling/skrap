import Config

config :tesla, adapter: Tesla.Adapter.Hackney

if config_env() == :test do
  config :tesla, adapter: Tesla.Mock
end
