package main

import (
	"net/http"
	"os"
)

// Application entry point
func main() {

	http.HandleFunc("/", helloWorld)
	err := http.ListenAndServe(":"+port(), nil)
	if err != nil {
		panic(err)
	}
}

// Hello world http handler
func helloWorld(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Hello world"))
}

// retrieves the Port to start the server on
func port() string {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8008"
	}
	return port
}
