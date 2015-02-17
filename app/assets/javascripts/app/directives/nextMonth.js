angular
  .module('supporthero')
  .directive('nextMonth', [function() {
    return {
      link: function(scope, element, attrs) {
        element.on("click", function() {
          scope.monthNumber += 1;
          scope.month = scope.calendar.years[scope.year].months[scope.monthNumber];
          scope.$apply();
        });
      }
    }
  }]);
