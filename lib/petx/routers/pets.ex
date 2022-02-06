defmodule Petx.Routers.Pets do
  use Plug.Router
  alias Petx.{Repo, Schema.Pet}

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason
  )

  plug(:dispatch)

  get "/" do
    results = Repo.all(Pet) |> Jason.encode!()

    conn
    |> send_resp(200, results)
  end

  get "/:field/:value" do
    results =
      case field do
        "id" -> Repo.get!(Pet, String.to_integer(value))
        "name" -> Repo.get_by!(Pet, name: value)
        _ -> Repo.all(Pet)
      end
      |> Jason.encode!()

    # results = results |> Jason.encode!()
    conn
    |> send_resp(200, results)
  end

  post "/create" do
    conn.body_params
    |> Pet.changeset()
    |> Repo.insert!()

    conn
    |> send_resp(201, Jason.encode!(%{status: :ok}))
  end

  delete "/:id" do
    result = Repo.get!(Pet, id)
    name = result.name
    log = Repo.delete(result)
    IO.puts(inspect(log))

    message =
      case log do
        {:ok, _} -> Jason.encode!(%{status: :ok, message: "Pet #{name} deleted"})
        {:error, _} -> Jason.encode!(%{status: :error, message: "Pet not deleted"})
      end

    IO.puts(inspect(message))

    conn
    |> send_resp(200, message)
  end

  put "/:id/:value" do
    result =
      Repo.get!(Pet, id)
      |> Ecto.Changeset.change(name: value)
      |> Repo.update!()

    conn
    |> send_resp(200, Jason.encode!(%{status: :ok, message: "Pet #{result.id} updated"}))
  end
end
