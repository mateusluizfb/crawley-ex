defmodule Crawley.Supervisor do
  use Supervisor

  def start_link(_opts) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = []

    Supervisor.init(children, strategy: :one_for_one) # Apenas reinicia o que quebrou
  end
end
