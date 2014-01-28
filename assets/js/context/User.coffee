angular.module('Context').service 'User', ['$http', '$q', ($http, $q) ->

	return {
		exists : (username) ->
			url = "/api/users/exists/#{username}"
			return $http.get(url)

		registerNew : (username, password, passwordConfirm) ->
			url = "/api/users/register"
			return $http.post url, {
				username : username
				password : password
				passwordConfirm : passwordConfirm
			}

		auth : (username, password) ->
			url = "/api/users/login"
			return $http.post url, {
				username : username
				password : password
			}
	}
]