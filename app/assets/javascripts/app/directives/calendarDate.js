angular
  .module('supporthero')
  .directive('calendarDate', [function() {
    return {
      templateUrl: "views/directives/calendar_date.html",
      replace: true,
      link: function(scope, element, attrs) {
      }
    }
  }]);
