defmodule Fiesp.Database.Route do
  @moduledoc """
  Routes
  """

  # Alias
  alias Fiesp.Database.Connection
  alias Fiesp.Maps.Directions

  # Import query stuff
  import RethinkDB.Query

  # Table name
  @name "routes"

  @doc """
  Creates a new route
  """
  def create(origin, dest) do
    # Consult Google Maps infos
    route = Fiesp.Maps.Conn.directions(origin, dest).routes
    |> Enum.find(fn(route) -> valid?(hd(route["legs"])) end)

    # Check the result
    case route do
      nil -> :error
      _ ->
        # 
        table(@name)
        |> insert(%{origin: origin, dest: dest, route: route}, %{return_changes: true})
        |> Connection.run
        |> Map.get(:data)
        |> Map.get("changes")
        |> hd
        |> Map.get("new_val")
    end
  end

  @doc """
  Validate if there is any report in the Google Maps Route
  Route is internally called `leg`
  """
  def valid?(leg) do
    leg["steps"]
    |> Enum.map(fn(step) -> line([to_point(Directions.step_start(step)), to_point(Directions.step_end(step))]) end)
    |> Enum.map(&Task.async(fn -> Fiesp.Database.Report.report?(&1) end))
    |> Enum.map(&Task.await/1)
    |> Enum.any?(fn(res) -> res end)
  end

  @doc """
  Initialize the table and create the indices
  """
  def init do
    # Create the table
    table_create(@name) |> Connection.run

    # Initialize the indices
    # table(@name)
    # |> index_create("location", %{geo: true})
    # |> Connection.run
  end

  @doc """
  Destroy the table
  """
  def destroy do
    # Check the ENV
    case Mix.env do
      "prod" -> false
      _ ->
        # Anyway, destroy it!
        table(@name) |> delete |> Connection.run
    end
  end

  # Transform to RethinkDB Point
  defp to_point(pos), do: point(pos["lng"], pos["lat"])
end
