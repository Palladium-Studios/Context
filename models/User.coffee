mongoose = require 'mongoose'
Schema = mongoose.Schema

UserSchema = new Schema({
	username : String
	password : String
	nickname : String
})

exports.User = mongoose.model 'User', UserSchema