# LocalSert — A self-signed local HTTPS server

## Usage

```bash
# Generate a self-signed certificate
./gencert.bash
Generating RSA private key, 2048 bit long modulus
.....+++++
...........................................................................................+++++
e is 65537 (0x10001)
Signature ok
subject=/CN=*.local/O=Folk Computer/C=US
Getting Private key
Certificate generated successfully!

# Run the server
./server.tcl
```