defmodule Blogerl.Http.Router do
  use Plug.Router
  alias Blogerl.Http.PostsController, as: PostsController
  plug :match
  plug Plug.Logger, log: :debug
  plug Plug.Parsers, parsers: [:json], json_decoder: Jason

  plug :dispatch

  # get "/:title", Blogerl.Http.PostsController, :show
  get "/", do: PostsController.index(conn)

  get "/:title", do: PostsController.show(conn)

  post "/", do: PostsController.add(conn)
end
