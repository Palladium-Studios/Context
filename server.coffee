#!/usr/bin/env coffee

express = require 'express'
stylus = require 'stylus'
nib = require 'nib'
coffeescript = require 'coffee-script'
connectCoffeescript = require 'connect-coffee-script'

settings = {
	port : 3000
	routes : [
		{
			title : "Context"
			route : "/"
			view : "index"
		}
		{
			title : "Login or Sign Up"
			route : "/login"
			view : "login"
		}
	]
}

app = express()
app.set 'views', "#{__dirname}/public/views"
app.set 'view engine', 'jade'
app.use express.logger 'dev'
app.use require('connect-assets')({
	src : __dirname + "/assets"
	# build : true
})

app.use express.static "#{__dirname}/public"

for route in settings.routes
	((r) ->
		app.get r.route, (req, res) ->
			res.render r.view, r
	)(route)

app.listen settings.port

console.log "Context server listening on :#{settings.port}"