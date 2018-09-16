FROM ubuntu:18.04
MAINTAINER Jason Thomas
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

RUN apt-get update
RUN apt-get install -y nodejs npm git

EXPOSE 8030 7003

RUN mkdir -p /opt/bbs/;cd /opt/bbs;git clone https://github.com/thedracle/vtx_client_server_node.git
WORKDIR /opt/bbs/vtx_client_server_node/
RUN npm install --unsafe-perm

CMD npm start
