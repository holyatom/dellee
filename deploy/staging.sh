#!/usr/bin/env bash
npm install
gulp assets:min
pm2 reload server:staging
pm2 reload worker:staging
