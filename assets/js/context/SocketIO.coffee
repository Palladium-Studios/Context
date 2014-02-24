angular.module('Context').factory 'socket', [ '$rootScope', ($rootScope) ->
	socket = io.connect()

	return {
		on: (eventName, callback) ->
			socket.on eventName, () ->
				args = arguments
				$rootScope.$apply () ->
					callback.apply socket, args

		once: (eventName, callback) ->
			socket.once eventName, () ->
				args = arguments
				$rootScope.$apply () ->
					callback.apply socket, args

		emit: (eventName, data, callback) ->
			socket.emit eventName, data, () ->
				args = arguments
				$rootScope.$apply () ->
					callback?.apply socket, args
	}
]