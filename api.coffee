SocketEvents = require('./assets/js/context/SocketEvents')
models = require './models/models'

module.exports = (io) ->

	io.sockets.on 'connection', (socket) ->

		socket.on SocketEvents.UserExistsRequest, (data) ->
			models.User.exists data.username, (exists) ->
				socket.emit SocketEvents.UserExistsResponse, {
					username : data.username
					exists : exists
				}

		socket.on SocketEvents.UserRegistrationRequest, (data) ->
			success = models.User.newRegistration data.username, data.password, data.passwordConfirm

			socket.emit SocketEvents.UserRegistrationResponse, {
				username : data.username
				success : success
			}