defmodule Blogerl.HttpHandler do
  def init(%{:method => "GET"} = req, state) do
    title = :cowboy_req.binding(:title, req)
    case title do
      :undefined ->
        {:ok, :cowboy_req.reply(200, %{}, "List Title", req), state}
      _ ->
        {:ok, :cowboy_req.reply(200, %{}, "Get Title", req), state}
    end
  end

  def init(%{:method => "POST"} = req, state) do
    {:ok, :cowboy_req.reply(200, %{}, "Add title", req), state}
  end
end
