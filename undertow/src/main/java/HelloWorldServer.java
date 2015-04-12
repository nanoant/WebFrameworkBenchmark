import io.undertow.Undertow;
import io.undertow.server.HttpHandler;
import io.undertow.server.HttpServerExchange;
import io.undertow.util.Headers;

public class HelloWorldServer {

  public static void main(final String[] args) {
    Undertow server = Undertow.builder()
      .addListener(8080, "localhost")
    .setHandler(new HttpHandler() {
      @Override
      public void handleRequest(final HttpServerExchange exchange) throws Exception {
        exchange.getResponseHeaders().put(Headers.CONTENT_TYPE, "text/plain");
        exchange.getResponseSender().send("Hello World");
      }
    }).build();
    server.start();

    System.out.println("Started server at http://127.1:8080/  Hit ^C to stop");
  }
}
