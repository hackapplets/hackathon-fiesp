defmodule Fiesp.Routers.Routes do
  @moduledoc  """
  """
  # Using the Router
  use Plug.Router

  # Plug things
  plug :match
  plug :dispatch
  plug CORSPlug
  
  # Create a new report
  get "/" do
    # Get the params
    params = fetch_query_params(conn).query_params

    # Create a new route
    route = Fiesp.Database.Route.create params["origin"], params["dest"]

    # Send the success response
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, route |> Map.delete("id") |> Poison.encode!)
  end

  # 404 Route
  match _ do
    send_resp(conn, 404, "oops")
  end
end
