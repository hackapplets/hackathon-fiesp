defmodule Fiesp.Maps.Conn do
  @moduledoc """
  This module is dedicated to connect to the Google Maps API's
  """

  # Google Maps base URL
  @base "https://maps.googleapis.com/maps/api/"

  # Google Maps default format
  @format "json"

  @doc """
  Build and execute the `directions` resource
  """
  def directions(origin, dest, opts \\ []) do
    # Request it
    req = build("directions", Keyword.merge([destination: dest, origin: origin], opts)) |> HTTPoison.get!
     
    # Parse the Body
    req.body |> Poison.decode!(as: %Fiesp.Maps.Directions{})
  end

  # Build the request for some of the Maps API
  defp build(service, args) do
    @base <> service <> "/" <> @format <> "?" <> URI.encode_query(default_params |> Keyword.merge(args))
  end

  # Return the default params
  # that will be used in all
  # the requests
  defp default_params do
    [key: Application.get_env(:fiesp, :maps_key), language: Application.get_env(:fiesp, :maps_lang)]
  end
end
