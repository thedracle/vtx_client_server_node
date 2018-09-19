#!/bin/bash

if ! [ -z "$WEBSOCKET_OVERRIDE_ADDRESS" ]; then
  sed -i "s/WEBSOCKET_ADDRESS/${WEBSOCKET_OVERRIDE_ADDRESS}/g" ./vtxclient/vtxdata.js
else
  WS_PROTO="wss"
  if [ "$SUPPORT_SSL" = "false" ]; then
    WS_PROTO="ws"
  fi

  WS_DOMAIN="bbs.localtest.com"
  if ! [ -z "$OVERRIDE_CERT_DOMAIN" ]; then
    WS_DOMAIN="$OVERRIDE_CERT_DOMAIN"
  fi

  WS_PORT=7003
  if ! [ -z "WS_PORT" ]; then
    WS_PORT=$WS_PORT
  fi

  sed -i "s/WEBSOCKET_ADDRESS/${WS_PROTO}:\/\/${WS_DOMAIN}:${WS_PORT}/g" ./vtxclient/vtxdata.js
fi

if [ "$SUPPORT_SSL" = "false" ]; then
  ./node_modules/http-server/bin/http-server ./vtxclient/
else
  ./node_modules/http-server/bin/http-server -S -C ./cert/server.cert -K ./cert/server.key ./vtxclient/
fi
