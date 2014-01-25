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
	]
}

app = express()
app.set 'views', "#{__dirname}/public/views"
app.set 'view engine', 'jade'
app.use express.logger 'dev'
app.use require('connect-assets')({
	src : __dirname + "/assets"
})

app.use express.static "#{__dirname}/public"

for route in settings.routes
	app.get route.route, (req, res) ->
		res.render route.view, route

app.listen settings.port

console.log "Context server listening on :#{settings.port}"