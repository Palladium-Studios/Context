#!/usr/bin/env coffee

# Server configuration settings
settings = {
	port : 3000
	db : 'mongodb://localhost:42069/context'
}

express = require 'express'
app = express()
MongoStore = require('connect-mongo-store')(express)
db = require('mongoose').connect settings.db
passport = require 'passport'
server = require('http').Server(app)
io = require('socket.io').listen(server)
passportSocketIo = require("passport.socketio")

# Create a new session store
ms = new MongoStore settings.db
ms.on 'connect', -> console.log 'Store is ready to use!'
ms.on 'error', (err) -> console.log 'Error: ' + err

app.set 'views', "#{__dirname}/public/views"
app.set 'view engine', 'jade'
app.use express.logger 'dev'
app.use express.bodyParser()
app.use express.cookieParser()
app.use express.session { store : ms, secret: 'notallofthemaretrees' }
app.use express.methodOverride()

app.use require('connect-assets')({
	src : __dirname + "/assets"
	# build : true
})

app.use express.static "#{__dirname}/public"

io.set 'authorization', passportSocketIo.authorize {
	cookieParser: express.cookieParser,
	secret: 'notallofthemaretrees',
	store: ms
	success : (data, accept) ->
		console.log arguments
		accept null, true
}

# Set up routing and socket APIs
require('./api')(io)
require('./routes')(app)

server.listen settings.port

console.log "Context server listening on :#{settings.port}"