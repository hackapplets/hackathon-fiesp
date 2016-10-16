defmodule Fiesp.Maps.Directions do
  @moduledoc """
  Google Maps API Directions representation
  """

  # Struct
  defstruct routes: []

  @doc """
  Step positions
  """
  def step_start(step), do: step["start_location"]
  def step_end(step), do: step["end_location"]
end
