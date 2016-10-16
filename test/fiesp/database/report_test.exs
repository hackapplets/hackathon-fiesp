defmodule Fiesp.Database.ReportTest do
  # Case
  use ExUnit.Case

  # Setup!
  setup do
    # Create the database
    Fiesp.Database.Report.init

    # On exit destroy the table
    on_exit fn -> Fiesp.Database.Report.destroy end

    # OK the setup
    :ok
  end

  #
  test "should create a new report" do
    #
    errors = Fiesp.Database.Report.create("Some description", 37.780028, -122.420697).data["errors"]

    # The result must be `:ok`
    assert errors == 0
  end
end
