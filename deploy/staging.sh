#!/usr/bin/env bash
gulp assets:min
NODE_ENV=staging pm2 start --name "server:staging" ./index.js
NODE_ENV=staging pm2 start --name "worker:staging" ./worker.js
