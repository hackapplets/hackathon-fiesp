defmodule Fiesp.Database.Report do
  @moduledoc """
  Persistent Reports
  """

  # Alias
  alias Fiesp.Database.Connection

  # Import query stuff
  import RethinkDB.Query

  # Table name
  @name "reports"

  @doc """
  Creates a new report into the specific area
  """
  def create(desc, lat, lng) do
    # 
    table(@name)
    |> insert(%{desc: desc, location: point({lng,lat})})
    |> Connection.run
  end

  @doc """
  Get all the reports in one specific line
  """
  def reports(area) do
    table(@name)
    |> get_intersecting(area, %{index: "location"})
  end

  @doc """
  Check if there is any report in an area
  """
  def report?(area), do: count(reports(area)) > 0

  @doc """
  Initialize the table and create the indices
  """
  def init do
    # Create the table
    table_create(@name) |> Connection.run

    # Initialize the indices
    table(@name)
    |> index_create("location", %{geo: true})
    |> Connection.run
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
end
