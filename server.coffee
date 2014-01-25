#!/usr/bin/env coffee

express = require 'express'
stylus = require 'stylus'
nib = require 'nib'

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
app.use stylus.middleware {
	src : "#{__dirname}/public"
	compile : (str, path) ->
		return stylus(str).set('filename', path).use(nib()).import('nib')
}
app.use express.static "#{__dirname}/public"

for route in settings.routes
	app.get route.route, (req, res) ->
		res.render route.view, route

app.listen settings.port

console.log "Context server listening on :#{settings.port}"