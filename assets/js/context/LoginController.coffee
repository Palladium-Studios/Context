angular.module('Context').controller 'LoginController', ['$scope', 'User', '$window', ($scope, User, $window) ->

	$scope.model = {
		newUser : null
		username : ""
		password : ""
		passwordConfirm : ""
		loggingIn : false
	}

	$scope.checkIsNewUser = () ->
		User.exists($scope.model.username).then (response) ->
			$scope.model.newUser = not response.data.exists

	$scope.usernameValid = ->
		return ($scope.model.username isnt "")

	$scope.passwordValid = ->
		return $scope.model.password isnt ""

	$scope.passwordConfirmValid = ->
		valid = true
		valid &= $scope.model.newUser
		valid &= $scope.model.passwordConfirm isnt ""
		valid &= $scope.model.password is $scope.model.passwordConfirm
		return valid

	$scope.login = ->
		return if $scope.model.newUser is null
		$scope.model.loggingIn = true

		username = $scope.model.username
		password = $scope.model.password
		passwordConfirm = $scope.model.passwordConfirm

		if $scope.model.newUser
			User.registerNew username, password, passwordConfirm, (response) ->
				User.auth(username, password).then (response) ->
					$window.location.href = '/'
		else
			User.auth(username, password).then (response) ->
				if response.data.login is "success"
					console.log 'Success.'
					$window.location.href = '/'
				else
					console.log 'Failed to log in.'
]