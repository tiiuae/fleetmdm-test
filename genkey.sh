#!bin/bash
#

# Generate private key
openssl genrsa -out ./fleet/fleet.key 2048

# Generate certificate signing request and self-signed certificate
openssl req -new -x509 -key ./fleet/fleet.key -out ./fleet/fleet.cert -days 365 \
  -config fleet-cert.conf -extensions v3_req
