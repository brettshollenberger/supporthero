angular
  .module('supporthero')
  .directive('calendar', ['Calendar', function(Calendar) {
    return {
      templateUrl: "views/directives/calendar.html",
      link: function(scope, element, attrs) {
        var date = new Date(),
            year = date.getUTCFullYear();

        scope.calendar = new Calendar();

        scope.calendar.loadYear(year);

        scope.month = 2
      }
    }
  }]);
