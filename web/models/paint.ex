defmodule PaintPicker.Paint do
  use PaintPicker.Web, :model

  schema "paints" do
    field :cart, :integer
    field :color, :string
    field :sheen, :string
    field :picked, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:cart, :color, :sheen, :picked])
    |> validate_required([:cart, :color, :sheen, :picked])
  end
end
