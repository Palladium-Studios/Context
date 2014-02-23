angular.module('Context').controller 'SidebarController', ['$scope', '$rootScope', 'socket', ($scope, $rootScope, socket) ->

	$scope.model.roomJoinName = ""

	$scope.joinRoom = ->
		reqData = { roomName : $scope.model.roomJoinName }
		socket.emit SocketEvents.RoomJoinRequest, reqData

]