angular.module('Context').controller 'ContextController', ['$scope', 'socket', ($scope, socket) ->
	
	$scope.model = {
		user : null
	}

	###
		Listen for the initial burst of 
		useful data
	###
	socket.on SocketEvents.UserUpdate, (updateInfo) ->
		$scope.model.user = updateInfo
		console.log updateInfo

]