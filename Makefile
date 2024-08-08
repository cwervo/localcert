# Makefile for LocalSert

# Variables
SHELL := /bin/bash
CERT_SCRIPT := ./gencert.bash
SERVER_SCRIPT := ./server.tcl

# Default target
all: serve

# Generate certificate
cert:
	@echo "Generating self-signed certificate..."
	@$(CERT_SCRIPT)

# Run the server
serve:
	@echo "Starting HTTPS server..."
	@$(SERVER_SCRIPT)

# Clean generated files (optional)
clean:
	@echo "Cleaning up generated files..."
	@rm -f server.key server.csr server.crt server.pem

.PHONY: all cert serve clean
