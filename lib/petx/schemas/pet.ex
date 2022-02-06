defmodule Petx.Schema.Pet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pets" do
    field(:name, :string)
    field(:age, :integer)
    field(:type, :string)
    timestamps()
  end

  def changeset(params) do
    %Petx.Schema.Pet{}
    |> cast(params, [:name, :age, :type])
    |> validate_required([:name, :age, :type])
  end

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(values, opts) do
      Jason.Encode.map(Map.take(values, [:name, :age, :type, :id]), opts)
    end
  end
end
