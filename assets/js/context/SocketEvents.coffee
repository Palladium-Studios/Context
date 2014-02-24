###
	This file is going to be shared between client and server
###

EventNames = [
	"UserUpdate"
	"ActiveRoomChange"
	"RoomJoinRequest"
	"RoomJoinResponse"
	"NewUserInRoom"
	"NewMessage"
]

SocketEvents = {}

for e in EventNames
	SocketEvents[e] = e

# Make sure it's consistently available
[window?.SocketEvents, module?.exports] = [SocketEvents, SocketEvents]