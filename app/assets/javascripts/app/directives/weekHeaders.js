angular
  .module('supporthero')
  .directive('weekHeaders', ['Week', function(Week) {
    return {
      templateUrl: "views/directives/week_headers.html",
      link: function(scope, element, attrs) {
        scope.Week = Week;
      }
    }
  }]);
