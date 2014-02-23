mongoose = require 'mongoose'
Schema = mongoose.Schema

RoomSchema = new Schema({
	name : String
	topic : String
	users : [{
		type: Schema.ObjectId
		ref: 'User'
	}]
	# cards : [{

	# }]
})

###
	Adds a user to this room. Once a user has
	been added, they cannot be removed, only
	their active status in the room can be changed.
###
RoomSchema.statics.addUser = (user, name, callback) ->
	# See if this room already exists
	this.findOne { name : name }, (err, room) ->
		response = null

		if room is null
			# The room does not exist - create it
			room = new Room({
				name : name
			})
		else
			# Keep a reference to it
			response = room

		# Only add them if they are not already in the room
		if room.users.indexOf(user._id) is -1
			# Add our user to the room
			room.users.push user._id
			room.save()

		callback room


Room = mongoose.model 'Room', RoomSchema

module.exports = Room