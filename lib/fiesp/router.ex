defmodule Fiesp.Router do
  # Using the Router
  use Plug.Router

  # Plug things
  plug :match
  plug :dispatch

  # Forward requests
  forward "/routes", to: Fiesp.Routers.Routes
  forward "/reports", to: Fiesp.Routers.Reports
  
  # 404 Route
  match _ do
    send_resp(conn, 404, "oops")
  end
end
