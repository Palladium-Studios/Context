SocketEvents = require('./assets/js/context/SocketEvents')
models = require './models/models'

module.exports = (io) ->

	io.sockets.on 'connection', (socket) ->

		###
			Needs to:
			- Join the room (it will be created if it does not exist)
			- Create or Join the socket.io.room for this room
			- Add the newly joined room to the User model
			- Return the Room data to the calling session
			- Broadcast a User entry event to everyone else
		###
		socket.on SocketEvents.RoomJoinRequest, (data) ->

			# Make a request to join the room
			models.Room.addUser socket.handshake.user, data.roomName, (room) ->
				# Join the room
				socket.join room.name

				# Send the user a response letting them know what's up
				socket.emit SocketEvents.RoomJoinResponse, room

				# Let everyone else know the user is here
				socket.broadcast.to(room.name).emit SocketEvents.NewUserInRoom

		###

		###

