defmodule Blogerl.Storage.Dets do
  @behaviour Blogerl.Storage.Protocol
  use GenServer

  # API
  def start_link([]) do
    GenServer.start_link(__MODULE__, %{name: :table}, name: Storage)
  end


  @impl GenServer
  def init(%{:name => table}) do
    :dets.open_file(table, [])
  end

  @impl GenServer
  def handle_cast({:add, obj}, state) do
    :dets.insert(state, obj)
    :dets.sync(state)
    {:noreply, state}
  end

  @impl GenServer
  def handle_call(title, _, state) when is_binary(title) do
    [{^title, body}] = :dets.lookup(state, title)
    {:reply, body, state}
  end
  def handle_call(:list, _, state) do
    {:reply, "not implemented yet", state}
  end

  @impl Blogerl.Storage
  def add(pid, title, body) do
    GenServer.cast(pid, {:add, {title, body}})
  end

  @impl Blogerl.Storage

  def get(pid, title) do
    GenServer.call(pid, title)
  end

  @impl Blogerl.Storage
  def list(pid) do
    GenServer.call(pid, :list)
  end
end
