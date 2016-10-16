defmodule Fiesp.Database.Incident do
  @moduledoc """
  Persistent Incidents
  """

  # Alias
  alias Fiesp.Database.Connection

  # Import query stuff
  import RethinkDB.Query

  # Table name
  @name "incidents"

  @doc """
  Creates a new incident into the specific area
  """
  def create(desc, lat, lng) do
    # 
    table(@name)
    |> insert(%{desc: desc, location: point({lng,lat})})
    |> Connection.run
  end

  @doc """
  Initialize the table and create the indices
  """
  def init do
    # Create the table
    table_create @name

    # Initialize the indices
    table(@name)
    |> index_create("location", %{geo: true})
  end
end
