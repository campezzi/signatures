# Signatures
Helper functions to create, sign and verify [JSON Web Tokens](http://jwt.io) for testing purposes.

### CLI Commands
To generate a private RSA key:
```
openssl genrsa -out mykey.pem 1024
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
To generate a valid JWT with a key from the `resources` folder (replace `idam_stub.pem` with the key you want to use to sign the token):
```elixir
Signatures.generate_valid_token("idam_stub.pem")
```
To generate a JWT with invalid claims (expired):
```elixir
Signatures.generate_invalid_token("idam_stub.pem")
```
To verify a JWT with a public key from the `resources` folder:
```elixir
Signatures.verify("eyJ0e...zTVTA", "idam_stub_pub.pem")
```
Feel free to modify the functions in the `Signatures` module to fine-tune the claims in generated tokens!
