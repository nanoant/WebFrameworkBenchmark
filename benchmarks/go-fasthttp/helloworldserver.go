package main

import (
	"flag"
	"io"
	"log"

	"github.com/valyala/fasthttp"
)

var addr = flag.String("addr", ":8080", "TCP address to listen to")

func main() {
	flag.Parse()
	if err := fasthttp.ListenAndServe(*addr, requestHandler); err != nil {
		log.Fatalf("Error in ListenAndServe: %s", err)
	}
}

func requestHandler(ctx *fasthttp.RequestCtx) {
	io.WriteString(ctx, "Hello World")
}
