# Signatures
Helper functions to create, sign and verify [JSON Web Tokens](http://jwt.io) for testing purposes.

### CLI Commands
To generate a private RSA key:
```
openssl genrsa -out mykey.pem 2048
```

To derive a public key from the private key:
```
openssl rsa -in mykey.pem -pubout -out pubkey.pem
```

Start an IEx session with the Mix project as the context:
```
iex -S mix
```

### IEx Commands
To generate valid JWT claims, use `Signature.Claims.valid`:
```elixir
claims = Signatures.Claims.valid
```

You can then modify specific claims with `Signature.Claims.put`
```elixir
modified_claims =
  claims
  |> Signatures.Claims.put(:scp, "my.custom.scope")
```

Helpers are provided to invalidate claims `exp` (with an expiration date in the past) and `nbf` (with a not before date in the future):
```elixir
claims_with_invalid_expiration =
  claims
  |> Signatures.Claims.invalidate(:exp)

claims_with_invalid_not_before =
  claims
  |> Signatures.Claims.invalidate(:nbf)
```

To generate a signed JWT from a claims struct with a key from the `resources` folder (replace `idam_stub.pem` with the key you want to use to sign the token):
```elixir
Signatures.sign(claims, "idam_stub.pem")
```

To verify a JWT was signed with a public key from the `resources` folder:
```elixir
Signatures.verify("eyJ0e...zTVTA", "idam_stub_pub.pem")
```
