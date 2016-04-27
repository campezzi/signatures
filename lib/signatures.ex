defmodule Signatures do
  def generate_valid_token(key \\ "idam_stub.pem") do
    claims = %{
      "iss" => "https://test.login.myob.com/",
      "sub" => "a.client.id",
      "aud" => "1234567890",
      "exp" => now + 50 * 365 * 24 * 3600, # expires 50 years from now
      "nbf" => now - 30 * 60,
      "iat" => now - 30 * 60,
      "jti" => "",
      "client_id" => "a.client.id",
      "scp" => "ums.basic",
    }
    sign(claims, key)
  end

  def generate_invalid_token(key \\ "idam_stub.pem") do
    claims = %{
      "iss" => "https://login.myob.com/",
      "sub" => "a.client.id",
      "aud" => "not-yet-known",
      "exp" => now + 50 * 365 * 24 * 3600, # expires 50 years from now
      "nbf" => now - 30 * 60,
      "iat" => now - 30 * 60,
      "jti" => "",
      "client_id" => "a.client.id",
      "scp" => "other.service",
    }
    sign(claims, key)
  end

  defp now do
    {ms, s, _} = :os.timestamp
    ms * 1_000_000 + s
  end

  def sign(claims, key) do
    opts = %{
      alg: "RS256",
      key: JsonWebToken.Algorithm.RsaUtil.private_key("resources", key)
    }
    JsonWebToken.sign(claims, opts)
  end

  def verify(signature, key \\ "idam_stub_pub.pem") do
    opts = %{
      alg: "RS256",
      key: JsonWebToken.Algorithm.RsaUtil.public_key("resources", key)
    }
    JsonWebToken.verify(signature, opts)
  end
end
