defmodule Blogerl.Storage do
  @callback add(pid(), title :: String.t(), body :: String.t()) :: :ok | {:error, String.t()}
  @callback get(pid(), String.t()) :: {:ok, String.t()}
  @callback list(pid()) :: {:ok, [String.t()]} | {:error, String.t()}
end
