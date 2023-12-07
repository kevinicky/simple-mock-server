package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"time"
)

func main() {

	var requestList string
	http.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {

		requestList += fmt.Sprintf("[%-35v] [%-8s] %s\n", time.Now().Format(time.RFC1123Z), request.Method, request.RequestURI)
		_, err := io.WriteString(writer, requestList)
		if err != nil {
			log.Fatalln("failed to write", err)
		}
	})

	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatalln("failed to serve", err)
	}
}
