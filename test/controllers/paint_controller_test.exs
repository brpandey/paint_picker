defmodule PaintPicker.PaintControllerTest do
  use PaintPicker.ConnCase

  alias PaintPicker.Paint
  @valid_attrs %{cart: 42, color: "some content", picked: true, sheen: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, paint_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    paint = Repo.insert! %Paint{}
    conn = get conn, paint_path(conn, :show, paint)
    assert json_response(conn, 200)["data"] == %{"id" => paint.id,
      "cart" => paint.cart,
      "color" => paint.color,
      "sheen" => paint.sheen,
      "picked" => paint.picked}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, paint_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, paint_path(conn, :create), paint: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Paint, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, paint_path(conn, :create), paint: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    paint = Repo.insert! %Paint{}
    conn = put conn, paint_path(conn, :update, paint), paint: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Paint, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    paint = Repo.insert! %Paint{}
    conn = put conn, paint_path(conn, :update, paint), paint: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    paint = Repo.insert! %Paint{}
    conn = delete conn, paint_path(conn, :delete, paint)
    assert response(conn, 204)
    refute Repo.get(Paint, paint.id)
  end
end
