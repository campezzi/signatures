defmodule Signatures do
  def sign(claims, key \\ "idam_stub.pem") do
    opts = %{
      alg: "RS256",
      key: JsonWebToken.Algorithm.RsaUtil.private_key("resources", key)
    }

    claims
    |> IO.inspect
    |> JsonWebToken.sign(opts)
  end

  def verify(signature, key \\ "idam_stub_pub.pem") do
    opts = %{
      alg: "RS256",
      key: JsonWebToken.Algorithm.RsaUtil.public_key("resources", key)
    }
    JsonWebToken.verify(signature, opts)
  end
end
