defmodule Petx do
  @moduledoc """
  Documentation for `Petx`.
  """
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  forward("/api/pets", to: Petx.Routers.Pets)
end
