defmodule BlogWeb.Controllers.Post do
  use BlogWeb, :controller
  import Ecto.Query, only: [from: 2]

  def index(conn, %{}) do
    titles = Blog.Repo.all(from p in Blog.Schema.Post, select: p.title)
    conn |> send_resp(200, titles)
  end

  def show(conn, %{"title" => title}) do
    body = Blog.Repo.one(from p in Blog.Schema.Post, where: p.title == ^title, select: p.body)
    conn |> send_resp(200, body)
  end

  def add(conn, %{"title" => title, "body" => body}) do
    {:ok, _} = Blog.Repo.insert(%Blog.Schema.Post{title: title, body: body})
    conn |> put_status(201) |> json(%{title: title, body: body})
  end
end
