defmodule Ravenx.Strategy.Chat do
  @moduledoc """
  Ravenx Hangouts Chat strategy.

  Used to dispatch notifications to Hangouts Chat service.
  """

  @behaviour Ravenx.StrategyBehaviour

  @doc """
  Function used to send a notification to Hangouts Chat.

  The function receives a map including a `text` used to build the message, and an
  `options` Map that can include this configuration:

  * `url`: URL of Hangouts Chat webhook.

  It will respond with a tuple, indicating if everything was `:ok` or there was
  an `:error`.

  """
  @spec call(map, map) :: {:ok, binary} | {:error, {atom, any}}
  def call(payload, options \\ %{}) when is_map(payload) and is_map(options) do
    url = Map.get(options, :url)

    payload
    |> send_notification(url)
  end

  # Private function to send the notification using HTTPotion client.
  #
  @spec send_notification(map, binary) :: {:ok, binary} | {:error, {atom, any}}
  defp send_notification(_payload, nil), do: {:error, {:missing_config, :url}}

  defp send_notification(payload, url) do
    json_payload = Poison.encode!(payload)

    header = [
      {"Accept", "application/json"},
      {"Content-Type", "application/json"}
    ]

    case HTTPoison.post(url, json_payload, header) do
      {:ok, %HTTPoison.Response{body: response, status_code: 200}} ->
        {:ok, Poison.decode(response)}

      {:ok, %HTTPoison.Response{body: response}} ->
        {:error, {:error_response, response}}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, {:error, reason}}

      _ = e ->
        {:error, {:unknown_response, e}}
    end
  end
end
