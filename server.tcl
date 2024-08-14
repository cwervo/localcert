#!/usr/bin/env tclsh
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
    puts "Handling request from $clientaddr:$clientport"
    
    if {[catch {
        fconfigure $chan -blocking 0
        set data [read $chan]
        
        if {$data eq ""} {
            puts "Warning: Empty request received"
            return
        }
        
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
    } err]} {
        puts "Error handling request: $err"
        if {[info exists ::errorInfo]} {
            puts $::errorInfo
        }
    }
    
    catch {close $chan}
}

# Start the HTTPS server
if {[catch {
    set listener [tls::socket -server handleRequest $port]
} err]} {
    puts "Error starting server: $err"
    if {[info exists ::errorInfo]} {
        puts $::errorInfo
    }
    exit 1
}

puts "HTTPS server running on port $port"
puts "URL: https://localhost:$port"
puts "Note: Make sure to use HTTPS, not HTTP"
puts "Use Ctrl+C to stop the server"

# Diagnostic information
puts "\nDiagnostic Information:"
puts "Tcl version: [info patchlevel]"
puts "TLS package version: [package require tls]"
puts "Certificate file: $certFile"
puts "Key file: $keyFile"

# Keep the script running
vwait forever