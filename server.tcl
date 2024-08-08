#! /usr/bin/env tclsh
package require tls

# Set the port for HTTPS
set port 4273

# Set the paths to your certificate and key
set certFile "server.crt"
set keyFile "server.key"

# Configure TLS
tls::init -certfile $certFile -keyfile $keyFile

# Create a procedure to handle incoming requests
proc handleRequest {chan clientaddr clientport} {
    set data [read $chan]
    
    # Parse the request (very basic parsing)
    set requestLine [lindex [split $data "\n"] 0]
    set method [lindex $requestLine 0]
    set path [lindex $requestLine 1]
    
    # Prepare response
    set response "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n"
    append response "<html><body>"
    append response "<h1>Hello from SelfCertLocal HTTPS Server!</h1>"
    append response "<p>Method: $method</p>"
    append response "<p>Path: $path</p>"
    append response "</body></html>"
    
    # Send response
    puts -nonewline $chan $response
    close $chan
}

# Start the HTTPS server
set listener [tls::socket -server handleRequest $port]

puts "HTTPS server running on port $port"
puts "URL: https://localhost:$port"
puts "Use Ctrl+C to stop the server"

# Keep the script running
vwait forever