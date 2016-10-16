defmodule Fiesp.Router do
  # Using the Router
  use Plug.Router

  # Plug things
  plug :match
  plug :dispatch

  # Forward requests
  forward "/incidents", to: Fiesp.Routers.Incident
  
  # 404 Route
  match _ do
    send_resp(conn, 404, "oops")
  end
end
