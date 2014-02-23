mongoose = require 'mongoose'
crypto = require 'crypto'
Schema = mongoose.Schema

UserSchema = new Schema({
	username : String
	usernameLowercase : String
	password : String
	nickname : String
	knownIps : [{
		ip : String
		lastKnownDate : Date
	}]
	currentRooms : [{
		type: Schema.ObjectId
		ref: 'Room'
	}]
})

hashPassword = (rawPassword) ->
	return crypto.createHash('md5').update(rawPassword).digest('hex')

UserSchema.statics.auth = (username, password, callback) ->
	this.findOne {
		usernameLowercase : username.toLowerCase()
		password : hashPassword(password)
	}, callback

UserSchema.statics.exists = (username, callback) ->
	this.find { username : username }, (err, users) ->
		callback(users.length > 0)

UserSchema.statics.newRegistration = (username, password, passwordConfirm) ->
	return false if password isnt passwordConfirm

	new User({
		username : username
		usernameLowercase : username.toLowerCase()
		password : hashPassword(password)
	}).save()

	return true


User = mongoose.model 'User', UserSchema

module.exports = User