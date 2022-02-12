defmodule BlogWeb.Controllers.Post do
  use BlogWeb, :controller
  import Ecto.Query, only: [from: 2]

  def index(conn, %{}) do
    conn |> send_resp(200, "hello world")
  end


  def show(conn, %{"title" => title}) do
    %Blog.Schema.Post{body: body} = Blog.Repo.one(from p in Blog.Schema.Post, where: p.title == ^title, select: [:body])
    conn |> send_resp(200, body)
  end


  def add(conn, %{"title" => title, "body" => body}) do
    {:ok, _} = Blog.Repo.insert(%Blog.Schema.Post{title: title, body: body})
    conn |> put_status(201) |> json(%{title: title, body: body})
  end

end
