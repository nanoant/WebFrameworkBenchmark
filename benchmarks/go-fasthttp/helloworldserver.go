package main

import (
	"flag"
	"fmt"
	"io"
	"log"
	"net"
	"os"
	"os/exec"
	"runtime"

	"github.com/valyala/fasthttp"
	"github.com/valyala/fasthttp/reuseport"
)

var (
	addr     = flag.String("addr", ":8080", "TCP address to listen to")
	prefork  = flag.Bool("prefork", false, "use prefork")
	affinity = flag.Bool("affinity", false, "use affinity for prefork")
	child    = flag.Bool("child", false, "is child proc")
)

func main() {
	flag.Parse()

	ln := getListener()

	if err := fasthttp.Serve(ln, requestHandler); err != nil {
		log.Fatalf("Error in ListenAndServe: %s", err)
	}
}

func requestHandler(ctx *fasthttp.RequestCtx) {
	io.WriteString(ctx, "Hello World")
}

func getListener() net.Listener {
	if !*prefork {
		ln, err := net.Listen("tcp4", *addr)
		if err != nil {
			log.Fatal(err)
		}
		return ln
	}

	if !*child {
		children := make([]*exec.Cmd, runtime.NumCPU())
		for i := range children {
			if *affinity {
				children[i] = exec.Command(os.Args[0], "-prefork", "-child")
			} else {
				children[i] = exec.Command("taskset", "-c", fmt.Sprintf("%d", i), os.Args[0], "-prefork", "-child")
			}
			children[i].Stdout = os.Stdout
			children[i].Stderr = os.Stderr
			if err := children[i].Start(); err != nil {
				log.Fatal(err)
			}
		}
		for _, ch := range children {
			if err := ch.Wait(); err != nil {
				log.Print(err)
			}
		}
		os.Exit(0)
		panic("unreachable")
	}

	runtime.GOMAXPROCS(1)
	ln, err := reuseport.Listen("tcp4", *addr)
	if err != nil {
		log.Fatal(err)
	}
	return ln
}
