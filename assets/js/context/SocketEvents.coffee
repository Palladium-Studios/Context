###
	This file is going to be shared between client and server
###

SocketEvents = {
	RoomJoinRequest : "RoomJoinRequest"
	RoomJoinResponse : "RoomJoinResponse"

	NewUserInRoom : "NewUserInRoom"
}

# Make sure it's consistently available
[window?.SocketEvents, module?.exports] = [SocketEvents, SocketEvents]