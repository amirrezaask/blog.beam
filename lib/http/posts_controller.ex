defmodule Blogerl.Http.PostsController do
  alias Blogerl.Storage.Dets, as: Dets
  alias Plug.Conn, as: Conn
  def show(conn, %{title: title} = _params) do
    conn |> Conn.send_resp(200, Dets.get(Storage, title))
  end

  def index(conn, _params) do
    conn |> Conn.send_resp(200, Dets.list(Storage))
  end

  def add(%{body_params: body} = conn, _param) do
    Dets.add(Storage, body["title"], body["body"])
    conn |> Conn.send_resp(201, "created")
  end
end
