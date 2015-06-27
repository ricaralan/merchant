var MerchantModule = angular.module("MerchantModule", []);

MerchantModule.controller("merchant_controller", function ($scope, $http){

	$scope.touchstartValueX = 0;
	$scope.touchactualValueX = 0;
	$scope.touchendValueX = 0;

	$scope.initToggleButton = function () {
		console.log("initToggleButton");
		button = document.getElementById("toggle-button-left-menu");
		button.addEventListener("click", function () {
			console.log(":v");
			content = document.getElementById("merchant-main-content");
				if (content.className != ("merchant-main-content-on")){
					content.className = "merchant-main-content-on";
				} else {
					content.className = "merchant-main-content-off";
				}
		});
	};

	$scope.initTouchSlideMenuLeft = function () {

		content = document.getElementById("merchant-main-content");

		content.addEventListener("touchstart", function(evt){
			$scope.touchstartValueX = evt.touches[0].clientX;
			$scope.touchactualValueX = 10;
		});

		content.addEventListener("touchmove", function(evt){
			translateX = evt.touches[0].clientX;
			$scope.touchactualValueX = translateX - $scope.touchstartValueX;
			if (translateX > 0 && $scope.touchactualValueX > 0 &&
				($scope.touchactualValueX < 257|| ($scope.touchstartValueX < translateX))){
				content.style.transform = "translateX("+$scope.touchactualValueX+"px)";
			}
			$scope.touchendValueX = translateX;
		});

		content.addEventListener("touchend", function(evt){
			content = document.getElementById("merchant-main-content");
			if ( $scope.touchstartValueX > $scope.touchendValueX) {
				content.style.transform = "translateX(0px)";
			} else {
				content.style.transform = "translateX(257px)";
			}
		});
	};

	$scope.initToggleTopMenu = function () {
		console.log("init");
		dropdown = document.getElementsByClassName("dropdown-menu");
		console.log(dropdown);
		for (var i = 0; i < dropdown.length; i++) {
			var idInnerDown = dropdown[i].getAttribute("dropdownId");
			var innerDropdown = document.getElementById(idInnerDown);
			dropdown[i].addEventListener("click", function () {
				innerDropdown.style.display = "block";
			});
			dropdown[i].addEventListener("focusout", function () {
				setTimeout(function () {
					innerDropdown.style.display = "none";
				}, 200)
			});
		}
		return false;
	};

	$scope.initToggleLeftMenu = function(){
		$scope.initToggleButton();
		$scope.initTouchSlideMenuLeft();
	};

});

MerchantModule.directive("allMerchantContent", function () {
	return {
		restrict : "E",
		transclude : true,
		templateUrl : "/prefab/abstract/all-merchant-content.html"
	};
});

MerchantModule.directive("leftMenuBehindAll", function () {
	return {
		restrict : "E",
		transclude : true,
		templateUrl : "/prefab/abstract/left-menu-behind-all.html"
	};
});

MerchantModule.directive("merchantMainContent", function () {
	return {
		restrict : "E",
		transclude : true,
		templateUrl : "/prefab/abstract/merchant-main-content.html"
	};
});

MerchantModule.directive("merchantTopMenu", function () {
	return {
		restrict : "E",
		transclude : true,
		templateUrl : "/prefab/abstract/merchant-top-menu.html"
	};
});

MerchantModule.directive("merchantContentTopMenu", function () {
	return {
		restrict : "E",
		transclude : true,
		templateUrl : "/prefab/abstract/merchant-content-top-menu.html"
	};
});

MerchantModule.directive("appForUsersMerchant", function () {
	var initLink = function (scope, element, attributes) {
		scope.userPhoto = attributes.userPhoto;
	};
	return {
		restrict : "E",
		transclude : true,
		templateUrl : "/prefab/app-for-users-merchant.html",
		link : initLink
	};
});
