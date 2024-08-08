#!/bin/bash

# Set the domain name
DOMAIN="*.local"

# Generate a private key
openssl genrsa -out server.key 2048

# Generate a Certificate Signing Request (CSR)
openssl req -new -key server.key -out server.csr -subj "/CN=$DOMAIN/O=Folk Computer/C=US"

# Generate a self-signed certificate
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

# Create a combined PEM file (some servers use this format)
cat server.key server.crt > server.pem

echo "Certificate generated successfully!"