import Config

config :petx,
  ecto_repos: [Petx.Repo]

import_config("#{config_env()}.exs")
