#!/usr/bin/env bash
npm install
gulp assets:min
NODE_ENV=staging pm2 reload server:staging
NODE_ENV=staging pm2 reload worker:staging
