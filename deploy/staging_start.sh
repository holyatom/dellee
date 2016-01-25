#!/usr/bin/env bash
./deploy/assets.sh
NODE_ENV=staging pm2 start --name "server:staging" ./index.js -i 1
NODE_ENV=staging pm2 start --name "worker:staging" ./worker.js -i 1
