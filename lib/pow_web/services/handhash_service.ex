defmodule PowWeb.Services.HandhashService do
  def get_current_profile(auth_token) do
    client = Handkit.create_connect_client(auth_token)
    Handkit.Profile.get_current_profile(client)
  end
end
