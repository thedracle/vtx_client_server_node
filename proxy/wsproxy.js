/**
 * Very basic NodeJS WebSocket -> TCP Telnet proxy meant to pair with
 * VTXClient.
 *
 * @author Jason Thomas <mail@jasonthom.as>
 */

const WebSocket = require('ws')
const Https = require('https')
const net = require('net')
const Fs = require('fs')

const LISTEN_PORT = process.env.LISTEN_PORT || 7003
const DEST_PORT = process.env.FORWARD_PORT || 44510
const DEST_ADDRESS = process.env.FORWARD_ADDRESS || 'xibalba.l33t.codes'
const SUPPORT_SSL = process.env.SUPPORT_SSL === 'true' || true

let httpsServer = null

// Create a HTTPS server to wrap our websocket in if we are using SSL.
//
// A self signed certificate can be created with mkkeycert.sh for testing.
// but most browsers require a valid CA.
if (SUPPORT_SSL) {
  httpsServer = Https.createServer({
    key: Fs.readFileSync('./cert/server.key'),
    cert: Fs.readFileSync('./cert/server.cert'),
  })
}

let vtxServer = null
if (SUPPORT_SSL) {
  vtxServer = new WebSocket.Server({ server: httpsServer })
} else {
  vtxServer = new WebSocket.Server({ port: LISTEN_PORT })
}

vtxServer.on('connection', function connection(clientConnection) {
  const forwardClient = new net.Socket()
  forwardClient.connect(
    DEST_PORT,
    DEST_ADDRESS,
    () => {
      forwardClient.on('data', data => {
        try {
          clientConnection.send(data)
        } catch (e) {
          forwardClient.end()
        }
      })
      clientConnection.on('message', message => {
        forwardClient.write(message)
      })
    }
  )
})

if (SUPPORT_SSL) {
  httpsServer.listen(LISTEN_PORT)
}