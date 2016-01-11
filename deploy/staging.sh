#!/usr/bin/env bash
npm install
gulp assets:min
pm2 restart server:staging
pm2 restart worker:staging
