mongoose = require 'mongoose'
Schema = mongoose.Schema

MessageSchema = new Schema {
	text : String
	date : Date
	owner : {
		type : Schema.ObjectId
		ref : 'User'
	}
}

Message = mongoose.model 'Message', MessageSchema

module.exports = Message