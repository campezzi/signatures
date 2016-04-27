# Signatures

To generate a private RSA key:
```
openssl genrsa -out mykey.pem 1024
```

To derive a public key from the private key:
```
openssl rsa -in mykey.pem -pubout -out pubkey.pem
```
