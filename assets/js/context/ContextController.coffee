angular.module('Context').controller 'ContextController', ['$scope', 'socket', ($scope, socket) ->
	
	$scope.model = {
		rooms : {}
		activeRoom : ""
	}

	###
		Listen for a RoomJoinResponse
	###
	socket.on SocketEvents.RoomJoinResponse, (room) ->

		# Add this room
		$scope.model.rooms[room.name] = room
		$scope.model.activeRoom = room.name

]