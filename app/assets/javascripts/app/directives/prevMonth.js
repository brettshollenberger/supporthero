angular
  .module('supporthero')
  .directive('prevMonth', [function() {
    return {
      link: function(scope, element, attrs) {
        element.on("click", function() {
          scope.month -= 1;

          if (scope.month <= 2) {
            scope.calendar.loadYear(scope.year-1);
          }

          scope.$apply();
        });
      }
    }
  }]);
