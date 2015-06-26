var LoginModule = angular.module("LoginModule", []);

LoginModule.controller("LoginController", function ($scope, $http) {

  $scope.existUser = function (){
    if ($scope.user_name!=null && $scope.user_password != null) {
      URL = "/users/existUser/" + encodeURIComponent($scope.user_name) + "/";
      URL += encodeURIComponent($scope.user_password);
      $http.get(URL).success(function (data) {
        if (data.length == 1){
          alert("exito");
        } else {
          alert("usuario o contraseña incorrectas!");
        }
      });
    }
  };

});
