package main

import (
	"fmt"
	"net/http"
	"time"
)

func main() {
	// Define HTTP handler for the root endpoint
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		// Get current time
		currentTime := time.Now().Format(time.RFC1123)
		
		// Set content type
		w.Header().Set("Content-Type", "text/html")
		
		// Write HTML response
		fmt.Fprintf(w, `
		<!DOCTYPE html>
		<html>
		<head>
			<title>Date and Time Service</title>
			<style>
				body {
					font-family: Arial, sans-serif;
					display: flex;
					justify-content: center;
					align-items: center;
					height: 100vh;
					margin: 0;
					background-color: #f0f0f0;
				}
				.container {
					text-align: center;
					padding: 20px;
					border-radius: 10px;
					background-color: white;
					box-shadow: 0 0 10px rgba(0,0,0,0.1);
				}
				h1 {
					color: #333;
				}
				.time {
					font-size: 24px;
					color: #0066cc;
					margin: 20px 0;
				}
			</style>
		</head>
		<body>
			<div class="container">
				<h1>Current Date and Time</h1>
				<div class="time">%s</div>
			</div>
		</body>
		</html>
		`, currentTime)
	})

	// Start server
	fmt.Println("Server starting on port 3000...")
	if err := http.ListenAndServe(":3000", nil); err != nil {
		fmt.Printf("Error starting server: %s\n", err)
	}
}