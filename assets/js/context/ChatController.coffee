angular.module('Context').controller 'ChatController', ['$scope', 'socket', ($scope, socket) ->
	
	$scope.sendMessage = ->
		socket.emit SocketEvents.NewMessage, {
			roomId : $scope.model.user.activeRoom._id
			messageText : $scope.newMessage
		}

]