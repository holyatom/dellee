#!/usr/bin/env bash
NODE_ENV=production pm2 start --name "server" ../index.js
NODE_ENV=production pm2 start --name "worker" ../worker.js
