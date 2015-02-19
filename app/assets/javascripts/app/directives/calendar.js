angular
  .module('supporthero')
  .directive('calendar', ['Calendar', function(Calendar) {
    return {
      templateUrl: "views/directives/calendar.html",
      link: function(scope, element, attrs) {
        var date        = new Date(),
            currentDate = date.getDate();

        scope.year        = date.getUTCFullYear();
        scope.monthNumber = date.getMonth() + 1;
        scope.calendar    = new Calendar();

        scope.selectDate = function(date) {
          scope.selectedDate = date;
          scope.monthNumber  = date.month;
          scope.year         = date.year;
          scope.month        = scope.calendar.years[scope.year].months[scope.monthNumber];
        }

        scope.dateHasPassed = function(date) {
          if (_.isUndefined(date)) { return; }

          return !scope.dateHasNotPassed(date);
        }

        scope.dateHasNotPassed = function(date) {
          if (_.isUndefined(date)) { return; }

          var date  = new Date(date.month + "-" + date.day + "-" + date.year),
              today = new Date();

          today.setHours(0, 0, 0, 0);

          return date >= today;
        }

        scope
          .calendar
          .loadYear(scope.year)
          .subscribe(function(year) {
            scope.selectedDate = _.filter(year.months[scope.monthNumber].dates, function(date) { 
              return date.day == currentDate; 
            })[0];

            scope.currentDate = scope.selectedDate;
            scope.month = year.months[scope.monthNumber];
            scope.$apply();

            if (scope.monthNumber <= 2) {
              scope
              .calendar
              .loadYear(scope.year-1)
            }

            if (scope.monthNumber >= 11) {
              scope
              .calendar
              .loadYear(scope.year+1)
            }
          });

      }
    }
  }]);
