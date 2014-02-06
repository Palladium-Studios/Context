angular.module('Context').controller 'SidebarController', ['$scope', '$rootScope', ($scope, $rootScope) ->

	$scope.createNewRoom = -> $rootScope.$broadcast 'ctNewRoom'

]