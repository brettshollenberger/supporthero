angular
  .module('supporthero')
  .directive('nextMonth', [function() {
    return {
      link: function(scope, element, attrs) {
        element.on("click", function() {
          scope.monthNumber += 1;

          if (scope.monthNumber == 13) {
            scope.monthNumber = 1;
            scope.year += 1;
          }

          scope.month = scope.calendar.years[scope.year].months[scope.monthNumber];

          if (scope.monthNumber >= 11) {
            scope.calendar.loadYear(scope.year+1);
          }

          scope.$apply();
        });
      }
    }
  }]);
