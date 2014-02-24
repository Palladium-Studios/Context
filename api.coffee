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
				.populate('rooms.messages')
				.populate('activeRoom')
				.exec (err, user) ->
					socket.emit SocketEvents.UserUpdate, user

					callback(user) if callback?


		userUpdate (user) ->
			# Call the update immediately on connection
			# and connect them to all their rooms
			for room in user.rooms
				socket.join room._id

		###
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

						# Let everyone else know the user is here
						socket.broadcast.to(room._id).emit SocketEvents.NewUserInRoom

						# Send the user a response letting them know what's up
						userUpdate()

		###
			- Change the user's active room to the one provided
			- Save the User model
		###
		socket.on SocketEvents.ActiveRoomChange, (roomId) ->
			models.User.findOne { _id : socket.handshake.user._id }, (err, user) ->
				user.activeRoom = roomId
				user.save()

		###
			- Creates a new Message
			- Attaches the Message to the Room
			- Broadcasts the message information to the room
			- TODO: Parse the message for card information
		###
		socket.on SocketEvents.NewMessage, (data) ->
			clientsInRoom = io.sockets.clients(data.roomId)

			# Check if the socket is in the room they want to message
			if clientsInRoom.indexOf(socket) isnt -1
				console.log "User can send message to this room."

			# Someone is playing games with me
			else
				console.log "User cannot send message to this room."

