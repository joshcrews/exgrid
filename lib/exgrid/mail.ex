defmodule ExGrid.Mail do
  
  alias ExGrid.HTTPHandler


  def send(creds, message) do
    {code, body} = HTTPHandler.post(creds, url, build_form_data(creds, message))
  end

  defp build_form_data(%ExGrid{} = creds, %ExGrid.Message{} = message) do
    build_form_data(Map.from_struct(creds), Map.from_struct(message))
  end

  defp build_form_data(creds, message) do
    full_message = Map.merge(creds, message)
    Enum.map(Map.to_list(full_message), fn {k,v} -> ("#{k}=#{v}") end ) |>
    Enum.join("&")
  end

  defp url do
    "https://sendgrid.com/api/mail.send.json"
  end
end
