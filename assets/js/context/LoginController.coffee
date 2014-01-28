angular.module('Context').controller 'LoginController', ['$scope', 'User', ($scope, User) ->

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
			# Register a new user
			User.registerNew(username, password, passwordConfirm).then (response) ->
				console.log 'Response: '
				console.log response.data
		else
			User.auth(username, password).then (response) ->
				console.log 'Got it!'
]