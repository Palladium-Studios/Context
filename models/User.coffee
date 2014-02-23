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
	rooms : [{
		type: Schema.ObjectId
		ref: 'Room'
	}]
	activeRoom : {
		type: Schema.ObjectId
		ref: 'Room'
	}
})

# Password hash - this should probably be something better later
hashPassword = (rawPassword) ->
	return crypto.createHash('md5').update(rawPassword).digest('hex')

# Set some hidden fields on the user schema
UserSchema.set 'toJSON', {
    transform: (doc, ret, options) ->
        delete ret.password
        delete ret.usernameLowercase
        return ret
    }

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

UserSchema.methods.addRoom = (room, callback) ->

	# Add this room to the user 
	if this.rooms.indexOf(room._id) is -1
		this.rooms.push room._id

	this.save(callback)

User = mongoose.model 'User', UserSchema

module.exports = User