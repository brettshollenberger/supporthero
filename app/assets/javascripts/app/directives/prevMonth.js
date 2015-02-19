angular
  .module('supporthero')
  .directive('prevMonth', [function() {
    return {
      link: function(scope, element, attrs) {
        element.on("click", function() {
          scope.monthNumber -= 1;
          
          if (scope.monthNumber === 0) {
            scope.monthNumber = 12;
            scope.year -= 1;
          }

          scope.month = scope.calendar.years[scope.year].months[scope.monthNumber];

          if (scope.monthNumber <= 2) {
            scope.calendar.loadYear(scope.year-1);
          }

          scope.$apply();
        });

        scope.noPreviousMonth = function() {
          var monthNumber = scope.monthNumber-1,
              year = scope.year;

          if (monthNumber === 0) {
            monthNumber = 12;
            year -= 1;
          }

          return _.isUndefined(scope.calendar) || _.isEmpty(scope.calendar.years[year].months[monthNumber].dates);
        }
      }
    }
  }]);
