angular.module('Context').service 'User', ['$http', '$q', 'socket', ($http, $q, socket) ->

	return {
		exists : (username) ->
			return $http.get "/api/users/exists/#{username}"

		registerNew : (username, password, passwordConfirm) ->
			return $http.post '/api/users/register', {
				username : username
				password : password
				passwordConfirm : passwordConfirm
			}

		auth : (username, password) ->
			return $http.post "/api/users/login", {
				username : username
				password : password
			}
	}
]