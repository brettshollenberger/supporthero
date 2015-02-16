angular
  .module('supporthero')
  .directive('calendarDate', [function() {
    return {
      templateUrl: "views/directives/calendar_date.html",
      link: function(scope, element, attrs) {
      }
    }
  }]);
