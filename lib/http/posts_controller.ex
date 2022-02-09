defmodule Blogerl.Http.PostsController do
  alias Blogerl.Storage.Dets, as: Dets
  alias Plug.Conn, as: Conn

  def show(%Plug.Conn{path_params: %{"title" => title}} = conn) do
    conn
    |> Conn.send_resp(200, Dets.get(Storage, title))
  end

  def index(conn) do
    conn |> Conn.send_resp(200, Dets.list(Storage))
  end

  def add(%Plug.Conn{body_params: %{"title" => title, "body" => body}} = conn) do
    Dets.add(Storage, title, body)
    conn |> Conn.send_resp(201, "created")
  end
end
