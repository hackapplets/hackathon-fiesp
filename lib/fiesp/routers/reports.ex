defmodule Fiesp.Routers.Reports do
  @moduledoc  """
  """
  # Using the Router
  use Plug.Router

  # Plug things
  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch
  plug CORSPlug
  
  # Create a new report
  post "/" do
    # Get location from data
    location = conn.params["location"]

    #
    Fiesp.Database.Report.create conn.params["ocurrency"], location["lat"], location["lng"]

    # Send the success response
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(201, Poison.encode!(%{type: "success", message: "reporte created"}))
  end

  # 404 Route
  match _ do
    send_resp(conn, 404, "oops")
  end
end
