var EnterpriseModule = angular.module("EnterpriseModule", ["MerchantModule"]);

EnterpriseModule.controller("enterprise-controller", function ($scope, $http) {

  $scope.enterprise = {};

  $scope

  $scope.createEnterprise = function (){
    if ($scope.enterprise != null) {
      URL = "/enterprise/create/" + encodeURIComponent(JSON.stringify($scope.enterprise));
      $http.post(URL).success(function (data) {
        console.log(data);
        $scope.initJsonEnterprise();
      });
    }
  };

  $scope.initJsonEnterprise = function () {
    $scope.enterprise = {
      nombreEmpresa : "",
      rfcEmpresa : "",
      regimenEmpresa : "",
      telEmpresa : "",
      tel2Empresa : "",
      mailEmpresa : "",
      webEmpresa : ""
    };
  };

  $scope.initJsonEnterprise();

});
