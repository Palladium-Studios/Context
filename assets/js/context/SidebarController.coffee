angular.module('Context').controller 'SidebarController', ['$scope', '$rootScope', 'socket', ($scope, $rootScope, socket) ->

	$scope.joinRoom = ->
		reqData = { roomName : $scope.roomJoinName }
		socket.emit SocketEvents.RoomJoinRequest, reqData

	$scope.changeActiveRoom = (roomId) ->
		# Change our local active room
		$scope.model.user.activeRoom = (room for room in $scope.model.user.rooms when room._id is roomId)[0]

		# Let the server know
		socket.emit SocketEvents.ActiveRoomChange, $scope.model.user.activeRoom._id


]