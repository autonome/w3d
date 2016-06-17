/* globals require */
"use strict";
const http = require("http");
const httpPort = 8000;
const ws = require("ws");
const wsPort = 8009;


(() => {

  // Web server
  console.log(`starting w3d-server on port 80`);
  const server = http.createServer((req, res) => {
    res.end("pong");
  });
  server.listen(httpPort);

  // Web socket server
  var wss = new ws.Server({ port: wsPort });
  wss.on('connection', function(conn) {

    conn.on('message', function(msg) {

      if (msg.blink) {

        // Make stuff blink.

      }

    });

  });

  const shutdown = () => {
    console.log("shutting down...");
    server.close();
    process.exit(0);
  };

  process.on("SIGTERM", shutdown);
  process.on("SIGINT", shutdown);
})();
