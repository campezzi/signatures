defmodule Signatures do
  def sign(claims, key \\ "primary.pem", kid \\ "Mb19SlygIrl-NRLZCwGZU-7UZuM") do
    opts = %{
      alg: "RS256",
      key: JsonWebToken.Algorithm.RsaUtil.private_key("resources", key),
      kid: kid
    }

    claims
    |> IO.inspect
    |> JsonWebToken.sign(opts)
  end

  def verify(signature, key \\ "primary_pub.pem") do
    opts = %{
      alg: "RS256",
      key: JsonWebToken.Algorithm.RsaUtil.public_key("resources", key)
    }
    JsonWebToken.verify(signature, opts)
  end

  def extract_jwk(key \\ "primary.pem") do
    "resources/#{key}"
    |> JOSE.JWK.from_pem_file
    |> JOSE.JWK.to_public_map
    |> elem(1)
    |> Poison.encode!
    |> IO.puts
  end
end
