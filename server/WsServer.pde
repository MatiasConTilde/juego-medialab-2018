import java.net.InetSocketAddress;

import org.java_websocket.WebSocket;
import org.java_websocket.handshake.ClientHandshake;
import org.java_websocket.server.WebSocketServer;

class WsServer extends WebSocketServer {
  private Thread t;
  int connectionAmount = 0;

  WsServer(int port) {
    super(new InetSocketAddress("localhost", port));
    t = new Thread(this, "ws");
    t.start();
  }

  @Override
  void onOpen(WebSocket conn, ClientHandshake handshake) {
    connectionAmount++;
    println("new " + conn.getRemoteSocketAddress() + " " + connectionAmount);

    state = State.PLAY;
  }

  @Override
  void onMessage(WebSocket conn, String msg) {
    println("received message from "  + conn.getRemoteSocketAddress() + ": " + msg);

    JSONObject packet = parseJSONObject(msg);

    if (packet.getString("type").equals("bomb")) {
      newBomb(packet.getFloat("x"), packet.getFloat("y"));
    }
  }

  @Override
  void onClose(WebSocket conn, int code, String reason, boolean remote) {
    connectionAmount--;
    println("closed " + conn.getRemoteSocketAddress() + " " + connectionAmount + " left");

    if (connectionAmount == 0) {
      state = State.DEMO;
      player.init();
      resetUpnp();
    }
  }

  @Override
  void onError(WebSocket conn, Exception ex) {
    System.err.println("an error occured on connection " + ex);
  }

  @Override
  void onStart() {
    println("server started successfully");
  }
}
