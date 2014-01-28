models = require './models/models'
passport = require 'passport'
LocalStrategy = require('passport-local').Strategy;

module.exports = (app) ->

	# Set up all the passport shit
	app.use passport.initialize()
	app.use passport.session()

	passport.serializeUser (user, done) ->
		console.log arguments
		done null, user.username

	passport.deserializeUser (username, done) ->
		models.User.findOne { username: username }, (err, user) ->
			done err, user

	passport.use new LocalStrategy (username, password, done) ->
		models.User.auth username, password, (err, user) ->
			done err, user

	app.post '/api/users/login', passport.authenticate('local', {}), (req, res) ->
		console.log 'Help or Die'

	app.get '/api/users/exists/:username', (req, res) ->
		result = models.User.exists req.params.username, (exists) ->
			response = {
				username : req.params.username
				exists : exists
			}

			res.json response
			res.end()

	app.post '/api/users/register', (req, res) ->
		username = req.body.username
		password = req.body.password
		passwordConfirm = req.body.passwordConfirm

		response = {}

		if password is passwordConfirm
			models.User.newRegistration(username, password)
			response.status = "success"
		else
			response.status = "failed"

		res.json response
		res.end()
