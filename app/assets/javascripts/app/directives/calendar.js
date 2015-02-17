angular
  .module('supporthero')
  .directive('calendar', ['Calendar', 'User', function(Calendar, User) {
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
        }

        User
          .current_user()
          .subscribe(function(user) {
            scope.current_user = user;

            console.log(scope.current_user);
          });

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
          });
      }
    }
  }]);
