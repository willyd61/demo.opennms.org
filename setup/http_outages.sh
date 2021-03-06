#!/bin/bash

# Script stops one of three running nginx containers to generate HTTP outages in the demo system

set -u
set -e

nginxcount=$(docker ps | grep -c demo_nginx)
if [ "$nginxcount" -lt 3 ]
then
  INSTALL_PATH=$(cat /etc/docker/.onms_install_path)
  cd "$INSTALL_PATH" || exit 2
  cd .. && docker-compose up -d
else
 no=$(shuf -i 1-3 -n 1)
 echo "Shutting down demo_nginx$no..."
 docker stop demo_nginx"$no" 1>/dev/null
 echo "Done!"
fi


