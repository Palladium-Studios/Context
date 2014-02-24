mongoose = require 'mongoose'
Schema = mongoose.Schema

RoomSchema = new Schema({
	name : String
	topic : String
	users : [{
		type: Schema.ObjectId
		ref: 'User'
	}]
	messages : [{
		type: Schema.ObjectId
		ref: 'Message'
	}]
})

# We don't want to return a potentially
# enormous amount of messages
# So we trim that
RoomSchema.set 'toJSON', {
    transform: (doc, ret, options) ->
        ret.messages = ret.messages.slice(-100)
        return ret
    }

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

RoomSchema.methods.addMessage = (message) ->
	this.messages.push message._id

RoomSchema.methods.getMessages = (count = 10, page = 0, startId = null) ->


Room = mongoose.model 'Room', RoomSchema

module.exports = Room