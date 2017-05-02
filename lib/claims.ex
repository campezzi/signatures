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
    |> put(:exp, future)
    |> put(:nbf, past)
    |> put(:iat, past)
  end

  def invalidate(claims, :exp), do: put(claims, :exp, past)
  def invalidate(claims, :nbf), do: put(claims, :nbf, future)
  def invalidate(claims, _), do: claims

  def put(claims, field, value), do: Map.put(claims, field, value)

  def now do
    {megasecs, secs, _} = :os.timestamp
    megasecs * 1_000_000 + secs
  end

  def past, do: now - 30 * 60

  def future, do: now + 50 * 365 * 24 * 3600

  def for_task_service do
    valid
    |> put(:iss, "https://dev.login.myob.com/")
    |> put(:aud, "b764bd7b-8cb6-43f1-ae63-533522b679b9")
    |> put(:scp, "task_service.basic")
  end

  def for_bulk_service do
    valid
    |> put(:iss, "http://stubs.bulktask.teamdagobah.com:5001/")
    |> put(:aud, "99894bd0-2565-4bb3-8a53-fd2fff226bae")
  end
end
