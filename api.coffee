SocketEvents = require('./assets/js/context/SocketEvents')
models = require './models/models'

module.exports = (io) ->

	io.sockets.on 'connection', (socket) ->

		###
			Initial burst, sending all the immediately needed info
		###
		userUpdate = (callback) ->
			user = socket.handshake.user
			models.User.findOne( { _id : user._id } )
				.populate('rooms')
				.populate('activeRoom')
				.exec (err, user) ->
					socket.emit SocketEvents.UserUpdate, user

					callback() if callback?

		# Call the update immediately on connection
		userUpdate()

		# TODO: Add the user to their active socket room
		# immediately upon connection

		###
			Needs to:
			- Join the room (it will be created if it does not exist)
			- Create or Join the socket.io.room for this room
			- Add the newly joined room to the User model
			- Return the Room data to the calling session
			- Broadcast a User entry event to everyone else
		###
		socket.on SocketEvents.RoomJoinRequest, (data) ->

			models.User.findOne { _id : socket.handshake.user._id }, (err, user) ->

				# Make a request to join the room
				models.Room.addUser user, data.roomName, (room) ->

					# Add the room to this user
					user.addRoom room, () ->

						# Join the room
						socket.join room._id

						# Send the user a response letting them know what's up
						userUpdate()

						# Let everyone else know the user is here
						socket.broadcast.to(room._id).emit SocketEvents.NewUserInRoom

		###
	
		###

