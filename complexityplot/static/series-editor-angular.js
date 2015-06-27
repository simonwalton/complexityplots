angular.module('chart', ['series-editor-django']).
  config(function($routeProvider) {
    $routeProvider.
      when('/', {controller:ListCtrl, templateUrl:static_prefix+'/series-editor-list.html'}).
      when('/edit/:seriesId', {controller:EditCtrl, templateUrl:static_prefix+'/series-editor-edit.html'}).
      when('/new', {controller:CreateCtrl, templateUrl:static_prefix+'/series-editor-edit.html'}).
      otherwise({redirectTo:'/'});
  });

function ListCtrl($scope, Series) {
  $scope.seriess = Series.query();
  $scope.maxDatasets = 8;

	$scope.remove = function(series) {
		if(confirm("Are you sure you wish to delete this series?"))
			series.destroy(function() { $scope.updateAll(); });
	}

	$scope.updateAll = function() {
		console.log("ListCtrl::updateAll()");
		$scope.seriess = Series.query();
		datasets_updated();
	}

	$scope.mouseEnter = function() {
		datasets_mouseenter();
	}

	$scope.canAdd = function() {
		return true;
	}

	datasets_updated();
}


function CreateCtrl($scope, $location, Series) {
  $scope.series = new Series();

  $scope.save = function() {
	$scope.series.create(function() {
      $location.path('/');
    });
  }
 $scope.destroy = function() {
    self.original.destroy(function() {
      $location.path('/');
    });
  };

	if(max_datasets_check())
		$location.path('/');

}


function EditCtrl($scope, $location, $routeParams, Series) {
  var self = this;

  Series.get({id: $routeParams.seriesId}, function(series) {
    self.original = series;
    $scope.series = new Series(self.original);
  });

  $scope.isClean = function() {
    return angular.equals(self.original, $scope.series);
  }

  $scope.destroy = function() {
    self.original.destroy(function() {
      $location.path('/');
    });
  };

  $scope.save = function() {
    $scope.series.update(function() {
      $location.path('/');
    });
  };
}
