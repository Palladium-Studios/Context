mongoose = require 'mongoose'
Schema = mongoose.Schema

RoomSchema = new Schema({
	roomName : String
	users : [{
		type: Schema.ObjectId
		ref: 'User'
	}]
	messages : [{
		type : Schema.ObjectId
		ref : 'Message'
	}]
	# cards : [{

	# }]
})

RoomSchema.statics.join = (userName, roomName, callback) ->
	# See if this room already exists
	this.findOne { roomName : roomName }, (err, room) ->
		console.log 'Room result:'
		console.log room

Room = mongoose.model 'Room', RoomSchema

module.exports = Room