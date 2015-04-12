import org.jboss.netty.bootstrap.ServerBootstrap;
import org.jboss.netty.channel.socket.nio.NioServerSocketChannelFactory;

import java.net.InetSocketAddress;
import java.util.concurrent.Executors;

/**
* An HTTP server that sends back the content of the received HTTP request
* in a pretty plaintext form.
*/
public class HelloWorldServer {

  private final int port;

  public HelloWorldServer(int port) {
    this.port = port;
  }

  public void run() {
    // Configure the server.
    ServerBootstrap bootstrap = new ServerBootstrap(
      new NioServerSocketChannelFactory(
        Executors.newCachedThreadPool(),
          Executors.newCachedThreadPool()));

    // Enable TCP_NODELAY to handle pipelined requests without latency.
    bootstrap.setOption("child.tcpNoDelay", true);

    // Set up the event pipeline factory.
    bootstrap.setPipelineFactory(new HelloWorldServerPipelineFactory());

    // Bind and start to accept incoming connections.
    bootstrap.bind(new InetSocketAddress(port));
  }

  public static void main(String[] args) {
    int port;
    if (args.length > 0) {
      port = Integer.parseInt(args[0]);
    } else {
      port = 8080;
    }
    System.out.println("Started server at http://127.1:8080/  Hit ^C to stop");
    new HelloWorldServer(port).run();
  }

}
