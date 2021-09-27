defmodule Pow.Guardian do
  use Guardian, otp_app: :pow
  alias Pow.Accounts

  def subject_for_token(%{id: id}, claims) do
    {:ok, to_string(id)}
  end
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(params) do
    resource = Accounts.get_user!(params["sub"])
    {:ok,  resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
