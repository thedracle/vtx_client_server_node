# VTX Client Server NodeJS

A simple NodeJS service for providing a secure websockets based BBS client based on the excellent
work by Daniel Mecklenburg Jr. and the https://github.com/codewar65/VTX_ClientServer project.

It is composed of one service that uses the http-server package to serve the VTXClient on port 8080, and a secondary server that runs a secure websockets based backend, that proxies to a telnet based BBS server.

# Getting Started

Install the project:

```
# npm install
```

Modify your /etc/hosts to add an entry for bbs.localtest.com:

```
# sudo echo '127.0.0.1 bbs.localtest.com' >> /etc/hosts
```

Configure using the following environment variables:

```
export LISTEN_PORT=<Alternative Port for Proxy to listen on> (Default 7003)
export DEST_PORT=<Alternative port to connect to the destination BBS at> (Default 44510)
export DEST_ADDRESS=<BBS Address> (Default xibalba.l33y.codes)
export SUPPORT_SSL=<false in order to support insecure (ws://) instead of secure (wss://) websockets.> (Default true)
```

Start the http server which serves the VTXClient on port 8080 using http-server:

```
# npm start
```

Then visit via your browser:
https://bbs.localtest.com:8080

## Docker
You can also run everything with docker:

```
# docker build . -t bbsclient
# docker run -p 8030:8030 -p 7003:7003 -it bbsclient
```

## Deployment

You can deploy the application as a docker container, and use NGINX to terminate SSL.

The SUPPORT_SSL parameter can be used to serve as TCP for both the server and websocket, and WEBSOCKET_OVERRIDE_ADDRESS can be used to set whatever the externally facing name will be for your websocket endpoint.

```
docker run bbsclient -e "SUPPORT_SSL=false" -e "WEBSOCKET_OVERRIDE_ADDRESS=wss\/\/<MY_URL>/ws"
```

## Example
An example deployment can be found at https://bbs.jasonthom.as/

## Built With

* [VTX_ClientServer](https://github.com/codewar65/VTX_ClientServer) - All of the client side terminal magic.

## Authors

* **Daniel Mecklenburg Jr.** - *Initial work* - [VTX_ClientServer](https://github.com/codewar65/VTX_ClientServer)
* **Jason Thomas** - *NodeJS Version/Packaging (This Project)*

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
