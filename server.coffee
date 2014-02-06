#!/usr/bin/env coffee

express = require 'express'
app = express()
coffeescript = require 'coffee-script'
connectCoffeescript = require 'connect-coffee-script'
passport = require 'passport'
server = require('http').Server(app)
io = require('socket.io').listen(server)

settings = {
	port : 3000
}

app.set 'views', "#{__dirname}/public/views"
app.set 'view engine', 'jade'
app.use express.logger 'dev'
app.use express.bodyParser()
app.use express.cookieParser('notallofthemaretrees')
app.use express.session()
app.use express.methodOverride()

app.use require('connect-assets')({
	src : __dirname + "/assets"
	# build : true
})

# Set up DB connection, set up the API endpoints
require('mongoose').connect 'mongodb://localhost:42069/context'
require('./routes')(app)

app.use express.static "#{__dirname}/public"

app.listen settings.port

console.log "Context server listening on :#{settings.port}"