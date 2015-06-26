var UsersModule = angular.module("UsersModule", []);

UsersModule.controller("UsersController", function ($scope, $http) {
  $scope.init = function (){
    alert("init");
  };
});
