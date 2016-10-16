defmodule Fiesp.Database.RouteTest do
  # Case
  use ExUnit.Case

  # Setup!
  setup do
    # Create the database
    Fiesp.Database.Route.init

    # On exit destroy the table
    on_exit fn -> Fiesp.Database.Route.destroy end

    # OK the setup
    :ok
  end

  test "should validate" do
  end

  #
  test "should create a new route" do
    #
    Fiesp.Database.Route.create("Mogi das Cruzes", "Av. Paulista")
  end
end
