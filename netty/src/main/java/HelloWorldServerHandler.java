import org.jboss.netty.buffer.ChannelBuffers;
import org.jboss.netty.channel.Channel;
import org.jboss.netty.channel.ChannelFuture;
import org.jboss.netty.channel.ChannelFutureListener;
import org.jboss.netty.channel.ChannelHandlerContext;
import org.jboss.netty.channel.Channels;
import org.jboss.netty.channel.ExceptionEvent;
import org.jboss.netty.channel.MessageEvent;
import org.jboss.netty.channel.SimpleChannelUpstreamHandler;
import org.jboss.netty.handler.codec.http.DefaultHttpResponse;
import org.jboss.netty.handler.codec.http.HttpRequest;
import org.jboss.netty.handler.codec.http.HttpResponse;

import static org.jboss.netty.handler.codec.http.HttpHeaders.Names.*;
import static org.jboss.netty.handler.codec.http.HttpHeaders.*;
import static org.jboss.netty.handler.codec.http.HttpResponseStatus.*;
import static org.jboss.netty.handler.codec.http.HttpVersion.*;

public class HelloWorldServerHandler extends SimpleChannelUpstreamHandler {

  private static final byte[] CONTENT = { 'H', 'e', 'l', 'l', 'o', ' ', 'W', 'o', 'r', 'l', 'd' };

  @Override
  public void messageReceived(ChannelHandlerContext ctx, MessageEvent e) throws Exception {
    Object msg = e.getMessage();
    Channel ch = e.getChannel();
    if (msg instanceof HttpRequest) {
      HttpRequest req = (HttpRequest) msg;

      if (is100ContinueExpected(req)) {
        Channels.write(ctx, Channels.future(ch), new DefaultHttpResponse(HTTP_1_1, CONTINUE));
      }

      boolean keepAlive = isKeepAlive(req);
      HttpResponse response = new DefaultHttpResponse(HTTP_1_1, OK);
      response.setContent(ChannelBuffers.wrappedBuffer(CONTENT));
      response.setHeader(CONTENT_TYPE, "text/plain");
      response.setHeader(CONTENT_LENGTH, response.getContent().readableBytes());

      if (!keepAlive) {
        ChannelFuture f = Channels.future(ch);
        f.addListener(ChannelFutureListener.CLOSE);
        Channels.write(ctx, f, response);
      } else {
        response.setHeader(CONNECTION, Values.KEEP_ALIVE);
        Channels.write(ctx, Channels.future(ch), response);
      }
    }
  }

  @Override
  public void exceptionCaught(ChannelHandlerContext ctx, ExceptionEvent e)
  throws Exception {
    e.getCause().printStackTrace();
    e.getChannel().close();
  }
}
