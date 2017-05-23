defmodule PaintPicker.PaintView do
  use PaintPicker.Web, :view

  def render("index.json", %{paints: paints}) do
    %{data: render_many(paints, PaintPicker.PaintView, "paint.json")}
  end

  def render("show.json", %{paint: paint}) do
    %{data: render_one(paint, PaintPicker.PaintView, "paint.json")}
  end

  def render("paint.json", %{paint: paint}) do
    %{id: paint.id,
      cart: paint.cart,
      color: paint.color,
      sheen: paint.sheen,
      picked: paint.picked}
  end
end
