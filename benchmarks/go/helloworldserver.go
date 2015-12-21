package main

import (
	"io"
	"log"
	"net/http"

	// "github.com/davecheney/profile"
)

func main() {
	// defer profile.Start(profile.CPUProfile).Stop()
	http.HandleFunc("/", func(w http.ResponseWriter, req *http.Request) {
		io.WriteString(w, "Hello World")
	})
	log.Fatal(http.ListenAndServe(":8080", nil))
}
