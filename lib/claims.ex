defmodule Signatures.Claims do
  defstruct [
    iss: "https://dev.login.myob.com/",
    sub: "some.subject",
    aud: "some.audience",
    exp: nil,
    nbf: nil,
    iat: nil,
    jti: "",
    client_id: "some.client.id",
    scp: "some.scope"
  ]

  def valid do
    %__MODULE__{}
    |> put(:exp, now + 50 * 365 * 24 * 3600) # expires 50 years from now
    |> put(:nbf, now - 30 * 60)
    |> put(:iat, now - 30 * 60)
  end

  def invalidate(claims, :exp), do: put(claims, :exp, now - 30 * 60)
  def invalidate(claims, :nbf), do: put(claims, :nbf, now + 30 * 60)
  def invalidate(claims, _), do: claims

  def put(claims, field, value), do: Map.put(claims, field, value)

  defp now do
    {ms, s, _} = :os.timestamp
    ms * 1_000_000 + s
  end
end
