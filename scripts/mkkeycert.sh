#!/bin/bash
openssl req  -nodes -new -x509  -keyout ./cert/server.key -out ./cert/server.cert \
  -subj "/C=US/ST=US/L=Salt Lake City/O=/OU=/CN=bbs.localtest.com"
