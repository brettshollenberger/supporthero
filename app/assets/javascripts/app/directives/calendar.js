angular
  .module('supporthero')
  .directive('calendar', ['Calendar', function(Calendar) {
    return {
      templateUrl: "views/directives/calendar.html",
      link: function(scope, element, attrs) {
        var date = new Date(),
            year = date.getUTCFullYear();

        scope.year     = year;
        scope.calendar = new Calendar();
        scope.month    = 2

        scope.calendar.loadYear(year);
      }
    }
  }]);
