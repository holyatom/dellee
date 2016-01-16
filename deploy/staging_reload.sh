#!/usr/bin/env bash
./deploy/assets.sh
pm2 reload server:staging
pm2 reload worker:staging
