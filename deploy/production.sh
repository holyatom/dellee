#!/usr/bin/env bash
gulp assets:min
NODE_ENV=production pm2 start --name "server" ./index.js
NODE_ENV=production pm2 start --name "worker" ./worker.js
