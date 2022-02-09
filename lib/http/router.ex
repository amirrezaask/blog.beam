defmodule Blogerl.Http.Router do
  use Plug.Router
  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json], json_decoder: Jason

  # get "/:title", Blogerl.Http.PostsController, :show
  get "/" do
    send_resp(200, "salam")
  end

end
