defmodule PaintPicker.PaintController do
  use PaintPicker.Web, :controller

  alias PaintPicker.Paint

  def index(conn, _params) do
    paints = Repo.all(Paint)
    render(conn, "index.json", paints: paints)
  end

  def create(conn, %{"paint" => paint_params}) do
    changeset = Paint.changeset(%Paint{}, paint_params)

    case Repo.insert(changeset) do
      {:ok, paint} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", paint_path(conn, :show, paint))
        |> render("show.json", paint: paint)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PaintPicker.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    paint = Repo.get!(Paint, id)
    render(conn, "show.json", paint: paint)
  end

  def update(conn, %{"id" => id, "paint" => paint_params}) do
    paint = Repo.get!(Paint, id)
    changeset = Paint.changeset(paint, paint_params)

    case Repo.update(changeset) do
      {:ok, paint} ->
        render(conn, "show.json", paint: paint)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PaintPicker.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    paint = Repo.get!(Paint, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(paint)

    send_resp(conn, :no_content, "")
  end
end
