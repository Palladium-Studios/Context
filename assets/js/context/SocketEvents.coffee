###
	This file is going to be shared between client and server
###

SocketEvents = {
	UserExistsRequest : "UserExistsRequest"
	UserExistsResponse : "UserExistsResponse"

	UserRegistrationRequest : "UserRegistrationRequest"
	UserRegistrationResponse : "UserRegistrationResponse"

	UserLoginRequest : "UserLoginRequest"
	UserLoginResponse : "UserLoginResponse"
}

# Make sure it's consistently available
[window?.SocketEvents, module?.exports] = [SocketEvents, SocketEvents]