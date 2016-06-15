/* globals require */
"use strict";
const http = require("http");

(() => {
  console.log(`starting w3d-server on port 80`);
  const server = http.createServer((req, res) => {
    res.end("pong");
  });
  server.listen(80);


  const shutdown = () => {
    console.log("shutting down...");
    server.close();
    process.exit(0);
  };

  process.on("SIGTERM", shutdown);
  process.on("SIGINT", shutdown);
})();
