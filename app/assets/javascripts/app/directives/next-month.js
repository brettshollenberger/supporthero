angular
  .module('supporthero')
  .directive('nextMonth', [function() {
    return {
      link: function(scope, element, attrs) {
        element.on("click", function() {
          scope.month += 1;
          scope.$apply();
        });
      }
    }
  }]);
