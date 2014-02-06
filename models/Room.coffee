mongoose = require 'mongoose'
Schema = mongoose.Schema

RoomSchema = new Schema({
	messages : [{
		type : Schema.ObjectId
		ref : 'Message'
	}]
})

Room = mongoose.model 'Room', RoomSchema

module.exports = Room